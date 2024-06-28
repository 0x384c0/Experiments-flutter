import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidationPage extends StatelessWidget {
  const FormValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(locale.forms_form_validation)),
      body: Center(child: Text(locale.forms_form_validation)),
    );
  }
}
