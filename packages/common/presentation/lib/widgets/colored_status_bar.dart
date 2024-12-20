import 'package:flutter/material.dart';

class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
    super.key,
    required this.child,
    required this.statusBarColor,
  });

  final Widget child;
  final Color statusBarColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: statusBarColor,
        child: SafeArea(
          left: true,
          right: true,
          bottom: true,
          child: child,
        ));
  }
}
