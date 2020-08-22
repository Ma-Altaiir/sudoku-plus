import 'package:flutter/material.dart';
import 'package:sudokuplus/screens/pages/results/powers_widget.dart';
import 'package:sudokuplus/screens/pages/results/results_widget.dart';
import 'package:sudokuplus/services/preferences.dart';

class ResultsPage extends StatelessWidget {
  final bool shown;
  const ResultsPage({
    Key key,
    this.shown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: shown ? 1.0 : 0.0,
      child: StreamBuilder<GameData>(
          initialData: Preferences.gameData,
          stream: Preferences.gameDataStream,
          builder: (context, snapshot) {
            return Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ResultsWidget(
                      name: 'easy',
                      min: snapshot.data.easymin,
                      max: snapshot.data.easymax,
                      avg: snapshot.data.easyavg,
                      played: snapshot.data.easyplayed,
                      solved: snapshot.data.easysolved,
                      unsolved: snapshot.data.easyunsolved,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ResultsWidget(
                      name: 'medium',
                      min: snapshot.data.mediummin,
                      max: snapshot.data.mediummax,
                      avg: snapshot.data.mediumavg,
                      played: snapshot.data.mediumplayed,
                      solved: snapshot.data.mediumsolved,
                      unsolved: snapshot.data.mediumunsolved,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ResultsWidget(
                      name: 'hard',
                      min: snapshot.data.hardmin,
                      max: snapshot.data.hardmax,
                      avg: snapshot.data.hardavg,
                      played: snapshot.data.hardplayed,
                      solved: snapshot.data.hardsolved,
                      unsolved: snapshot.data.hardunsolved,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ResultsWidget(
                      name: 'expert',
                      min: snapshot.data.expertmin,
                      max: snapshot.data.expertmax,
                      avg: snapshot.data.expertavg,
                      played: snapshot.data.expertplayed,
                      solved: snapshot.data.expertsolved,
                      unsolved: snapshot.data.expertunsolved,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PowersWidget(
                      correct: snapshot.data.correct,
                      reveal: snapshot.data.reveal,
                      freeze: snapshot.data.freeze,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
