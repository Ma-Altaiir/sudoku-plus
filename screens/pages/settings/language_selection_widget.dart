import 'package:flutter/material.dart';
import 'package:sudokuplus/screens/pages/settings/language_selector_widget.dart';
import 'package:sudokuplus/services/lang.dart';

class LanguageSelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(0.0),
                    margin: EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    child: Text(
                      AppLang.of(context).localize('app_languages'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxHeight * 0.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: LanguageSelectorWidget(languageCode: 0),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    flex: 1,
                    child: LanguageSelectorWidget(languageCode: 1),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    flex: 1,
                    child: LanguageSelectorWidget(languageCode: 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
