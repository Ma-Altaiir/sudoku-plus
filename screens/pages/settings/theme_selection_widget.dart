import 'package:flutter/material.dart';
import 'package:sudokuplus/screens/pages/settings/theme_selectror_widget.dart';
import 'package:sudokuplus/services/lang.dart';

class ThemeSelectionWidget extends StatelessWidget {
  final double _pad = 16.0;
  final SizedBox _hspacing = SizedBox(width: 16.0);
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
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLang.of(context).localize('app_colors'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxHeight * 0.4,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: _pad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 0)),
                  _hspacing,
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 1)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: _pad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 2)),
                  _hspacing,
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 3)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: _pad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 4)),
                  _hspacing,
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 5)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: _pad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 6)),
                  _hspacing,
                  Expanded(flex: 1, child: ThemeSelectorWidget(themeCode: 7)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
