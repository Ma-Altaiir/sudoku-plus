import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:sudokuplus/services/preferences.dart';

class ThemeSelectorWidget extends StatelessWidget {
  final int themeCode;
  const ThemeSelectorWidget({
    this.themeCode,
  });

  @override
  Widget build(BuildContext context) {
    bool selected = Preferences.appSettings.themeCode == this.themeCode;
    SimpleTheme _theme = Preferences.appThemes[this.themeCode];
    double _corners = 4.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        double _width = constraints.maxWidth;
        double _height = constraints.maxHeight;
        double _halfHeight = _height / 2;
        return Container(
          width: _width,
          height: _height,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(Radius.circular(_corners)),
            child: Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.loose,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(flex: 1, child: Container(color: _theme.primary)),
                    Expanded(
                        flex: 1, child: Container(color: _theme.primaryLight)),
                    Expanded(
                        flex: 1,
                        child: Container(color: _theme.backgroundColor)),
                  ],
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: _width,
                  height: selected ? _height : _halfHeight,
                  child: Material(
                    child: InkWell(
                      onTap: selected
                          ? null
                          : () => Preferences.updateTheme(this.themeCode),
                      child: Container(
                        color: _theme.primaryDark,
                        alignment: Alignment.center,
                        child: Text(
                          AppLang.of(context).localizeTheme(this.themeCode),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _halfHeight * 0.5,
                            fontWeight:
                                selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
