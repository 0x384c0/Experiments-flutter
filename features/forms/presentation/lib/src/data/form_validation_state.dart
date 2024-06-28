import 'package:features_forms_presentation/src/validators/email.dart';
import 'package:features_forms_presentation/src/validators/password.dart';
import 'package:features_forms_presentation/src/validators/repeat_password.dart';
import 'package:features_forms_presentation/src/validators/required_bool.dart';
import 'package:features_forms_presentation/src/validators/required_string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_validation_state.freezed.dart';

@freezed
class FormValidationState with _$FormValidationState {
  factory FormValidationState({
    required String profileImagePath,
    required EntityType entityType,
    required String phone,
    required RequiredString firstName,
    required RequiredString companyName,
    required Email email,
    required Password password,
    required RepeatPassword repeatPassword,
    required RequiredBool userAgreement,
  }) = _FormValidationState;

  FormValidationState._();

  factory FormValidationState.initial() => FormValidationState(
        profileImagePath: "",
        entityType: EntityType.physicalPerson,
        phone: "",
        firstName: const RequiredString.pure(""),
        companyName: const RequiredString.pure(""),
        email: const Email.pure(""),
        password: const Password.pure(""),
        repeatPassword: const RepeatPassword.pure("", password: ""),
        userAgreement: const RequiredBool.pure(false),
      );

  FormValidationState get dirtyCopy => copyWith(
        firstName: RequiredString.dirty(firstName.value),
        companyName: RequiredString.dirty(companyName.value),
        email: Email.dirty(password.value),
        password: Password.dirty(password.value),
        repeatPassword: RepeatPassword.dirty(repeatPassword.value, password: password.value),
      );

  bool get formHasInvalidFields => [
        firstName.isValid,
        companyName.isValid,
        email.isValid,
        password.isValid,
        repeatPassword.isValid,
      ].contains(false);
}

enum EntityType { physicalPerson, legalEntity }
