import 'package:flutter/material.dart';

class DropdownMenuButton extends StatelessWidget {
  const DropdownMenuButton({
    super.key,
    this.child,
    this.titleString,
    required this.menuChildren,
    this.isFormInput = true,
  });

  final Widget? child;
  final String? titleString;
  final List<Widget> menuChildren;
  final bool isFormInput;

  static final FocusNode _buttonFocusNode = FocusNode(debugLabel: '_buttonFocusNode');

  @override
  Widget build(BuildContext context) => _build(context);

  Widget _build(BuildContext context) => MenuAnchor(
        childFocusNode: _buttonFocusNode,
        menuChildren: menuChildren,
        crossAxisUnconstrained: false,
        builder: (context, controller, _) => OutlinedButton.icon(
          style: OutlinedButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          focusNode: _buttonFocusNode,
          onPressed: () => controller.isOpen ? controller.close() : controller.open(),
          icon: Icon(
            controller.isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
          ),
          iconAlignment: IconAlignment.end,
          label: child ?? _buildTitle(titleString ?? '', context),
        ),
      );

  Widget _buildTitle(String text, BuildContext context) => isFormInput
      ? Row(children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
          )
        ])
      : Text(text, style: Theme.of(context).textTheme.labelLarge);
}
