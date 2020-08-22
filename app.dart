import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sudokuplus/screens/game/game_screen.dart';
import 'package:sudokuplus/screens/home/home_screen.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:sudokuplus/services/preferences.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppSettings>(
      initialData: Preferences.appSettings,
      stream: Preferences.appSettingsStream,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Preferences.appLanguages[snapshot.data.languageCode],
          supportedLocales: Preferences.appLanguages,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLang.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: Preferences.appThemes[snapshot.data.themeCode].toThemeData(),
          darkTheme: SimpleTheme.dark().toThemeData(),
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/game': (context) => GameScreen(),
          },
        );
      },
    );
  }
}
