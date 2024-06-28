import 'package:flutter/material.dart';

class TextFormInput extends StatefulWidget {
  final String title;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool? initialSelectionAtStart;
  final bool? isRequired;
  final String? error;
  final String? hintText;
  final List<String>? hints;
  final bool? obscureText;
  final bool autofocus;
  final TextInputType? keyboardType;

  const TextFormInput({
    Key? key,
    required this.title,
    this.onChanged,
    this.initialValue,
    this.initialSelectionAtStart,
    this.isRequired,
    this.error,
    this.hintText,
    this.hints,
    this.obscureText,
    this.autofocus = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  static const String _requiredSymbol = "*";

  String get title => widget.title;

  Function(String)? get onChanged => widget.onChanged;

  String? get initialValue => widget.initialValue;

  bool? get initialSelectionAtStart => widget.initialSelectionAtStart;

  bool? get isRequired => widget.isRequired;

  String? get error => widget.error;

  String? get hintText => widget.hintText;

  List<String>? get hints => widget.hints;

  bool? get obscureText => widget.obscureText;

  bool get autofocus => widget.autofocus;

  TextInputType? get keyboardType => widget.keyboardType;

  late final TextEditingController _textController = TextEditingController(text: initialValue);

  @override
  void initState() {
    if (initialSelectionAtStart == true) {
      _textController.selection = TextSelection.fromPosition(const TextPosition(offset: 0));
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelText = isRequired == true ? "$title$_requiredSymbol" : title;
    return Semantics(
      excludeSemantics: true,
      textField: true,
      label: title,
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: onChanged != null,
        controller: _textController,
        onChanged: onChanged,
        autofillHints: hints,
        obscureText: obscureText ?? false,
        autofocus: autofocus,
        obscuringCharacter: "*",
        decoration: obscureText == true
            ? InputDecoration(
                labelText: labelText,
                errorText: error,
                hintText: hintText ?? "********",
              )
            : InputDecoration(
                labelText: labelText,
                errorText: error,
              ),
      ),
    );
  }
}
