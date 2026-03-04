import 'package:auto_route/auto_route.dart';
import 'package:features_forms_presentation/l10n/app_localizations.g.dart';
import 'package:features_forms_presentation/src/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

@RoutePage()
class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final router = AutoRouter.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(title: Text(locale.forms_material_validation), onTap: () => router.push(MaterialValidationRoute())),
        ListTile(title: Text(locale.forms_formzz_validation), onTap: () => router.push(FormzzValidationRoute())),
      ],
    ).padding(all: 8);
  }
}
