import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterui_modifiers/flutterui_modifiers.dart';

import 'form_inputs/string_form_input.dart';
import 'form_validation_cubit.dart';

class FormValidationPage extends StatelessWidget {
  const FormValidationPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => FormValidationCubit(),
        child: _FormValidationView(),
      );
}

class _FormValidationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final FormValidationCubit cubit = context.watch();
    final formState = cubit.state;
    return Scaffold(
      appBar: AppBar(title: Text(locale.forms_form_validation)),
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: cubit.onSubmit,
              child: Text(locale.forms_submit),
            ),
          ],
        ).flex(1).padding(all: 16),
      ),
    );
  }
}
