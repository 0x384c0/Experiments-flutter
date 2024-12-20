import 'package:flutter/material.dart';

class OuterBorderInputBorder extends InputBorder {
  final Color outerBorderColor;
  final double outerBorderWidth;
  final double outerBorderRadius;
  final double outerBorderOffset;
  final BorderRadius borderRadius;

  const OuterBorderInputBorder({
    required this.outerBorderColor,
    required this.outerBorderWidth,
    required this.outerBorderRadius,
    this.outerBorderOffset = 4.0, // Space between the inner and outer borders
    super.borderSide = const BorderSide(), // Inner border side (default is none)
    this.borderRadius = BorderRadius.zero,
  });

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return OuterBorderInputBorder(
      outerBorderColor: outerBorderColor,
      outerBorderWidth: outerBorderWidth,
      outerBorderRadius: outerBorderRadius,
      outerBorderOffset: outerBorderOffset,
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(outerBorderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.toRRect(rect).deflate(borderSide.width / 2));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.toRRect(rect).inflate(outerBorderOffset + outerBorderWidth / 2));
  }

  @override
  bool get isOutline => true;

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {

    // Draw the outer border
    final outerRect = Rect.fromLTWH(
      rect.left - outerBorderOffset,
      rect.top - outerBorderOffset,
      rect.width + 2 * outerBorderOffset,
      rect.height + 2 * outerBorderOffset,
    );

    final outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(outerBorderRadius));

    final paintOuter = Paint()
      ..color = outerBorderColor
      ..strokeWidth = outerBorderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(outerRRect, paintOuter);

    // Draw the inner border (if any)
    if (borderSide.style != BorderStyle.none) {
      final innerRRect = borderRadius.toRRect(rect).deflate(borderSide.width / 2);
      final paintInner = Paint()
        ..color = borderSide.color
        ..strokeWidth = borderSide.width
        ..style = PaintingStyle.stroke;

      canvas.drawRRect(innerRRect, paintInner);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return OuterBorderInputBorder(
      outerBorderColor: outerBorderColor,
      outerBorderWidth: outerBorderWidth * t,
      outerBorderRadius: outerBorderRadius * t,
      outerBorderOffset: outerBorderOffset * t,
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius,
    );
  }
}
