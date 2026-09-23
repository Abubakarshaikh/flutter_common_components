import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Controls overlay and padding behavior for [AppScaffold].
enum AppScaffoldMode {
  /// Authenticated / main app screens. Overlay flags apply as configured.
  app,

  /// Pre-auth or setup flows (login, onboarding). No body padding.
  guest,
}

/// A [Scaffold] wrapper that can stack an optional [banner] above [body] and
/// pad the body by the ambient [MediaQuery] padding.
class AppScaffold extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;

  /// Defaults to the theme's scaffold background color.
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  /// Optional overlay rendered above [body] (e.g. a status banner).
  /// Null means AppScaffold does not show or decide banners.
  final Widget? banner;

  /// Pads the body by `MediaQuery.of(context).padding`. Ignored in
  /// [AppScaffoldMode.guest].
  final bool bodyBannerSpace;

  /// Scaffold mode (app vs guest overlays).
  final AppScaffoldMode mode;

  const AppScaffold({
    super.key,
    this.mode = AppScaffoldMode.app,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.scaffoldKey,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.banner,
    this.bodyBannerSpace = true,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  bool get _isGuest => widget.mode == AppScaffoldMode.guest;
  bool get _bodyBannerSpace => _isGuest ? false : widget.bodyBannerSpace;

  Widget? _buildBody() {
    final banner = widget.banner;
    final body = widget.body;
    if (banner == null && body == null) return null;

    return Builder(
      builder: (context) {
        final Widget content;
        if (banner != null && body != null) {
          content = Column(
            children: [
              banner,
              Expanded(child: body),
            ],
          );
        } else {
          content = banner ?? body!;
        }

        if (!_bodyBannerSpace) return content;

        return Padding(padding: MediaQuery.of(context).padding, child: content);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: widget.appBar,
      body: _buildBody(),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      drawerScrimColor: widget.drawerScrimColor,
      backgroundColor: widget.backgroundColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      restorationId: widget.restorationId,
    );
  }
}
