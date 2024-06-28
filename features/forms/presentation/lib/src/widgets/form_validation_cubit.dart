import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_forms_presentation/src/data/form_validation_state.dart';
import 'package:features_forms_presentation/src/validators/required_string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(FormValidationState.initial());

  late final FormsNavigator _navigator = Modular.get();

  onFirstNameChanged(String newValue) => emit(state.copyWith(firstName: RequiredString.dirty(newValue)));

  bool _validateForm() {
    emit(state.copyWith(
      firstName: RequiredString.dirty(state.firstName.value),
    ));
    final hasInvalidField = [
      state.firstName.isValid,
    ].contains(false);
    return !hasInvalidField;
  }

  Future<void> onSubmit() async {
    if (_validateForm()) {
      return await _navigator.back();
    }
  }
}
