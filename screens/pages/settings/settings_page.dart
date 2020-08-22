import 'package:flutter/material.dart';
import 'package:sudokuplus/screens/pages/settings/language_selection_widget.dart';
import 'package:sudokuplus/screens/pages/settings/theme_selection_widget.dart';

class SettingsPage extends StatelessWidget {
  final bool shown;
  const SettingsPage({
    Key key,
    this.shown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: shown ? 1.0 : 0.0,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(flex: 9, child: ThemeSelectionWidget()),
            Expanded(flex: 2, child: LanguageSelectionWidget()),
          ],
        ),
      ),
    );
  }
}
