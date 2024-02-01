import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final Color shadowColor;

  const ShadowContainer({
    super.key,
    required this.child,
    required this.height,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(height / 2)),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 15)],
      ),
      child: child,
    );
  }
}
