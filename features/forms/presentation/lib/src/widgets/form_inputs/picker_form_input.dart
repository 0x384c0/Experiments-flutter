import 'package:flutter/material.dart';

class PickerFormInput extends StatelessWidget {
  final String label;
  final Function(String?)? onChanged;
  final List<String?> values;
  final String? initialValue;
  final String? hintText;
  final String? error;

  const PickerFormInput({
    super.key,
    required this.label,
    required this.onChanged,
    required this.values,
    this.initialValue,
    this.hintText,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final dropdownMenuEntries = values.map((value) {
      return DropdownMenuEntry<String>(
        value: value ?? "",
        label: value ?? "",
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label,
            style: TextStyle(
              color: onChanged != null ? null : Theme.of(context).disabledColor,
            )),
        const SizedBox(height: 8),
        Stack(alignment: AlignmentDirectional.centerEnd, children: [
          DropdownMenu<String?>(
            key: initialValue == null ? UniqueKey() : null,
            expandedInsets: EdgeInsets.zero,
            initialSelection: initialValue,
            hintText: hintText,
            dropdownMenuEntries: dropdownMenuEntries,
            onSelected: onChanged,
          ),
          const Icon(Icons.arrow_drop_down),
        ]),
        const SizedBox(height: 16),
      ],
    );
  }
}
