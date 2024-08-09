import 'package:common_presentation/extensions/build_context.dart';
import 'package:flutter/material.dart';

enum ValidationErrorType {
  empty,
  invalid;
}

class CommonValidationError {
  ValidationErrorType validationError;

  CommonValidationError(this.validationError, {this.apiError});

  final String? apiError;

  String errorFieldText(BuildContext context) => context.commonLocalization!.common_error;

  String emptyFieldText(BuildContext context) => context.commonLocalization!.common_empty_field;

  String? stringDescription(BuildContext context) {
    if (apiError?.isNotEmpty == true) return apiError;
    switch (validationError) {
      case ValidationErrorType.invalid:
        return errorFieldText(context);
      case ValidationErrorType.empty:
        return emptyFieldText(context);
    }
  }
}
