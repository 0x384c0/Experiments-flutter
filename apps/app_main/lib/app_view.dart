import 'package:common_presentation/l10n/app_localizations.g.dart' as common;
import 'package:common_presentation/theme/theme_provider.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart' as forms;
import 'package:features_home_presentation/features_home_presentation.dart' as home;
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart' as reddit_posts;
import 'package:features_weather_presentation/features_weather_presentation.dart' as weather;
import 'package:features_webview_presentation/features_webview_presentation.dart' as web_view;
import 'package:flutter/material.dart';

import 'app_router.dart';

class AppView extends StatelessWidget {
  AppView({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    theme: ThemeProvider.theme,
    routerConfig: _appRouter.config(),
    localizationsDelegates: _localizationsDelegates,
    supportedLocales: _supportedLocales,
  );

  get _localizationsDelegates => const [
    ...forms.AppLocalizations.localizationsDelegates,
    ...reddit_posts.AppLocalizations.localizationsDelegates,
    ...weather.AppLocalizations.localizationsDelegates,
    ...web_view.AppLocalizations.localizationsDelegates,
    ...home.AppLocalizations.localizationsDelegates,
    ...common.AppLocalizations.localizationsDelegates,
  ];

  get _supportedLocales {
    const allValues = [
      ...forms.AppLocalizations.supportedLocales,
      ...reddit_posts.AppLocalizations.supportedLocales,
      ...weather.AppLocalizations.supportedLocales,
      ...web_view.AppLocalizations.supportedLocales,
      ...home.AppLocalizations.supportedLocales,
      ...common.AppLocalizations.supportedLocales,
    ];
    final result = <Locale>[];
    for (final value in allValues) {
      // removing duplicates
      if (result.any((e) => e.languageCode == value.languageCode) == false) {
        result.add(value);
      }
    }
    return result;
  }
}
