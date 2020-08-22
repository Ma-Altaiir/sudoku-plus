import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/preferences.dart';

class SudokuBackend {
  SudokuBackend._private();
  static const SudokuLevelsNames = ['easy', 'medium', 'hard', 'expert'];
  static const SudokuSymbolsNames = ['digits', 'letters', 'colors', 'icons'];
  static final List<IconData> sudokuDigitsSymbols = [
    MdiIcons.numeric1,
    MdiIcons.numeric2,
    MdiIcons.numeric3,
    MdiIcons.numeric4,
    MdiIcons.numeric5,
    MdiIcons.numeric6,
    MdiIcons.numeric7,
    MdiIcons.numeric8,
    MdiIcons.numeric9,
  ];
  static final List<IconData> sudokuLettersSymbols = [
    MdiIcons.alphaA,
    MdiIcons.alphaB,
    MdiIcons.alphaC,
    MdiIcons.alphaD,
    MdiIcons.alphaE,
    MdiIcons.alphaF,
    MdiIcons.alphaG,
    MdiIcons.alphaH,
    MdiIcons.alphaI,
  ];
  static final List<MaterialColor> sudokuColorsSymbols = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.lime,
    Colors.purple,
    Colors.pink,
    Colors.blueGrey,
    Colors.brown,
  ];
  static final List<IconData> sudokuIconsSymbols = [
    MdiIcons.cat,
    MdiIcons.dog,
    MdiIcons.rodent,
    MdiIcons.panda,
    MdiIcons.pig,
    MdiIcons.duck,
    MdiIcons.fish,
    MdiIcons.spider,
    MdiIcons.ladybug,
  ];

  static int _authattempts = 0;
  static Future<void> init() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      await Firestore.instance.settings(persistenceEnabled: false);
    } catch (error) {
      Future.delayed(Duration(seconds: 1), () {
        if (_authattempts == 3) {
          exit(0);
        }
        _authattempts++;
        init();
      });
    }
  }

  static Future<SudokuGrid> getSudokuGrid(int level, int symbol) async {
    int playedGrids = 0;
    String levelCollection = '';
    switch (level) {
      case 0:
        levelCollection = 'easy';
        playedGrids = Preferences.gameData.easyplayed;
        break;
      case 1:
        levelCollection = 'medium';
        playedGrids = Preferences.gameData.mediumplayed;
        break;
      case 2:
        levelCollection = 'hard';
        playedGrids = Preferences.gameData.hardplayed;
        break;
      case 3:
        levelCollection = 'expert';
        playedGrids = Preferences.gameData.expertplayed;
        break;
      default:
        levelCollection = 'easy';
        playedGrids = Preferences.gameData.easyplayed;
        break;
    }
    String docId = (playedGrids + 1).toString().padLeft(6, '0');
    try {
      DocumentSnapshot snapshot = await Firestore.instance.document('documentpath/docId').get(source: Source.server);
      Map<String, dynamic> data = snapshot.data;
      if (data != null) {
        return SudokuGrid(
          level: level,
          symbol: symbol,
          id: playedGrids + 1,
          puzzle: data['puzzle'],
          solution: data['solution'],
        );
      } else {
        return SudokuGrid.test(level, symbol);
      }
    } catch (error) {
      return SudokuGrid.test(level, symbol);
    }
  }
}

class SudokuGrid {
  final int level;
  final int symbol;
  final int id;
  final String puzzle;
  final String solution;

  List<List<int>> puzzleGrid;
  List<List<int>> solutionGrid;

  SudokuGrid({this.level, this.symbol, this.id, this.puzzle, this.solution}) {
    solutionGrid = List.generate(
      9,
      (i) => List.generate(
        9,
        (j) => int.parse(solution[9 * i + j]),
        growable: false,
      ),
      growable: false,
    );
    puzzleGrid = List.generate(
      9,
      (i) => List.generate(
        9,
        (j) => int.parse(puzzle[9 * i + j]),
        growable: false,
      ),
      growable: false,
    );
  }

  SudokuGrid.test(int level, int symbol)
      : this(
          level: level,
          symbol: symbol,
          id: 1,
          puzzle: "000010064500000800000460750060000000100007025000130000000800007000040600080502410",
          solution: "738915264546723891219468753367259148194687325852134976421896537975341682683572419",
        );
}
