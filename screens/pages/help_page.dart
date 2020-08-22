import 'package:flutter/material.dart';
import 'package:sudokuplus/services/lang.dart';

class HelpPage extends StatelessWidget {
  final bool shown;
  const HelpPage({
    Key key,
    this.shown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _titleSize = 22.0;
    double _contentSize = 18.0;
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: shown ? 1.0 : 0.0,
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    AppLang.of(context).localize('game_title'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _titleSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLang.of(context).localize('helpsudokuclassiccontent'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _contentSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    AppLang.of(context).localize('app_title'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _titleSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLang.of(context).localize('helpsudokupluscontent'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _contentSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  //
                  Text(
                    AppLang.of(context).localize('howto'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _titleSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLang.of(context).localize('howtodesc'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _contentSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  //
                  Text(
                    AppLang.of(context).localize('correct'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _titleSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLang.of(context).localize('correctpowerdesc'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _contentSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    AppLang.of(context).localize('reveal'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _titleSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLang.of(context).localize('revealpowerdesc'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _contentSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    AppLang.of(context).localize('freeze'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _titleSize,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLang.of(context).localize('freezepowerdesc'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: _contentSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
