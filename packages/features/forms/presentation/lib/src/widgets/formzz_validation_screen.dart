import 'package:auto_route/auto_route.dart';
import 'package:common_presentation/extensions/build_context_theme.dart';
import 'package:features_forms_presentation/l10n/app_localizations.g.dart';
import 'package:features_forms_presentation/src/data/formzz_validation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

import 'form_inputs/check_box_form_input.dart';
import 'form_inputs/radio_form_input.dart';
import 'form_inputs/string_form_input.dart';
import 'formzz_validation_cubit.dart';

@RoutePage()
class FormzzValidationScreen extends StatelessWidget {
  const FormzzValidationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => FormzzValidationCubit(),
    child: BlocBuilder<FormzzValidationCubit, FormzzValidationState>(builder: _buildScaffold),
  );

  Widget _buildScaffold(BuildContext context, FormzzValidationState formState) {
    final locale = AppLocalizations.of(context)!;
    final FormzzValidationCubit cubit = context.read();

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
                  groupValue: formState.entityType,
                  onChanged: cubit.onEntityTypeChanged,
                ),
                RadioFormInput(
                  text: locale.forms_legal_entity,
                  value: EntityType.legalEntity,
                  groupValue: formState.entityType,
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
            ).paddingOnly(bottom: context.dimensions.medium),
            Visibility(
              visible: formState.isValidateCompanyName,
              child: StringFormField(
                initialValue: formState.companyName.value,
                isRequired: true,
                error: formState.companyName.error?.stringDescription(context),
                onChanged: cubit.onCompanyNameChanged,
                label: locale.forms_company_name,
              ),
            ).paddingOnly(bottom: context.dimensions.medium),
            StringFormField(
              initialValue: formState.phone,
              isRequired: false,
              onChanged: cubit.onPhoneChanged,
              label: locale.forms_phone,
            ).paddingOnly(bottom: context.dimensions.medium),
            StringFormField(
              initialValue: formState.email.value,
              isRequired: true,
              error: formState.email.error?.stringDescription(context),
              onChanged: cubit.onEmailChanged,
              label: locale.forms_email,
            ).paddingOnly(bottom: context.dimensions.medium),
            StringFormField(
              initialValue: formState.password.value,
              isRequired: true,
              error: formState.password.error?.stringDescription(context),
              onChanged: cubit.onPasswordChanged,
              label: locale.forms_password,
              hints: const [AutofillHints.newPassword],
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ).paddingOnly(bottom: context.dimensions.medium),
            StringFormField(
              initialValue: formState.repeatPassword.value,
              isRequired: true,
              error: formState.repeatPassword.error?.stringDescription(context),
              onChanged: cubit.onRepeatPasswordChanged,
              label: locale.forms_repeat_password,
              hints: const [AutofillHints.newPassword],
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ).paddingOnly(bottom: context.dimensions.medium),
            CheckBoxFormInput(
              value: formState.userAgreement.value,
              label: Text(locale.forms_agree_to_terms),
              error: formState.userAgreement.error?.stringDescription(context),
              onChanged: cubit.onUserAgreementChanged,
            ).paddingOnly(bottom: context.dimensions.medium),
            SizedBox(height: context.dimensions.large),
            ElevatedButton(onPressed: () => _onSubmit(context, cubit), child: Text(locale.forms_submit)),
            Visibility(
              visible: formState.isFormHasInvalidFields,
              child: Text(
                locale.forms_form_has_error,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ).paddingOnly(top: context.dimensions.medium),
            ),
          ],
        ).padding(all: context.dimensions.medium),
      ),
    );
  }

  _onSubmit(BuildContext context, FormzzValidationCubit cubit) {
    if (cubit.validateForm()) return AutoRouter.of(context).pop();
  }
}
