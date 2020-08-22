import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/screens/game/game_banner.dart';
import 'package:sudokuplus/screens/game/game_header.dart';
import 'package:sudokuplus/screens/game/powers_pad.dart';
import 'package:sudokuplus/screens/game/sudoku_view.dart';
import 'package:sudokuplus/screens/game/symbols_pad.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:sudokuplus/services/preferences.dart';
import 'package:sudokuplus/services/sudoku.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  //Definitions
  SudokuGrid _grid;
  StreamController<int> _timerController;
  Timer _timer;
  Duration _timerPeriod = const Duration(milliseconds: 1000);
  int _gameDuration = 0;
  bool _isPaused = false;
  GlobalKey<GameHeaderState> _gameHeaderState = GlobalKey<GameHeaderState>();
  int _selectedSymbol = -1;
  GlobalKey<SudokuGridViewState> _gridViewKey;
  int availableCorrect = min(9, Preferences.gameData.correct);
  int availableReveal = min(9, Preferences.gameData.reveal);
  int availableFreeze = min(9, Preferences.gameData.freeze);
  bool completed = false;
  int errors = 0;

  //Lifecycle
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _gridViewKey = GlobalKey<SudokuGridViewState>();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _grid = ModalRoute.of(context).settings.arguments;
    _context = this.context;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    if (_timerController != null) {
      _timerController.close();
      _timerController = null;
    }
    super.dispose();
  }

  //Timer
  int _freeze = 0;
  void _onTick(_) {
    if (_freeze == 0) {
      _gameDuration++;
      _gameHeaderState.currentState?.update(_gameDuration);
    } else {
      _freeze--;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(_timerPeriod, _onTick);
    setState(() => _isPaused = false);
  }

  void _stopTimer() {
    _gameHeaderState.currentState?.update(-1);
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    setState(() => _isPaused = true);
  }

  //Context ! updated in didchangedependencies!!
  BuildContext _context;

  //Build
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool close = await showQuitDialog(_context);
        if (close) {
          await Preferences.updateStats(_grid.level, false);
        }
        return close;
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          color: Colors.transparent,
          elevation: 0.0,
          child: Container(
            color: Theme.of(context).accentColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                GameHeader(
                  key: _gameHeaderState,
                  onPauseRequested: () => _stopTimer(),
                  onResumeRequested: () => _startTimer(),
                  onStopRequested: () async {
                    bool close = await showQuitDialog(_context);
                    if (close) {
                      Navigator.of(_context).pop();
                      await Preferences.updateStats(_grid.level, false);
                    }
                  },
                ),
                Expanded(
                  flex: 1,
                  child: _isPaused
                      ? Center(
                          child: Image.asset(
                            'images/logo.png',
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 100.0,
                          ),
                        )
                      //Game View
                      : Padding(
                          padding: EdgeInsets.all(4.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double _width = constraints.maxWidth;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  //Grid
                                  SudokuGridView(
                                    key: _gridViewKey,
                                    size: _width,
                                    grid: _grid,
                                    onCellSelected: (i, j) {
                                      if (_selectedSymbol >= 1 && _selectedSymbol <= 9) {
                                        _gridViewKey.currentState.setCell(i, j, _selectedSymbol);
                                      }
                                    },
                                    onCellErased: (i, j) {
                                      _gridViewKey.currentState.setCell(i, j, 0);
                                    },
                                    onCompleted: (errors) async {
                                      _stopTimer();
                                      await Preferences.updateStats(_grid.level, errors == 0, duration: _gameDuration);
                                      bool close = await showCompletionDialog(_context, errors);
                                      if (close) {
                                        Navigator.of(_context).pop();
                                      }
                                    },
                                  ),
                                  //SymbolsPad
                                  SymbolsPad(
                                    width: _width,
                                    height: _width / 9,
                                    symbol: _grid.symbol,
                                    onSymbolSelected: (symbol) {
                                      _selectedSymbol = symbol;
                                    },
                                  ),
                                  //PowersPad
                                  PowersPad(
                                    width: _width,
                                    height: _width / 9,
                                    availableCorrect: availableCorrect,
                                    availableReveal: availableReveal,
                                    availableFreeze: availableFreeze,
                                    onCorrect: () {
                                      setState(() => availableCorrect -= 1);
                                      _gridViewKey.currentState.activateCorrect();
                                      Preferences.updatePowersCorrect(-1);
                                    },
                                    onReveal: () {
                                      setState(() => availableReveal -= 1);
                                      _gridViewKey.currentState.activateReveal();
                                      Preferences.updatePowersReveal(-1);
                                    },
                                    onFreeze: () {
                                      _freeze = 9;
                                      Preferences.updatePowersFreeze(-1);
                                      setState(() => availableFreeze -= 1);
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ),
                GameBanner(),
              ],
            ),
          ),
        ),
      ),
    );
  } // Build

  Future<bool> showQuitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).primaryColorDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppLang.of(context).localize('quitgametitle'),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Text(
          AppLang.of(context).localize('quitgamemessage'),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
            color: Colors.transparent,
            splashColor: Colors.white,
            textColor: Theme.of(context).backgroundColor,
            shape: Border.all(
              style: BorderStyle.solid,
              width: 2.0,
              color: Theme.of(context).backgroundColor,
            ),
            child: Text(AppLang.of(context).localize('cancel')),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            color: Theme.of(context).primaryColorLight,
            splashColor: Colors.white,
            textColor: Theme.of(context).primaryColorDark,
            child: Text(AppLang.of(context).localize('agree')),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> showCompletionDialog(BuildContext context, int errors) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            AppLang.of(context).localize('gamecompleted'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Container(
            width: 200.0,
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Icon(
                      errors > 0 ? MdiIcons.emoticonConfused : MdiIcons.emoticonHappy,
                      color: Colors.white,
                      size: 48.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      '($errors) ' + AppLang.of(context).localize('witherrors'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
