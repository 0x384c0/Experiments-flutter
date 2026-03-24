import 'package:flutter/material.dart';

class TimeOfDayWithSeconds {
  final int hour;
  final int minute;
  final int second;

  TimeOfDayWithSeconds({
    required this.hour,
    required this.minute,
    required this.second,
  });
}

class SecondsPicker extends StatefulWidget {
  final TimeOfDayWithSeconds initialTime;

  const SecondsPicker({super.key, required this.initialTime});

  @override
  State<SecondsPicker> createState() => _SecondsPickerState();
}

class _SecondsPickerState extends State<SecondsPicker> {
  late int hour;
  late int minute;
  late int second;

  @override
  void initState() {
    super.initState();
    hour = widget.initialTime.hour;
    minute = widget.initialTime.minute;
    second = widget.initialTime.second;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Time (H:M:S)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPickerRow('Hour', hour, 23, (v) => setState(() => hour = v)),
          _buildPickerRow('Min', minute, 59, (v) => setState(() => minute = v)),
          _buildPickerRow('Sec', second, 59, (v) => setState(() => second = v)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            TimeOfDayWithSeconds(hour: hour, minute: minute, second: second),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildPickerRow(
    String label,
    int value,
    int max,
    ValueChanged<int> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: max.toDouble(),
            divisions: max == 0 ? 1 : max,
            onChanged: (v) => onChanged(v.toInt()),
          ),
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(fontFamily: 'monospace'),
        ),
      ],
    );
  }
}
