import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart' as forms;
import 'package:features_weather_presentation/features_weather_presentation.dart' as weather;
import 'package:features_webview_presentation/features_webview_presentation.dart' as web_view;
import 'package:features_home_presentation/features_home_presentation.dart' as home;
import 'package:common_presentation/l10n/app_localizations.g.dart' as common;

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[100]),
      routerConfig: Modular.routerConfig,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales);

  get _localizationsDelegates => const [
        ...forms.AppLocalizations.localizationsDelegates,
        ...weather.AppLocalizations.localizationsDelegates,
        ...web_view.AppLocalizations.localizationsDelegates,
        ...home.AppLocalizations.localizationsDelegates,
        ...common.AppLocalizations.localizationsDelegates,
      ];

  get _supportedLocales {
    const allValues = [
      ...forms.AppLocalizations.supportedLocales,
      ...weather.AppLocalizations.supportedLocales,
      ...web_view.AppLocalizations.supportedLocales,
      ...home.AppLocalizations.supportedLocales,
      ...common.AppLocalizations.supportedLocales,
    ];
    final result = <Locale>[];
    for (final value in allValues) { // remove duplicates
      if (result.any((e) => e.languageCode == value.languageCode) == false) {
        result.add(value);
      }
    }
    return result;
  }
}
