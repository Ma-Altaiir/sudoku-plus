import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //Private Constructor
  Preferences._private();

  //Declarations
  static SharedPreferences _preferencesController;
  static StreamController _settingsController;
  static AppSettings _appSettings;
  static StreamController _dataController;
  static GameData _gameData;

  //Lifecycle
  static Future<void> init() async {
    _settingsController = StreamController<AppSettings>();
    _dataController = StreamController<GameData>();
    _preferencesController = await SharedPreferences.getInstance();
    int themeCode = _preferencesController.getInt(APP_THEME_CODE) ?? 0;
    int languageCode = _preferencesController.getInt(APP_LANGUAGE_CODE) ?? _preSelectLanguage();
    _privacy = _preferencesController.getBool(PRIVACY);
    _appSettings = AppSettings(themeCode, languageCode);
    _gameData = GameData();
    _gameData.load(_preferencesController);
  }

  static int _preSelectLanguage() {
    String platformLanguageCode = Platform.localeName.substring(0, 2);
    if (appLanguagesCodes.contains(platformLanguageCode)) {
      return appLanguagesCodes.indexOf(platformLanguageCode);
    } else {
      return 0;
    }
  }

  static Future<void> close() async {
    await _settingsController.close();
    _preferencesController = null;
  }

  //Privacy Consent
  static const String PRIVACY_URL = "privacyUrl";
  static const String PRIVACY = "PRIVACY";
  static bool _privacy;
  static bool get privacy => _privacy;
  static Future<void> updatePrivacy(bool agree) async {
    _preferencesController.setBool(PRIVACY, agree);
  }

  //App Settings Stream
  static Stream<AppSettings> get appSettingsStream => _settingsController.stream;

  //Settings
  static const String APP_THEME_CODE = 'APP_THEME_CODE';
  static const String APP_LANGUAGE_CODE = 'APP_LANGUAGE_CODE';

  static AppSettings get appSettings => _appSettings;
  static final List<SimpleTheme> appThemes = [
    SimpleTheme.red(),
    SimpleTheme.green(),
    SimpleTheme.blue(),
    SimpleTheme.pink(),
    SimpleTheme.purple(),
    SimpleTheme.orange(),
    SimpleTheme.brown(),
    SimpleTheme.dark(),
  ];
  static final List<Locale> appLanguages = [
    Locale("en"),
    Locale("fr"),
    Locale("ar"),
  ];
  static final List<String> appLanguagesCodes = [
    "en",
    "fr",
    "ar",
  ];
  static final List<String> appLanguagesNames = [
    "english",
    "french",
    "arabic",
  ];
  static void updateTheme(int newThemeCode, {bool notify = true}) {
    _preferencesController.setInt(APP_THEME_CODE, newThemeCode);
    _appSettings = AppSettings(newThemeCode, _appSettings.languageCode);
    if (notify) _settingsController.add(_appSettings);
  }

  static void updateLanguage(int newLanguageCode, {bool notify = true}) {
    _preferencesController.setInt(APP_LANGUAGE_CODE, newLanguageCode);
    _appSettings = AppSettings(_appSettings.themeCode, newLanguageCode);
    if (notify) _settingsController.add(_appSettings);
  }

  //Game Data
  static Stream<GameData> get gameDataStream => _dataController.stream;
  static GameData get gameData => _gameData;

  static Future<void> updatePowersCorrect(int diff) async {
    _gameData.updatePowerCorrect(_preferencesController, diff);
    _dataController.add(_gameData);
  }

  static Future<void> updatePowersReveal(int diff) async {
    _gameData.updatePowerReveal(_preferencesController, diff);
    _dataController.add(_gameData);
  }

  static Future<void> updatePowersFreeze(int diff) async {
    _gameData.updatePowerFreeze(_preferencesController, diff);
    _dataController.add(_gameData);
  }

  static Future<void> updateEasy(bool solved, {int duration}) async {
    if (solved) {
      await _gameData.updateSolvedEasy(_preferencesController, duration);
    } else {
      await _gameData.updateUnsolvedEasy(_preferencesController);
    }
    _dataController.add(_gameData);
  }

  static Future<void> updateMedium(bool solved, {int duration}) async {
    if (solved) {
      await _gameData.updateSolvedMedium(_preferencesController, duration);
    } else {
      await _gameData.updateUnsolvedMedium(_preferencesController);
    }
    _dataController.add(_gameData);
  }

  static Future<void> updateHard(bool solved, {int duration}) async {
    if (solved) {
      await _gameData.updateSolvedHard(_preferencesController, duration);
    } else {
      await _gameData.updateUnsolvedHard(_preferencesController);
    }
    _dataController.add(_gameData);
  }

  static Future<void> updateExpert(bool solved, {int duration}) async {
    if (solved) {
      await _gameData.updateSolvedExpert(_preferencesController, duration);
    } else {
      await _gameData.updateUnsolvedExpert(_preferencesController);
    }
    _dataController.add(_gameData);
  }

  static Future<void> updateStats(int level, bool solved, {int duration}) async {
    switch (level) {
      case 0:
        await updateEasy(solved, duration: duration);
        break;
      case 1:
        await updateMedium(solved, duration: duration);
        break;
      case 2:
        await updateHard(solved, duration: duration);
        break;
      case 3:
        await updateExpert(solved, duration: duration);
        break;
    }
  }
} //Preferences

