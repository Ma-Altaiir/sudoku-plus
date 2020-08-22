//GridView
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/sudoku.dart';

class SudokuGridView extends StatefulWidget {
  final double size;
  final SudokuGrid grid;
  final void Function(int i, int j) onCellSelected;
  final void Function(int i, int j) onCellErased;
  final void Function(int errors) onCompleted;

  const SudokuGridView({
    Key key,
    this.size,
    this.grid,
    this.onCellSelected,
    this.onCellErased,
    this.onCompleted,
  }) : super(key: key);

  @override
  SudokuGridViewState createState() => SudokuGridViewState();
}

class SudokuGridViewState extends State<SudokuGridView> {
  List<List<GlobalKey<SudokuCellState>>> _keysGrid;
  int _emptyCells;
  @override
  void initState() {
    super.initState();
    _keysGrid = List.generate(9, (i) => List.generate(9, (j) => GlobalKey<SudokuCellState>()));
    _emptyCells = 0;
    widget.grid.puzzleGrid.forEach((line) {
      line.forEach((value) {
        value == 0 ? _emptyCells++ : _emptyCells = _emptyCells;
      });
    });
  }

  Widget build(BuildContext context) {
    Color _bordersColor = Theme.of(context).primaryColorDark;
    return Container(
      width: widget.size,
      height: widget.size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
          9,
          (i) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              9,
              (j) => SudokuCell(
                key: _keysGrid[i][j],
                size: widget.size / 9,
                color: _bordersColor,
                symbol: widget.grid.symbol,
                line: i,
                column: j,
                box: 3 * (i % 3) + (j % 3),
                puzzleValue: widget.grid.puzzleGrid[i][j],
                solutionValue: widget.grid.solutionGrid[i][j],
                onTap: widget.onCellSelected,
                onLongPress: widget.onCellErased,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setCell(int i, int j, int value) {
    if (!_keysGrid[i][j].currentState.fixed) {
      if (_keysGrid[i][j].currentState.cellValue == 0 && value > 0) {
        _emptyCells--;
      } else if (_keysGrid[i][j].currentState.cellValue > 0 && value == 0) {
        _emptyCells++;
      }
      _keysGrid[i][j].currentState.updateValue(value);
      if (_emptyCells == 0) {
        int errors = checkGrid();
        widget.onCompleted(errors);
      }
    }
  }

  int checkGrid() {
    int errors = 0;
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (_keysGrid[i][j].currentState.cellValue != _keysGrid[i][j].currentState.solutionValue) {
          errors += 1;
        }
      }
    }
    return errors;
  }

  void activateCorrect() {
    List<GlobalKey<SudokuCellState>> incorrectCells = [];
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (_keysGrid[i][j].currentState.cellValue > 0 &&
            _keysGrid[i][j].currentState.cellValue != _keysGrid[i][j].currentState.solutionValue) {
          incorrectCells.add(_keysGrid[i][j]);
        }
      }
    }
    int amount = incorrectCells.length;
    if (amount > 0) {
      int randomIndex = Random().nextInt(incorrectCells.length);
      incorrectCells[randomIndex].currentState.correct();
    }
  }

  void activateReveal() {
    List<GlobalKey<SudokuCellState>> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (_keysGrid[i][j].currentState.cellValue == 0) {
          emptyCells.add(_keysGrid[i][j]);
        }
      }
    }
    int amount = emptyCells.length;
    if (amount > 0) {
      int randomIndex = Random().nextInt(emptyCells.length);
      emptyCells[randomIndex].currentState.reveal();
      _emptyCells--;
      if (_emptyCells == 0) {
        int errors = checkGrid();
        widget.onCompleted(errors);
      }
    }
  }
}

class SudokuCell extends StatefulWidget {
  final double size;
  final Color color;
  final int symbol;
  final int line;
  final int column;
  final int box;
  final int puzzleValue;
  final int solutionValue;
  final void Function(int i, int j) onTap;
  final void Function(int i, int j) onLongPress;
  final bool fixed;

  const SudokuCell({
    Key key,
    this.size,
    this.color,
    this.symbol,
    this.line,
    this.column,
    this.box,
    this.puzzleValue,
    this.solutionValue,
    this.onTap,
    this.onLongPress,
  })  : fixed = puzzleValue == solutionValue,
        super(key: key);

  @override
  SudokuCellState createState() => SudokuCellState();
}

class SudokuCellState extends State<SudokuCell> {
  int _cellValue;

  @override
  void initState() {
    super.initState();
    _cellValue = widget.puzzleValue;
  }

  @override
  Widget build(BuildContext context) {
    Color _color = widget.color;
    return GestureDetector(
      onTap: () => widget.onTap(widget.line, widget.column),
      onLongPress: () => widget.onLongPress(widget.line, widget.column),
      child: Container(
        width: widget.size,
        height: widget.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: _getBorder(_color),
        ),
        child: _cellValue == 0 ? null : _getChild(context, widget.symbol, widget.fixed, widget.size, _cellValue),
      ),
    );
  }

  //Update Cell Value
  void updateValue(int value) {
    if (!widget.fixed) {
      setState(() => _cellValue = value);
    }
  }

  //Props
  bool get fixed => widget.fixed;
  int get puzzleValue => widget.puzzleValue;
  int get solutionValue => widget.solutionValue;
  int get cellValue => _cellValue;
  //Reveal
  void reveal() => updateValue(widget.solutionValue);
  //Correct
  void correct() => updateValue(widget.solutionValue);
  //Return correct child
  Widget _getChild(BuildContext context, int symbol, bool fixed, double size, int value) {
    int index = value - 1;
    switch (symbol) {
      case 0:
        return Icon(
          SudokuBackend.sudokuDigitsSymbols[index],
          color: fixed ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
          size: size,
        );

      case 1:
        return Icon(
          SudokuBackend.sudokuLettersSymbols[index],
          color: fixed ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
          size: size,
        );

      case 2:
        return Container(
          width: size,
          height: size,
          color: SudokuBackend.sudokuColorsSymbols[index],
          alignment: Alignment.center,
          child: fixed
              ? Icon(
                  MdiIcons.lock,
                  color: Colors.white,
                  size: size * 0.2,
                )
              : null,
        );
      case 3:
        return Icon(
          SudokuBackend.sudokuIconsSymbols[index],
          color: fixed ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
          size: size,
        );
      default:
        return Container();
    }
  }

  BoxBorder _getBorder(Color color) {
    return Border(
      top: BorderSide(color: color, width: widget.line % 3 == 0 ? 2.0 : 1.0),
      left: BorderSide(color: color, width: widget.column % 3 == 0 ? 2.0 : 1.0),
      right: BorderSide(color: color, width: widget.column == 8 ? 2.0 : 0.0),
      bottom: BorderSide(color: color, width: widget.line == 8 ? 2.0 : 0.0),
    );
  }
}
