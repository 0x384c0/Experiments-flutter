import 'package:features_forms_presentation/src/validators/validation_error.dart';
import 'package:formz/formz.dart';

class Password extends FormzInput<String, CommonValidationError> {
  const Password.dirty(super.value, {this.apiError}) : super.dirty();

  const Password.pure(super.value, {this.apiError}) : super.pure();

  final String? apiError;

  @override
  CommonValidationError? validator(String value) {
    if (isPure) return null;
    if (apiError?.isNotEmpty == true) return CommonValidationError(ValidationErrorType.invalid, apiError: apiError);
    return value.isEmpty ? CommonValidationError(ValidationErrorType.empty) : null;
  }

  @override
  int get hashCode => Object.hashAll([value, isPure, apiError]);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is Password && other.apiError == apiError && other.value == value && other.isPure == isPure;
  }
}
