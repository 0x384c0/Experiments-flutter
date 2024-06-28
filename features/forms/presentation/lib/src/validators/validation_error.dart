import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ValidationErrorType {
  empty,
  invalid;
}

class CommonValidationError {
  ValidationErrorType validationError;

  CommonValidationError(this.validationError, {this.apiError});

  final String? apiError;

  String errorFieldText(BuildContext context) => AppLocalizations.of(context)!.common_error;

  String emptyFieldText(BuildContext context) => AppLocalizations.of(context)!.common_empty_field;

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
