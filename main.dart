import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudokuplus/app.dart';
import 'package:sudokuplus/services/admob.dart';
import 'package:sudokuplus/services/preferences.dart';
import 'package:sudokuplus/services/sudoku.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Preferences.init();
  await SudokuBackend.init();
  await Admob.init(testing: true);
  runApp(App());
}
