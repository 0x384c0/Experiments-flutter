import 'package:flutter/material.dart';

import '../widgets/outer_border_input_border.dart';
import 'dimensions.dart';
import 'theme_colors.dart';

class ThemeProvider {
  static final theme = ThemeData(
    extensions: [
      _dimensions,
      _colors,
    ],
    colorScheme: _colorScheme,
    appBarTheme: AppBarTheme(
      shadowColor: _colors.grey.shade200,
      surfaceTintColor: _colors.grey.shade50,
      elevation: 1,
    ),
    drawerTheme: const DrawerThemeData(width: double.infinity),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(color: _borderColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(style: _buttonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: _buttonStyle.copyWith(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStatePropertyAll(
          BorderSide(
            width: 1,
            color: _colors.grey.shade300,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: _borderColor),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _borderColor),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      focusedBorder: OuterBorderInputBorder(
        borderSide: BorderSide(color: _borderColor),
        borderRadius: BorderRadius.circular(_borderRadius),
        outerBorderColor: _colors.grey.shade200,
        outerBorderWidth: 4,
        outerBorderRadius: 10,
        outerBorderOffset: 2,
      ),
      contentPadding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      isDense: true,
      suffixIconColor: _colors.grey.shade400,
    ),
    dividerTheme: DividerThemeData(color: _colors.grey.shade200, space: 0, indent: 0, endIndent: 0),
    iconTheme: IconThemeData(color: _colors.grey.shade500),
    menuTheme: const MenuThemeData(
        style: MenuStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        ),
      ),
    )),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: _colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(0),
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: const WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          side: BorderSide(width: 1, color: _borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
        ),
      ),
      constraints: const BoxConstraints.tightFor(height: 44.0),
      hintStyle: WidgetStatePropertyAll(TextStyle(color: _colors.grey.shade500)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (state) => state.contains(WidgetState.selected) ? _colors.primary : Colors.white,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final ColorScheme _colorScheme = ColorScheme.light(
    primary: _colors.primary.shade900,
    secondary: _colors.primary.shade500,
    surface: _colors.grey.shade100,
    tertiary: _colors.success,
    onTertiary: _colors.grey.shade100,
    error: _colors.error,
  );

  static final Color _borderColor = _colors.grey.shade200;

  static const Dimensions _dimensions = Dimensions.light;
  static final ThemeColors _colors = ThemeColors();

  static const double _borderRadius = 8;

  static final ButtonStyle _buttonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
