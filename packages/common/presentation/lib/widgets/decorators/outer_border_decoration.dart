import 'package:flutter/material.dart';

class OuterBorderDecoration extends Decoration {
  final Color color;
  final double width;
  final double radius;
  final double offset;

  const OuterBorderDecoration({
    required this.color,
    required this.width,
    required this.radius,
    this.offset = 0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _OuterBorderPainter(
      borderColor: color,
      borderWidth: width,
      borderRadius: radius,
      borderOffset: offset,
    );
  }
}

class _OuterBorderPainter extends BoxPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double borderOffset; // Added offset

  _OuterBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderOffset, // Receive offset in painter
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;

    // Adjust the border drawing based on the offset
    final outerRect = Rect.fromLTWH(
      rect.left - borderWidth + borderOffset,
      rect.top - borderWidth + borderOffset,
      rect.width + (borderWidth - borderOffset) * 2,
      rect.height + (borderWidth - borderOffset) * 2,
    );

    final outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(borderRadius),
    );

    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Draw the border with the adjusted offset
    canvas.drawRRect(outerRRect, paint);
  }
}