class SimpleTheme {
  final String name;
  final Color primaryDark;
  final Color primary;
  final Color primaryLight;
  final Color accentColor;
  final Color backgroundColor;

  SimpleTheme._({
    this.name,
    this.primaryDark,
    this.primary,
    this.primaryLight,
    this.accentColor,
    this.backgroundColor,
  });

  SimpleTheme.red()
      : this._(
          name: 'red',
          primaryDark: Color(0xFF5b0000), //190000),
          primary: Colors.red,
          primaryLight: Colors.red.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.red.shade50,
        );
  SimpleTheme.green()
      : this._(
          name: 'green',
          primaryDark: Color(0xFF002700),
          primary: Colors.green,
          primaryLight: Colors.green.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.green.shade50,
        );
  SimpleTheme.blue()
      : this._(
          name: 'blue',
          primaryDark: Color(0xFF000037),
          primary: Colors.blue,
          primaryLight: Colors.blue.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.blue.shade50,
        );
  SimpleTheme.pink()
      : this._(
          name: 'pink',
          primaryDark: Color(0xFF560027),
          primary: Colors.pink,
          primaryLight: Colors.pink.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.pink.shade50,
        );
  SimpleTheme.purple()
      : this._(
          name: 'purple',
          primaryDark: Color(0xFF38006b),
          primary: Colors.purple,
          primaryLight: Colors.purple.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.purple.shade50,
        );
  SimpleTheme.orange()
      : this._(
          name: 'orange',
          primaryDark: Color(0xFFac1900),
          primary: Colors.orange,
          primaryLight: Colors.orange.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.orange.shade50,
        );
  SimpleTheme.brown()
      : this._(
          name: 'brown',
          primaryDark: Color(0xFF321911),
          primary: Colors.brown,
          primaryLight: Colors.brown.shade100,
          accentColor: Colors.white,
          backgroundColor: Colors.brown.shade50,
        );
  SimpleTheme.dark()
      : this._(
          name: 'dark',
          primaryDark: Color(0xFF373737),
          primary: Colors.grey,
          primaryLight: Colors.grey.shade200,
          accentColor: Colors.white,
          backgroundColor: Colors.grey.shade50,
        );
  ThemeData toThemeData() {
    return ThemeData(
      primaryColorDark: primaryDark,
      primaryColor: primary,
      primaryColorLight: primaryLight,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
    );
  }
}

class AppSettings {
  final int themeCode;
  final int languageCode;
  const AppSettings(this.themeCode, this.languageCode);
}

class GameData {
  static const PWR_COR = "PWR_COR";
  static const PWR_REV = "PWR_REV";
  static const PWR_FRZ = "PWR_FRZ";

  static const STATS_EASY_MIN = "STATS_EASY_MIN";
  static const STATS_EASY_MAX = "STATS_EASY_MAX";
  static const STATS_EASY_AVG = "STATS_EASY_AVG";
  static const STATS_EASY_PLAYED = "STATS_EASY_PLAYED";
  static const STATS_EASY_SOLVED = "STATS_EASY_SOLVED";
  static const STATS_EASY_UNSOLVED = "STATS_EASY_UNSOLVED";

  static const STATS_MEDIUM_MIN = "STATS_MEDIUM_MIN";
  static const STATS_MEDIUM_MAX = "STATS_MEDIUM_MAX";
  static const STATS_MEDIUM_AVG = "STATS_MEDIUM_AVG";
  static const STATS_MEDIUM_PLAYED = "STATS_MEDIUM_PLAYED";
  static const STATS_MEDIUM_SOLVED = "STATS_MEDIUM_SOLVED";
  static const STATS_MEDIUM_UNSOLVED = "STATS_MEDIUM_UNSOLVED";

