import 'package:features_forms_presentation/src/validators/validation_error.dart';
import 'package:formz/formz.dart';

class RequiredBool extends FormzInput<bool, CommonValidationError> {
  const RequiredBool.dirty(super.value) : super.dirty();

  const RequiredBool.pure(super.value) : super.pure();

  @override
  CommonValidationError? validator(bool value) {
    if (isPure) {
      return null;
    }
    return value ? null : CommonValidationError(ValidationErrorType.empty);
  }
}
