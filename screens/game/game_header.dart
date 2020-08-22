import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GameHeader extends StatefulWidget {
  final void Function() onPauseRequested;
  final void Function() onResumeRequested;
  final void Function() onStopRequested;

  const GameHeader({
    Key key,
    this.onPauseRequested,
    this.onResumeRequested,
    this.onStopRequested,
  }) : super(key: key);

  @override
  GameHeaderState createState() => GameHeaderState();
}

class GameHeaderState extends State<GameHeader> {
  int _value = 0;
  int _pauseOnValue = 0;
  void update(int value) {
    setState(() {
      _value = value;
      if (_value > 0) {
        _pauseOnValue = _value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _top = MediaQuery.of(context).padding.top;
    double _partialHeight = AppBar().preferredSize.height;
    double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      height: _top + 3 / 2 * _partialHeight,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: _top + _partialHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22.0),
                bottomRight: Radius.circular(22.0),
              ),
              child: Container(
                color: Theme.of(context).primaryColorDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0.0),
                      width: 56.0,
                      height: 56.0,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0.0),
                        elevation: 0.0,
                        child: Icon(
                          MdiIcons.stopCircle,
                          size: 48.0,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        splashColor: Theme.of(context).accentColor,
                        shape: CircleBorder(),
                        onPressed: widget.onStopRequested,
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Container(
                      width: 56.0,
                      height: 56.0,
                      alignment: Alignment.center,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0.0),
                        elevation: 0.0,
                        child: Icon(
                          _value < 0 ? MdiIcons.playCircle : MdiIcons.pauseCircle,
                          size: 48.0,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        splashColor: Theme.of(context).accentColor,
                        shape: CircleBorder(),
                        onPressed: _value < 0 ? widget.onResumeRequested : widget.onPauseRequested,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: _top + _partialHeight / 2,
            height: _partialHeight,
            width: _width / 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    _value > 0 ? _value.toString() : _pauseOnValue.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _partialHeight * 0.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
