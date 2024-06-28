import 'package:flutter/material.dart';

class StringFormField extends TextFormField {
  static const String _requiredSymbol = "*";
  static const String _obscuringCharacter = "*";
  static const String _obscuredHint = "******";

  StringFormField({
    super.key,
    required String title,
    Function(String)? onChanged,
    String? initialValue,
    bool? isRequired,
    String? error,
    String? hintText,
    List<String>? hints,
    bool? obscureText,
    bool autofocus = false,
    TextInputType? keyboardType,
  }) : super(
          initialValue: initialValue,
          keyboardType: keyboardType,
          enabled: onChanged != null,
          onChanged: onChanged,
          autofillHints: hints,
          obscureText: obscureText ?? false,
          autofocus: autofocus,
          obscuringCharacter: _obscuringCharacter,
          decoration: obscureText == true
              ? InputDecoration(
                  labelText: isRequired == true ? "$title$_requiredSymbol" : title,
                  errorText: error,
                  hintText: hintText ?? _obscuredHint,
                )
              : InputDecoration(
                  labelText: isRequired == true ? "$title$_requiredSymbol" : title,
                  errorText: error,
                ),
        );
}
