import 'package:flutter/material.dart';

class ToppingInputChip extends StatelessWidget {
  const ToppingInputChip({
    super.key,
    required this.label,
    this.isShowAvatar = false,
    this.onDeleted,
    this.onSelected,
  });

  final String label;
  final bool isShowAvatar;
  final VoidCallback? onDeleted;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) => InputChip(
        key: ObjectKey(label),
        label: Text(label),
        avatar: isShowAvatar ? CircleAvatar(child: Text(label[0].toUpperCase())) : null,
        onDeleted: onDeleted,
        onSelected: (value) => onSelected?.call(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(2),
      );
}
