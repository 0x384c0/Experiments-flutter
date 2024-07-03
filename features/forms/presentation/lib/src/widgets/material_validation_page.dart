import 'package:common_presentation/extensions/flutterui_modifiers.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_forms_presentation/src/validators/email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MaterialValidationPage extends StatefulWidget {
  const MaterialValidationPage({super.key});

  @override
  createState() => _MaterialValidationPageState();
}

class _MaterialValidationPageState extends State<MaterialValidationPage> {
  final _formKey = GlobalKey<FormState>();
  late final FormsNavigator _navigator = Modular.get();
  final dropdownMenuEntries = List.generate(5, (i) => DropdownMenuEntry(label: "label $i", value: "value $i"));

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(locale.forms_material_validation)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: locale.forms_email),
                validator: (value) {
                  if (value?.isEmpty == true) return locale.common_empty_field;
                  if (!emailRegExp.hasMatch(value!)) return locale.common_invalid_field;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: locale.forms_password),
                validator: (value) {
                  if (value?.isEmpty == true) return locale.common_empty_field;
                  return null;
                },
              ),
              LayoutBuilder(
                builder: (context, constraints) => DropdownMenu(
                  dropdownMenuEntries: dropdownMenuEntries,
                  width: constraints.maxWidth,
                  hintText: "Dropdown picker",
                  inputDecorationTheme: Theme.of(context).inputDecorationTheme,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onSubmit, child: Text(locale.forms_submit)),
            ],
          ).padding(all: 16),
        ),
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) _navigator.back();
  }
}
