import 'package:common_presentation/extensions/flutterui_modifiers.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormsPage extends StatelessWidget {
  const FormsPage({super.key});

  FormsNavigator get _navigator => Modular.get();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(locale.forms_home_page)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: _navigator.toMaterialValidation,
            child: Text(locale.forms_material_validation),
          ),
          ElevatedButton(
            onPressed: _navigator.toFormzzValidation,
            child: Text(locale.forms_formzz_validation),
          ),
        ],
      ).padding(all: 8),
    );
  }
}