  static const STATS_HARD_MIN = "STATS_HARD_MIN";
  static const STATS_HARD_MAX = "STATS_HARD_MAX";
  static const STATS_HARD_AVG = "STATS_HARD_AVG";
  static const STATS_HARD_PLAYED = "STATS_HARD_PLAYED";
  static const STATS_HARD_SOLVED = "STATS_HARD_SOLVED";
  static const STATS_HARD_UNSOLVED = "STATS_HARD_UNSOLVED";

  static const STATS_EXPERT_MIN = "STATS_EXPERT_MIN";
  static const STATS_EXPERT_MAX = "STATS_EXPERT_MAX";
  static const STATS_EXPERT_AVG = "STATS_EXPERT_AVG";
  static const STATS_EXPERT_PLAYED = "STATS_EXPERT_PLAYED";
  static const STATS_EXPERT_SOLVED = "STATS_EXPERT_SOLVED";
  static const STATS_EXPERT_UNSOLVED = "STATS_EXPERT_UNSOLVED";

  //Powers
  int correct;
  int reveal;
  int freeze;
  //Stats
  int easymin;
  int easymax;
  int easyavg;
  int easyplayed;
  int easysolved;
  int easyunsolved;

  int mediummin;
  int mediummax;
  int mediumavg;
  int mediumplayed;
  int mediumsolved;
  int mediumunsolved;

  int hardmin;
  int hardmax;
  int hardavg;
  int hardplayed;
  int hardsolved;
  int hardunsolved;

  int expertmin;
  int expertmax;
  int expertavg;
  int expertplayed;
  int expertsolved;
  int expertunsolved;

  void load(SharedPreferences preferences) {
    correct = preferences.getInt(PWR_COR) ?? 0;
    reveal = preferences.getInt(PWR_REV) ?? 0;
    freeze = preferences.getInt(PWR_FRZ) ?? 0;

    easymin = preferences.getInt(STATS_EASY_MIN) ?? 0;
    easymax = preferences.getInt(STATS_EASY_MAX) ?? 0;
    easyavg = preferences.getInt(STATS_EASY_AVG) ?? 0;
    easyplayed = preferences.getInt(STATS_EASY_PLAYED) ?? 0;
    easysolved = preferences.getInt(STATS_EASY_SOLVED) ?? 0;
    easyunsolved = preferences.getInt(STATS_EASY_UNSOLVED) ?? 0;

    mediummin = preferences.getInt(STATS_MEDIUM_MIN) ?? 0;
    mediummax = preferences.getInt(STATS_MEDIUM_MAX) ?? 0;
    mediumavg = preferences.getInt(STATS_MEDIUM_AVG) ?? 0;
    mediumplayed = preferences.getInt(STATS_MEDIUM_PLAYED) ?? 0;
    mediumsolved = preferences.getInt(STATS_MEDIUM_SOLVED) ?? 0;
    mediumunsolved = preferences.getInt(STATS_MEDIUM_UNSOLVED) ?? 0;

    hardmin = preferences.getInt(STATS_HARD_MIN) ?? 0;
    hardmax = preferences.getInt(STATS_HARD_MAX) ?? 0;
    hardavg = preferences.getInt(STATS_HARD_AVG) ?? 0;
    hardplayed = preferences.getInt(STATS_HARD_PLAYED) ?? 0;
    hardsolved = preferences.getInt(STATS_HARD_SOLVED) ?? 0;
    hardunsolved = preferences.getInt(STATS_HARD_UNSOLVED) ?? 0;

    expertmin = preferences.getInt(STATS_EXPERT_MIN) ?? 0;
    expertmax = preferences.getInt(STATS_EXPERT_MAX) ?? 0;
    expertavg = preferences.getInt(STATS_EXPERT_AVG) ?? 0;
    expertplayed = preferences.getInt(STATS_EXPERT_PLAYED) ?? 0;
    expertsolved = preferences.getInt(STATS_EXPERT_SOLVED) ?? 0;
    expertunsolved = preferences.getInt(STATS_EXPERT_UNSOLVED) ?? 0;
  }

  Future<void> updatePowerCorrect(SharedPreferences preferences, int diff) async {
    correct += diff;
    await preferences.setInt(PWR_COR, correct);
  }

  Future<void> updatePowerReveal(SharedPreferences preferences, int diff) async {
    reveal += diff;
    await preferences.setInt(PWR_REV, reveal);
  }

  Future<void> updatePowerFreeze(SharedPreferences preferences, int diff) async {
    freeze += diff;
    await preferences.setInt(PWR_FRZ, freeze);
  }

