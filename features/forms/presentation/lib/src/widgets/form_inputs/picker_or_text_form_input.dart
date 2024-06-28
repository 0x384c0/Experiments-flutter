import 'package:features_forms_presentation/src/widgets/form_inputs/string_form_input.dart';
import 'package:flutter/material.dart';

import 'picker_form_input.dart';

class PickerOrTextFormInput extends StatelessWidget {
  final List<String>? values;
  final String label;
  final Function(String?)? onChanged;
  final String? initialValue;
  final String? hintText;
  final List<String> hints;

  const PickerOrTextFormInput({
    super.key,
    required this.label,
    required this.onChanged,
    required this.hints,
    this.values,
    this.initialValue,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) => values != null
      ? PickerFormInput(
          initialValue: initialValue?.isEmpty == true ? null : initialValue,
          onChanged: onChanged,
          values: values!,
          label: label,
          hintText: hintText,
        )
      : StringFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          label: label,
          hintText: hintText,
          hints: hints,
        );
}
