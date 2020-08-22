import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/lang.dart';

class ResultsWidget extends StatelessWidget {
  final String name;
  final int min;
  final int max;
  final int avg;
  final int played;
  final int solved;
  final int unsolved;

  const ResultsWidget({
    Key key,
    this.name,
    this.min,
    this.max,
    this.avg,
    this.played,
    this.solved,
    this.unsolved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double height = constraints.maxHeight;
            double width = constraints.maxWidth;
            return ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Colors.white,
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Level Label
                    Container(
                      color: Theme.of(context).primaryColorDark,
                      padding: EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      width: 20,
                      height: height,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          AppLang.of(context).localize(name),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                      ),
                    ),
                    //Grids Stats
                    Expanded(
                      flex: 1,
                      child: _ResultsSubWidget(
                        height: height,
                        label: played.toString(),
                        labelgood: solved.toString(),
                        labelbad: unsolved.toString(),
                        icongood: MdiIcons.puzzleCheck,
                        iconbad: MdiIcons.puzzleRemove,
                      ),
                    ),
                    //Divider
                    Container(
                      width: 2.0,
                      height: height - 20.0,
                      color: Theme.of(context).backgroundColor,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    ),
                    //Time Stats
                    Expanded(
                      flex: 1,
                      child: _ResultsSubWidget(
                        height: height,
                        label: avg.toString(),
                        labelgood: min.toString(),
                        labelbad: max.toString(),
                        icongood: MdiIcons.clockCheck,
                        iconbad: MdiIcons.clockAlert,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ResultsSubWidget extends StatelessWidget {
  final double height;
  final String label;
  final String labelgood;
  final String labelbad;
  final IconData icongood;
  final IconData iconbad;

  _ResultsSubWidget({
    Key key,
    this.height,
    this.label,
    this.labelgood,
    this.labelbad,
    this.icongood,
    this.iconbad,
  }) : super(key: key);

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
            child: _Label(
              height: height / 3 * 0.5,
              color: Colors.green.shade700,
              iconData: icongood,
              label: labelgood,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: height / 3,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _Label(
              height: height / 3 * 0.5,
              color: Colors.red.shade700,
              iconData: iconbad,
              label: labelbad,
            ),
          )
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final double height;
  final Color color;
  final IconData iconData;
  final String label;
  const _Label({Key key, this.height, this.color, this.iconData, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Icon(
            iconData,
            color: color,
            size: height,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: color,
              fontSize: height,
            ),
          ),
        ),
      ],
    );
  }
}
