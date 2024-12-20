import 'package:flutter/material.dart';

class CheckBoxFormInput extends StatelessWidget {
  final bool value;
  final Widget label;
  final Function(bool) onChanged;
  final String? error;

  const CheckBoxFormInput({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 24,
                child: Checkbox(
                  value: value,
                  side: error?.isNotEmpty == true
                      ? MaterialStateBorderSide.resolveWith((states) => BorderSide(
                            width: CheckboxTheme.of(context).side?.width ?? 2,
                            color: Theme.of(context).colorScheme.error,
                          ))
                      : null,
                  onChanged: (value) {
                    value != null ? onChanged(value) : null;
                  },
                )),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                onChanged(!value);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: label,
            ),
          ],
        ),
        if (error?.isNotEmpty == true)
          Text(
            error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }
}
