import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_char_limit_texts.dart';

/// Called when the user types (or pastes) past the character limit.
///
/// [message] is the resolved [AppCharLimitTexts.buildReachedMessage] text.
typedef CharLimitReachedCallback =
    void Function(BuildContext context, String message);

/// Remaining-character counter for [AppTextField.buildCounter].
///
/// Pass as `buildCounter: RemainingCharCounter()` together with [maxLength].
/// Hidden until the text reaches 80% of the limit.
///
/// Pass [formatters] as [AppTextField.inputFormatters] so the overflow
/// warning fires only when the user types (or pastes) past [maxLength].
/// By default the warning is a [SnackBar]; pass [onLimitReached] to show
/// it some other way.
class RemainingCharCounter {
  const RemainingCharCounter({
    this.texts,
    this.remainingTextColor,
    this.zeroRemainingColor,
    this.onLimitReached,
  });

  final AppCharLimitTexts? texts;
  final Color? remainingTextColor;
  final Color? zeroRemainingColor;
  final CharLimitReachedCallback? onLimitReached;

  Widget? call(
    BuildContext context, {
    required int currentLength,
    required int? maxLength,
    required bool isFocused,
  }) {
    if (maxLength == null || maxLength <= 0) return null;
    if (currentLength < (maxLength * 0.8).floor()) return null;

    final scheme = Theme.of(context).colorScheme;
    final remainingChars = maxLength - currentLength;
    final limitTexts = texts ?? AppCharLimitTexts.defaults;
    final remainingColor = remainingChars <= 0
        ? (zeroRemainingColor ?? scheme.error)
        : (remainingTextColor ?? scheme.onSurface.withValues(alpha: 0.6));

    return Text(
      limitTexts.buildRemainingMessage(remainingChars),
      textAlign: limitTexts.textAlign ?? TextAlign.end,
      style: Theme.of(
        context,
      ).textTheme.labelSmall?.copyWith(color: remainingColor),
    );
  }

  /// Overflow-warning formatter for [AppTextField.inputFormatters].
  ///
  /// The warning formatter runs before [additional] so length-limiting
  /// formatters cannot swallow the overflow keystroke. If [additional]
  /// includes a tighter [LengthLimitingTextInputFormatter] (e.g. HH:MM),
  /// that cap is used instead of [maxLength].
  List<TextInputFormatter> formatters(
    BuildContext context, {
    required int maxLength,
    List<TextInputFormatter>? additional,
  }) {
    final limit = _tightestMaxLength(maxLength, additional);
    return [
      RemainingCharLimitFormatter(
        maxLength: limit,
        context: context,
        texts: texts,
        onLimitReached: onLimitReached,
      ),
      ...?additional,
    ];
  }
}

int _tightestMaxLength(int maxLength, List<TextInputFormatter>? additional) {
  var limit = maxLength;
  for (final formatter in additional ?? const <TextInputFormatter>[]) {
    if (formatter is! LengthLimitingTextInputFormatter) continue;
    final cap = formatter.maxLength;
    if (cap != null && cap > 0 && cap < limit) {
      limit = cap;
    }
  }
  return limit;
}

/// Shows the char-limit warning when incoming text would exceed [maxLength].
///
/// Runs on text input only, so form rebuilds / submit do not retrigger it.
/// Uses [onLimitReached] when given, otherwise a [SnackBar] on the nearest
/// [ScaffoldMessenger] (no-op if there is none).
class RemainingCharLimitFormatter extends TextInputFormatter {
  RemainingCharLimitFormatter({
    required this.maxLength,
    required this.context,
    this.texts,
    this.onLimitReached,
  });

  final int maxLength;
  final BuildContext context;
  final AppCharLimitTexts? texts;
  final CharLimitReachedCallback? onLimitReached;

  static const _warningDuration = Duration(seconds: 2);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength <= 0) return newValue;

    final oldLength = oldValue.text.length;
    final newLength = newValue.text.length;
    if (newLength > maxLength && newLength > oldLength && context.mounted) {
      final message = (texts ?? AppCharLimitTexts.defaults).buildReachedMessage(
        maxLength,
      );
      if (onLimitReached != null) {
        onLimitReached!(context, message);
      } else {
        ScaffoldMessenger.maybeOf(context)
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(message), duration: _warningDuration),
          );
      }
    }

    return newValue;
  }
}
