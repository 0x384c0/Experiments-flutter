import 'package:flutter/material.dart';

class StringFormField extends TextFormField {
  static const String _requiredSymbol = "*";
  static const String _obscuringCharacter = "*";
  static const String _obscuredHint = "******";

  StringFormField({
    super.key,
    required String label,
    Function(String)? super.onChanged,
    super.initialValue,
    bool? isRequired,
    String? error,
    String? hintText,
    List<String>? hints,
    bool? obscureText,
    super.autofocus,
    super.keyboardType,
  }) : super(
          enabled: onChanged != null,
          autofillHints: hints,
          obscureText: obscureText ?? false,
          obscuringCharacter: _obscuringCharacter,
          decoration: obscureText == true
              ? InputDecoration(
                  labelText: isRequired == true ? "$label$_requiredSymbol" : label,
                  errorText: error,
                  hintText: hintText ?? _obscuredHint,
                )
              : InputDecoration(
                  labelText: isRequired == true ? "$label$_requiredSymbol" : label,
                  errorText: error,
                ),
        );
}
