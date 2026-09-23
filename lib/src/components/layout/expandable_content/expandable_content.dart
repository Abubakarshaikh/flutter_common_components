import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Opt-in wrapper that clips any [child] to [maxLines] and shows a
/// "More Info" / "Less Info" toggle when content overflows.
///
/// This widget does **not** re-render text — it only clips and toggles.
/// Links, markdown, and typography stay the child's responsibility.
///
/// Overflow is based on the child's **rendered line count**, not an
/// estimated height. Content that fits in [maxLines] is shown in full;
/// the toggle appears only when the child paints more lines than that.
///
/// ```dart
/// ExpandableContent(
///   maxLines: 2,
///   child: Text(
///     'Long instructional copy…',
///     style: Theme.of(context).textTheme.bodyMedium,
///   ),
/// );
/// ```
///
/// When [onMoreInfo] is set, tapping "More Info" invokes the callback
/// (typically to open a modal / bottom sheet) instead of expanding inline.
class ExpandableContent extends StatefulWidget {
  const ExpandableContent({
    required this.child,
    super.key,
    this.maxLines = 2,
    this.onMoreInfo,
    this.moreStyle,
    this.lessStyle,
    this.moreLabel = 'More Info',
    this.lessLabel = 'Less Info',
  });

  /// Lines shown while collapsed. The toggle appears only when the child
  /// renders more than this many lines.
  final int maxLines;

  /// Optional tap handler for "More Info" (e.g. open a details sheet).
  /// When set, the content stays collapsed and the callback is invoked.
  final VoidCallback? onMoreInfo;

  /// Style for the "More Info" label. Defaults to an underlined, bold label
  /// in [ColorScheme.onSurface].
  final TextStyle? moreStyle;

  /// Style for the "Less Info" label. Defaults to [moreStyle] / built-in toggle.
  final TextStyle? lessStyle;

  /// Toggle label shown while collapsed.
  final String moreLabel;

  /// Toggle label shown while expanded.
  final String lessLabel;

  final Widget child;

  /// Toggle link style that inherits [base] font metrics when provided.
  ///
  /// When [color] is null the label inherits the ambient text color.
  static TextStyle defaultToggleStyleFor([TextStyle? base, Color? color]) {
    final TextStyle resolved = base ?? const TextStyle();
    return resolved.copyWith(
      fontSize: 16.0,
      color: color,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
      decorationColor: color,
    );
  }

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  final GlobalKey _childKey = GlobalKey();

