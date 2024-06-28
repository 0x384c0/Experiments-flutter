import 'package:features_forms_presentation/src/validators/validation_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class Email extends FormzInput<String, EmailValidationError> {
  const Email.dirty(super.value, {this.apiError}) : super.dirty();

  const Email.pure(super.value, {this.apiError}) : super.pure();

  static final _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final String? apiError;

  @override
  EmailValidationError? validator(String value) {
    if (isPure) return null;
    if (apiError?.isNotEmpty == true) return EmailValidationError(ValidationErrorType.invalid, apiError: apiError);
    if (value.isEmpty) return EmailValidationError(ValidationErrorType.empty);
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError(ValidationErrorType.invalid);
  }

  @override
  int get hashCode => Object.hashAll([value, isPure, apiError]);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is Email && other.apiError == apiError && other.value == value && other.isPure == isPure;
  }
}

class EmailValidationError extends CommonValidationError {
  EmailValidationError(super.validationError, {super.apiError});

  @override
  String errorFieldText(BuildContext context) => apiError ?? AppLocalizations.of(context)!.common_invalid_field;
}
