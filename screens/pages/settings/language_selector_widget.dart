import 'package:flutter/material.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:sudokuplus/services/preferences.dart';

class LanguageSelectorWidget extends StatelessWidget {
  final int languageCode;
  const LanguageSelectorWidget({Key key, this.languageCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool selected = Preferences.appSettings.languageCode == this.languageCode;
    double corners = 4.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: selected
              ? null
              : () => Preferences.updateLanguage(this.languageCode),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(corners)),
              color: selected
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).backgroundColor,
            ),
            child: Material(
              elevation: 0.0,
              color: Colors.transparent,
              child: Text(
                AppLang.of(context).localizeLanguage(this.languageCode),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w600,
                  fontSize: constraints.maxHeight / 2 * 0.8,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