  Future<void> updateSolvedEasy(SharedPreferences preferences, int duration) async {
    easyplayed += 1;
    easysolved += 1;
    easymin = easymin == 0 ? duration : easymin > duration ? duration : easymin;
    easymax = easymax < duration ? duration : easymax;
    easyavg = ((easyavg * ((easysolved - 1) / easysolved)) + (duration / easysolved)).floor();
    await preferences.setInt(STATS_EASY_MIN, easymin);
    await preferences.setInt(STATS_EASY_MAX, easymax);
    await preferences.setInt(STATS_EASY_AVG, easyavg);
    await preferences.setInt(STATS_EASY_PLAYED, easyplayed);
    await preferences.setInt(STATS_EASY_SOLVED, easysolved);
    await preferences.setInt(STATS_EASY_UNSOLVED, easyunsolved);
  }

  Future<void> updateSolvedMedium(SharedPreferences preferences, int duration) async {
    mediumplayed += 1;
    mediumsolved += 1;
    mediummin = mediummin == 0 ? duration : mediummin > duration ? duration : mediummin;
    mediummax = mediummax < duration ? duration : mediummax;
    mediumavg = ((mediumavg * ((mediumsolved - 1) / mediumsolved)) + (duration / mediumsolved)).floor();
    await preferences.setInt(STATS_MEDIUM_MIN, mediummin);
    await preferences.setInt(STATS_MEDIUM_MAX, mediummax);
    await preferences.setInt(STATS_MEDIUM_AVG, mediumavg);
    await preferences.setInt(STATS_MEDIUM_PLAYED, mediumplayed);
    await preferences.setInt(STATS_MEDIUM_SOLVED, mediumsolved);
    await preferences.setInt(STATS_MEDIUM_UNSOLVED, mediumunsolved);
  }

  Future<void> updateSolvedHard(SharedPreferences preferences, int duration) async {
    hardplayed += 1;
    hardsolved += 1;
    hardmin = hardmin == 0 ? duration : hardmin > duration ? duration : hardmin;
    hardmax = hardmax < duration ? duration : hardmax;
    hardavg = ((hardavg * ((hardsolved - 1) / hardsolved)) + (duration / hardsolved)).floor();
    await preferences.setInt(STATS_HARD_MIN, hardmin);
    await preferences.setInt(STATS_HARD_MAX, hardmax);
    await preferences.setInt(STATS_HARD_AVG, hardavg);
    await preferences.setInt(STATS_HARD_PLAYED, hardplayed);
    await preferences.setInt(STATS_HARD_SOLVED, hardsolved);
    await preferences.setInt(STATS_HARD_UNSOLVED, hardunsolved);
  }

  Future<void> updateSolvedExpert(SharedPreferences preferences, int duration) async {
    expertplayed += 1;
    expertsolved += 1;
    expertmin = expertmin == 0 ? duration : expertmin > duration ? duration : expertmin;
    expertmax = expertmax < duration ? duration : expertmax;
    expertavg = ((expertavg * ((expertsolved - 1) / expertsolved)) + (duration / expertsolved)).floor();
    await preferences.setInt(STATS_EXPERT_MIN, expertmin);
    await preferences.setInt(STATS_EXPERT_MAX, expertmax);
    await preferences.setInt(STATS_EXPERT_AVG, expertavg);
    await preferences.setInt(STATS_EXPERT_PLAYED, expertplayed);
    await preferences.setInt(STATS_EXPERT_SOLVED, expertsolved);
    await preferences.setInt(STATS_EXPERT_UNSOLVED, expertunsolved);
  }

  Future<void> updateUnsolvedEasy(SharedPreferences preferences) async {
    easyplayed += 1;
    easyunsolved += 1;
    await preferences.setInt(STATS_EASY_PLAYED, easyplayed);
    await preferences.setInt(STATS_EASY_UNSOLVED, easyunsolved);
  }

  Future<void> updateUnsolvedMedium(SharedPreferences preferences) async {
    mediumplayed += 1;
    mediumunsolved += 1;
    await preferences.setInt(STATS_MEDIUM_PLAYED, mediumplayed);
    await preferences.setInt(STATS_MEDIUM_UNSOLVED, mediumunsolved);
  }

  Future<void> updateUnsolvedHard(SharedPreferences preferences) async {
    hardplayed += 1;
    hardunsolved += 1;
    await preferences.setInt(STATS_HARD_PLAYED, hardplayed);
    await preferences.setInt(STATS_HARD_UNSOLVED, hardunsolved);
  }

  Future<void> updateUnsolvedExpert(SharedPreferences preferences) async {
    expertplayed += 1;
    expertunsolved += 1;
    await preferences.setInt(STATS_EXPERT_PLAYED, expertplayed);
    await preferences.setInt(STATS_EXPERT_UNSOLVED, expertunsolved);
  }
}
