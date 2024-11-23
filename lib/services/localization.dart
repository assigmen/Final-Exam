import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static late Map<String, String> _localizedStrings;

  static Future<void> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  static String? getLocalizedString(String key) {
    return _localizedStrings[key];
  }

  static Map<String, String> getLocalizedStrings(Locale locale) {
    return _localizedStrings;
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'kh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    await AppLocalizations.load(locale);
    return AppLocalizations();
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
