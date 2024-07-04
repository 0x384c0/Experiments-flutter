import 'package:flutter/material.dart';

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController({
    required this.values,
    required this.chipBuilder,
    this.separator,
  }) : super(text: String.fromCharCode(_kObjectReplacementChar) * values.length);

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int _kObjectReplacementChar = 0xFFFE;

  List<T> values;
  final Widget Function(BuildContext context, T data) chipBuilder;
  final Widget? separator;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(_kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(_kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final chipWidgets = separator != null
        ? _buildChipWidgetsWithSeparator(context, values, chipBuilder, separator!)
        : values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: [
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty) TextSpan(text: textWithoutReplacements),
      ],
    );
  }

  _buildChipWidgetsWithSeparator(
    BuildContext context,
    List<T> values,
    Widget Function(BuildContext, T) chipBuilder,
    Widget separator,
  ) {
    List<WidgetSpan> chipWidgets = [];

    for (int i = 0; i < values.length; i++) {
      if (i > 0) {
        chipWidgets.add(WidgetSpan(child: separator));
      }
      chipWidgets.add(WidgetSpan(child: chipBuilder(context, values[i])));
    }

    return chipWidgets;
  }
}
