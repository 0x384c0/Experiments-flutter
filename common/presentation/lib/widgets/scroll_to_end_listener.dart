import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Usage:
///
/// ScrollToEndListener(
///   onScrolledToEnd: loadNextPage,
///   child: (controller) => ListView.builder(
///     controller: controller,
///     itemCount: itemCount,
///     itemBuilder: (_, index) => ListTile(),
///   ),
/// );
///
class ScrollToEndListener extends StatefulWidget {
  const ScrollToEndListener({
    super.key,
    this.controller,
    required this.onScrolledToEnd,
    required this.child,
  });

  final VoidCallback? onScrolledToEnd;
  final ScrollController? controller;
  final ScrollView Function(ScrollController) child;

  @override
  createState() => _ScrollToEndListenerState();
}

class _ScrollToEndListenerState extends State<ScrollToEndListener> {
  static const _viewportLoadThreshold = 0.4;
  late ScrollController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(() {
      final onScrolledToEnd = widget.onScrolledToEnd;
      if (onScrolledToEnd == null) return;
      final scrollPositionThreshold = clampDouble(
        _controller.position.maxScrollExtent - _controller.position.viewportDimension * _viewportLoadThreshold,
        0,
        _controller.position.maxScrollExtent,
      );
      if (_controller.position.pixels < scrollPositionThreshold) return;
      onScrolledToEnd();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child(_controller);
}
