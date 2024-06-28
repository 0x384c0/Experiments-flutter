import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

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
            StringFormField(
              initialValue: formState.firstName.value,
              isRequired: true,
              error: formState.firstName.error?.stringDescription(context),
              onChanged: cubit.onFirstNameChanged,
              title: locale.forms_first_name,
            ),
            StringFormField(
              initialValue: formState.companyName.value,
              isRequired: true,
              error: formState.companyName.error?.stringDescription(context),
              onChanged: cubit.onCompanyNameChanged,
              title: locale.forms_company_name,
            ),
            StringFormField(
              initialValue: formState.phone,
              isRequired: false,
              onChanged: cubit.onPhoneChanged,
              title: locale.forms_phone,
            ),
            StringFormField(
              initialValue: formState.email.value,
              isRequired: true,
              error: formState.email.error?.stringDescription(context),
              onChanged: cubit.onEmailChanged,
              title: locale.forms_email,
            ),
            StringFormField(
              initialValue: formState.password.value,
              isRequired: true,
              error: formState.password.error?.stringDescription(context),
              onChanged: cubit.onPasswordChanged,
              title: locale.forms_password,
              hints: const [AutofillHints.newPassword],
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            StringFormField(
              initialValue: formState.repeatPassword.value,
              isRequired: true,
              error: formState.repeatPassword.error?.stringDescription(context),
              onChanged: cubit.onRepeatPasswordChanged,
              title: locale.forms_repeat_password,
              hints: const [AutofillHints.newPassword],
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: cubit.onSubmit,
              child: Text(locale.forms_submit),
            ),
            if (cubit.state.formHasInvalidFields) ...[
              const SizedBox(height: 16),
              Text(
                locale.forms_form_has_error,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ).flex(1).padding(all: 16),
      ),
    );
  }
}
