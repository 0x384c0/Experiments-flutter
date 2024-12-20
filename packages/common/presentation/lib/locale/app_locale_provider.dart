import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.g.dart';
import 'locale_repository.dart';

/// Usage: ChangeNotifierProvider(create: (context) => localeProvider, child: Consumer<AppLocaleProvider>(builder: SomeLocalizedWidget.new))
class AppLocaleProvider extends ChangeNotifier implements LocaleRepository {
  late Locale _appLocale = _defaultLocale;

  static const String _key = 'language_code';

  Locale get _defaultLocale {
    final platformLocale = PlatformDispatcher.instance.locale;
    final platformLanguageCode = platformLocale.languageCode.substring(0, 2);
    final supportedLocale = supportedLocales.firstWhere(
      (locale) => locale.languageCode == platformLanguageCode,
      orElse: () => supportedLocales.first,
    );
    return supportedLocale;
  }

  Future<String?> _getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_key);
    if (supportedLocales.map((locale) => locale.languageCode).contains(languageCode)) {
      return languageCode;
    } else {
      return _defaultLocale.languageCode;
    }
  }

  Future<Locale> _setLocale(Locale locale) async {
    if (supportedLocales.map((locale) => locale.languageCode).contains(locale.languageCode)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, locale.languageCode);
      return locale;
    } else {
      return _defaultLocale;
    }
  }

  static const List<Locale> supportedLocales = AppLocalizations.supportedLocales;

  Locale get appLocale => _appLocale;

  Future initialize() async {
    final localeCode = await _getLanguageCode();
    if (localeCode != null) {
      _appLocale = Locale(localeCode);
    } else {
      _appLocale = _defaultLocale;
    }
    notifyListeners();
  }

  changeLanguage(Locale type) async {
    if (_appLocale == type) return;
    final savedLocale = await _setLocale(type);
    _appLocale = savedLocale;
    notifyListeners();
  }

  @override
  Map<String, String> get headers => {
        HttpHeaders.acceptLanguageHeader: _appLocale.languageCode,
      };
}
