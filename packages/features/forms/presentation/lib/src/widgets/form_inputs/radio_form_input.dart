import 'package:flutter/material.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

class RadioFormInput<T> extends StatelessWidget {
  final String text;
  final T value;
  final T groupValue;
  final Function(T) onChanged;

  const RadioFormInput({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: (T? value) {
            if (value != null) onChanged(value);
          },
        ).withSize(height: 26),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: AlignmentDirectional.centerStart,
          ),
          clipBehavior: Clip.hardEdge,
          onPressed: () {
            onChanged(value);
          },
          child: Text(text, overflow: TextOverflow.fade),
        ).flexible(flex: 1),
      ],
    );
  }
}
