import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class Dimensions extends ThemeExtension<Dimensions> {
  final double small;
  final double medium;
  final double large;

  const Dimensions({
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  Dimensions copyWith({
    double? small,
    double? medium,
    double? large,
  }) {
    return Dimensions(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  @override
  Dimensions lerp(ThemeExtension<Dimensions>? other, double t) {
    if (other is! Dimensions) return this;
    return Dimensions(
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
    );
  }

  static const light = Dimensions(
    small: 8.0,
    medium: 16.0,
    large: 24.0,
  );
}
