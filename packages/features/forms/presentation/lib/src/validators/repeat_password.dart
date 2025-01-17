import 'package:common_presentation/extensions/build_context_localization.dart';
import 'package:features_forms_presentation/l10n/app_localizations.g.dart';
import 'package:features_forms_presentation/src/validators/validation_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

class RepeatPassword extends FormzInput<String, RepeatPasswordValidationError> {
  const RepeatPassword.dirty(super.value, {required this.password}) : super.dirty();

  const RepeatPassword.pure(super.value, {required this.password}) : super.pure();

  final String password;

  @override
  RepeatPasswordValidationError? validator(String value) {
    if (isPure) return null;
    if (value.isEmpty) return RepeatPasswordValidationError(ValidationErrorType.empty);
    if (password != value) return RepeatPasswordValidationError(ValidationErrorType.invalid);
    return null;
  }
}

class RepeatPasswordValidationError extends CommonValidationError {
  RepeatPasswordValidationError(super.validationError);

  @override
  String errorFieldText(BuildContext context) => AppLocalizations.of(context)!.forms_invalid_field;
}
