import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  ThemeColors();

  final MaterialColor grey = const MaterialColor(
    0xFF667085,
    {
      50: Color(0xFFF9FAFB),
      100: Color(0xFFF2F4F7),
      200: Color(0xFFEAECF0),
      300: Color(0xFFD0D5DD),
      400: Color(0xFF98A2B3),
      500: Color(0xFF667085),
      600: Color(0xFF475467),
      700: Color(0xFF344054),
      800: Color(0xFF1D2939),
      900: Color(0xFF101828),
    },
  );

  final MaterialColor error = const MaterialColor(
    0xFFB42318,
    {
      50: Color(0xFFFEF3F2),
      100: Color(0xFFFEE4E2),
      200: Color(0xFFFECDCA),
      300: Color(0xFFFDA29B),
      400: Color(0xFFF97066),
      500: Color(0xFFF04438),
      600: Color(0xFFD92D20),
      700: Color(0xFFB42318),
      800: Color(0xFF912018),
      900: Color(0xFF7A271A),
    },
  );

  final MaterialColor success = const MaterialColor(
    0xFF027A48,
    {
      50: Color(0xFFECFDF3),
      100: Color(0xFFD1FADF),
      200: Color(0xFFA6F4C5),
      300: Color(0xFF6CE9A6),
      400: Color(0xFF32D583),
      500: Color(0xFF12B76A),
      600: Color(0xFF039855),
      700: Color(0xFF027A48),
      800: Color(0xFF05603A),
      900: Color(0xFF054F31),
    },
  );

  final MaterialColor primary = const MaterialColor(
    0xFF577589,
    {
      50: Color(0xFFEBF0F4),
      100: Color(0xFFE6EAF0),
      200: Color(0xFFD0D9E3),
      300: Color(0xFFA5B5C8),
      400: Color(0xFF90A3B8),
      500: Color(0xFF7E94AB),
      600: Color(0xFF6B849C),
      700: Color(0xFF577589),
      800: Color(0xFF315773),
      900: Color(0xFF254361),
    },
  );

  late final iconBgColor = grey.shade100;
  final menuSelectedColor = const Color(0xFF31576F);

  @override
  ThemeExtension<ThemeColors> copyWith() => ThemeColors();

  @override
  ThemeExtension<ThemeColors> lerp(covariant ThemeExtension<ThemeColors>? other, double t) => other ?? this;
}
