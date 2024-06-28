import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_forms_presentation/src/data/formzz_validation_state.dart';
import 'package:features_forms_presentation/src/validators/email.dart';
import 'package:features_forms_presentation/src/validators/password.dart';
import 'package:features_forms_presentation/src/validators/repeat_password.dart';
import 'package:features_forms_presentation/src/validators/required_bool.dart';
import 'package:features_forms_presentation/src/validators/required_string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormzzValidationCubit extends Cubit<FormzzValidationState> {
  FormzzValidationCubit() : super(FormzzValidationState.initial());

  late final FormsNavigator _navigator = Modular.get();

  onEntityTypeChanged(EntityType newValue) => emit(state.copyWith(entityType: newValue));

  onFirstNameChanged(String newValue) => emit(state.copyWith(firstName: RequiredString.dirty(newValue)));

  onCompanyNameChanged(String newValue) => emit(state.copyWith(companyName: RequiredString.dirty(newValue)));

  onPhoneChanged(String newValue) => emit(state.copyWith(phone: newValue));

  onEmailChanged(String newValue) => emit(state.copyWith(email: Email.dirty(newValue)));

  onPasswordChanged(String newValue) => emit(state.copyWith(password: Password.dirty(newValue)));

  onUserAgreementChanged(bool newValue) => emit(state.copyWith(userAgreement: RequiredBool.dirty(newValue)));

  onRepeatPasswordChanged(String newValue) => emit(
        state.copyWith(
          repeatPassword: RepeatPassword.dirty(
            newValue,
            password: state.password.value,
          ),
        ),
      );

  bool _validateForm() {
    emit(state.dirtyCopy);
    return !state.isFormHasInvalidFields;
  }

  Future<void> onSubmit() async {
    if (_validateForm()) return await _navigator.back();
  }
}
