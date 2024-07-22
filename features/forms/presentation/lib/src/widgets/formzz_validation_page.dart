import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';
import 'package:features_forms_presentation/src/data/formzz_validation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'form_inputs/check_box_form_input.dart';
import 'form_inputs/radio_form_input.dart';
import 'form_inputs/string_form_input.dart';
import 'formzz_validation_cubit.dart';

class FormzzValidationPage extends StatelessWidget {
  const FormzzValidationPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => FormzzValidationCubit(),
        child: _FormzzValidationView(),
      );
}

class _FormzzValidationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final FormzzValidationCubit cubit = context.watch();
    final formState = cubit.state;
    return Scaffold(
      appBar: AppBar(title: Text(locale.forms_formzz_validation)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                RadioFormInput(
                  text: locale.forms_physical_person,
                  value: EntityType.physicalPerson,
                  groupValue: cubit.state.entityType,
                  onChanged: cubit.onEntityTypeChanged,
                ),
                RadioFormInput(
                  text: locale.forms_legal_entity,
                  value: EntityType.legalEntity,
                  groupValue: cubit.state.entityType,
                  onChanged: cubit.onEntityTypeChanged,
                ),
              ],
            ),
            StringFormField(
              initialValue: formState.firstName.value,
              isRequired: true,
              error: formState.firstName.error?.stringDescription(context),
              onChanged: cubit.onFirstNameChanged,
              label: locale.forms_first_name,
            ),
            if (formState.isValidateCompanyName)
              StringFormField(
                initialValue: formState.companyName.value,
                isRequired: true,
                error: formState.companyName.error?.stringDescription(context),
                onChanged: cubit.onCompanyNameChanged,
                label: locale.forms_company_name,
              ),
            StringFormField(
              initialValue: formState.phone,
              isRequired: false,
              onChanged: cubit.onPhoneChanged,
              label: locale.forms_phone,
            ),
            StringFormField(
              initialValue: formState.email.value,
              isRequired: true,
              error: formState.email.error?.stringDescription(context),
              onChanged: cubit.onEmailChanged,
              label: locale.forms_email,
            ),
            StringFormField(
              initialValue: formState.password.value,
              isRequired: true,
              error: formState.password.error?.stringDescription(context),
              onChanged: cubit.onPasswordChanged,
              label: locale.forms_password,
              hints: const [AutofillHints.newPassword],
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            StringFormField(
              initialValue: formState.repeatPassword.value,
              isRequired: true,
              error: formState.repeatPassword.error?.stringDescription(context),
              onChanged: cubit.onRepeatPasswordChanged,
              label: locale.forms_repeat_password,
              hints: const [AutofillHints.newPassword],
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            CheckBoxFormInput(
              value: cubit.state.userAgreement.value,
              label: Text(locale.forms_agree_to_terms),
              error: cubit.state.userAgreement.error?.stringDescription(context),
              onChanged: cubit.onUserAgreementChanged,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: cubit.onSubmit,
              child: Text(locale.forms_submit),
            ),
            if (cubit.state.isFormHasInvalidFields) ...[
              const SizedBox(height: 16),
              Text(
                locale.forms_form_has_error,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ).padding(all: 16),
      ),
    );
  }
}
