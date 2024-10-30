import 'package:common_presentation/l10n/app_localizations.g.dart';
import 'package:flutter/material.dart';

extension CommonLocalizationBuildContext on BuildContext {
  AppLocalizations? get commonLocalization => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);
}
