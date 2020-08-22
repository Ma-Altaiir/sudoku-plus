import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudokuplus/services/preferences.dart';

// App Localizations
class AppLang {
  // Constructor
  final Locale locale;
  AppLang(this.locale);

  //Helper Context Based Acces
  static AppLang of(BuildContext context) {
    return Localizations.of<AppLang>(
      context,
      AppLang,
    );
  }

  //Localization Delegate
  static const LocalizationsDelegate<AppLang> delegate = _AppLangDelegate();

  // Localized String Values
  Map<String, String> _localizedStrings;
  List<String> _localizedColors;
  List<String> _localizedLanguages;

  Future<void> load() async {
    String jsonText =
        await rootBundle.loadString("lang/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonText);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    _localizedColors = List.generate(Preferences.appThemes.length,
        (index) => _localizedStrings[Preferences.appThemes[index].name]);

    _localizedLanguages = List.generate(Preferences.appLanguagesNames.length,
        (index) => _localizedStrings[Preferences.appLanguagesNames[index]]);
  }

  String localize(String key) => _localizedStrings[key];
  String localizeTheme(int themeCode) => _localizedColors[themeCode];
  String localizeLanguage(int langCode) => _localizedLanguages[langCode];
}

// App Localizations Delegate
class _AppLangDelegate extends LocalizationsDelegate<AppLang> {
  const _AppLangDelegate();

  @override
  bool isSupported(Locale locale) =>
      Preferences.appLanguagesCodes.contains(locale.languageCode);

  @override
  Future<AppLang> load(Locale locale) async {
    AppLang appLang = new AppLang(locale);
    await appLang.load();
    return appLang;
  }

  @override
  bool shouldReload(_AppLangDelegate old) => false;
}