  bool _isExpanded = false;
  bool _hasMeasured = false;
  bool _overflows = false;
  double? _collapsedHeight;
  double? _expandedHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _recomputeOverflow());
  }

  @override
  void didUpdateWidget(covariant ExpandableContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child ||
        oldWidget.maxLines != widget.maxLines) {
      _hasMeasured = false;
      _collapsedHeight = null;
      _expandedHeight = null;
      WidgetsBinding.instance.addPostFrameCallback((_) => _recomputeOverflow());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _recomputeOverflow());
  }

  void _recomputeOverflow() {
    if (!mounted) return;

    final BuildContext? childContext = _childKey.currentContext;
    if (childContext == null) return;

    final RenderObject? renderObject = childContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final _LineLayout layout = _measureLines(renderObject, widget.maxLines);
    // Trailing line breaks are trimmed so they cannot inflate the count or
    // leave a blank row sitting above "More Info" / "Less Info".
    final bool overflows = layout.lineCount > widget.maxLines;

    if (!_hasMeasured ||
        _overflows != overflows ||
        _collapsedHeight != layout.heightAtMaxLines ||
        _expandedHeight != layout.heightAtContentEnd) {
      setState(() {
        _hasMeasured = true;
        _overflows = overflows;
        _collapsedHeight = layout.heightAtMaxLines;
        _expandedHeight = layout.heightAtContentEnd;
      });
    }
  }

  _LineLayout _measureLines(RenderBox root, int maxLines) {
    final List<_MeasuredLine> lines = <_MeasuredLine>[];
    final Offset rootOrigin = root.localToGlobal(Offset.zero);

    void visit(RenderObject object) {
      if (object is RenderParagraph) {
        for (final _ParagraphLine line in _paragraphLines(object)) {
          final Offset global = object.localToGlobal(Offset(0, line.bottom));
          lines.add(
            _MeasuredLine(
              bottomInRoot: global.dy - rootOrigin.dy,
              isBlank: line.isBlank,
            ),
          );
        }
        return;
      }
      object.visitChildren(visit);
    }

    visit(root);

    int lineCount = lines.length;
    while (lineCount > 0 && lines[lineCount - 1].isBlank) {
      lineCount--;
    }

    double? heightAtMaxLines;
    final int visibleLimit = maxLines < lines.length ? maxLines : lines.length;
    for (int i = visibleLimit - 1; i >= 0; i--) {
      if (!lines[i].isBlank) {
        heightAtMaxLines = lines[i].bottomInRoot;
        break;
      }
    }

    return _LineLayout(
      lineCount: lineCount,
      heightAtMaxLines: heightAtMaxLines,
      heightAtContentEnd: lineCount > 0
          ? lines[lineCount - 1].bottomInRoot
          : null,
    );
  }

  List<_ParagraphLine> _paragraphLines(RenderParagraph paragraph) {
    if (!paragraph.hasSize) return const [];

    final String plain = paragraph.text.toPlainText();
    final TextPainter painter = TextPainter(
      text: paragraph.text,
      textAlign: paragraph.textAlign,
      textDirection: paragraph.textDirection,
      textScaler: paragraph.textScaler,
      strutStyle: paragraph.strutStyle,
    )..layout(maxWidth: paragraph.size.width);

    try {
      final List<LineMetrics> metrics = painter.computeLineMetrics();
      if (metrics.isEmpty) {
        if (paragraph.size.height <= 0) return const [];
        return [
          _ParagraphLine(
            bottom: paragraph.size.height,
            isBlank: plain.trim().isEmpty,
          ),
        ];
      }

      return [
        for (final LineMetrics line in metrics)
          _ParagraphLine(
            bottom: line.baseline - line.ascent + line.height,
            isBlank: _lineIsBlank(painter, plain, line),
          ),
      ];
    } finally {
      painter.dispose();
    }
  }

  bool _lineIsBlank(TextPainter painter, String plain, LineMetrics line) {
    if (line.width < 1) return true;

    final TextRange boundary = painter.getLineBoundary(
      painter.getPositionForOffset(Offset(line.left, line.baseline)),
    );
    if (boundary.start < 0 ||
        boundary.end < 0 ||
        boundary.end <= boundary.start) {
      return true;
    }
    final int start = boundary.start.clamp(0, plain.length);
    final int end = boundary.end.clamp(0, plain.length);
    if (end <= start) return true;
    return plain.substring(start, end).trim().isEmpty;
  }

  double _fallbackCollapsedHeight(BuildContext context) {
    final TextStyle style = DefaultTextStyle.of(context).style;
    final TextPainter painter = TextPainter(
      text: TextSpan(text: 'Ag', style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    final double height = painter.preferredLineHeight * widget.maxLines;
    painter.dispose();
    return height;
  }

  void _onToggle() {
    if (widget.onMoreInfo != null) {
      if (!_isExpanded) {
        widget.onMoreInfo!();
      } else {
        setState(() => _isExpanded = false);
      }
      return;
    }

    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    // Clip on the first frame (before line count is known) so a tall child
    // cannot overflow the parent. After measuring, clip collapsed content to
    // [maxLines] and expanded content to the last non-blank line so trailing
    // line breaks do not sit above "More Info" / "Less Info".
    final double? clipHeight = !_isExpanded
        ? (_collapsedHeight ?? _fallbackCollapsedHeight(context))
        : _expandedHeight;
    final bool shouldClip =
        clipHeight != null &&
        ((!_isExpanded && (!_hasMeasured || _overflows)) ||
            (_isExpanded && _overflows));
    final TextStyle defaultToggle = ExpandableContent.defaultToggleStyleFor(
      null,
      Theme.of(context).colorScheme.onSurface,
    );
    final TextStyle toggleStyle = _isExpanded
        ? (widget.lessStyle ?? widget.moreStyle ?? defaultToggle)
        : (widget.moreStyle ?? defaultToggle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRect(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: shouldClip ? clipHeight : double.infinity,
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: KeyedSubtree(key: _childKey, child: widget.child),
            ),
          ),
        ),
        if (_overflows)
          GestureDetector(
            onTap: _onToggle,
            behavior: HitTestBehavior.opaque,
            child: Text(
              _isExpanded ? widget.lessLabel : widget.moreLabel,
              style: toggleStyle,
            ),
          ),
      ],
    );
  }
}

class _LineLayout {
  const _LineLayout({
    required this.lineCount,
    required this.heightAtMaxLines,
    required this.heightAtContentEnd,
  });

  final int lineCount;
  final double? heightAtMaxLines;
  final double? heightAtContentEnd;
}

class _MeasuredLine {
  const _MeasuredLine({required this.bottomInRoot, required this.isBlank});

  final double bottomInRoot;
  final bool isBlank;
}

class _ParagraphLine {
  const _ParagraphLine({required this.bottom, required this.isBlank});

  final double bottom;
  final bool isBlank;
}
