//SymbolsPad
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/sudoku.dart';

class SymbolsPad extends StatefulWidget {
  final double width;
  final double height;
  final int symbol;
  final void Function(int symbol) onSymbolSelected;

  const SymbolsPad({Key key, this.width, this.height, this.symbol, this.onSymbolSelected}) : super(key: key);

  @override
  _SymbolsPadState createState() => _SymbolsPadState();
}

class _SymbolsPadState extends State<SymbolsPad> {
  int _selectedSymbol = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
          9,
          (index) => SymbolsPadUnit(
            size: widget.height - 4.0,
            symbol: widget.symbol,
            index: index,
            isSelected: index == _selectedSymbol,
            onSelected: (index) {
              setState(() {
                _selectedSymbol = index;
              });
              widget.onSymbolSelected(_selectedSymbol + 1);
            },
          ),
        ),
      ),
    );
  }
}

class SymbolsPadUnit extends StatelessWidget {
  final double size;
  final int symbol;
  final int index;
  final bool isSelected;
  final void Function(int index) onSelected;

  const SymbolsPadUnit({Key key, this.size, this.symbol, this.index, this.isSelected, this.onSelected}) : super(key: key);

  Widget _getChild(BuildContext context, int symbol, bool isSelected, double size) {
    switch (symbol) {
      case 0:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: isSelected ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
          ),
          child: Icon(
            SudokuBackend.sudokuDigitsSymbols[index],
            color: isSelected ? Colors.white : Theme.of(context).primaryColorDark,
            size: size,
          ),
        );

      case 1:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: isSelected ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
          ),
          child: Icon(
            SudokuBackend.sudokuLettersSymbols[index],
            color: isSelected ? Colors.white : Theme.of(context).primaryColorDark,
            size: size,
          ),
        );

      case 2:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: SudokuBackend.sudokuColorsSymbols[index],
          ),
          child: isSelected
              ? Icon(
                  MdiIcons.gestureTapHold,
                  color: Colors.white,
                )
              : null,
        );
      case 3:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: isSelected ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
          ),
          child: Icon(
            SudokuBackend.sudokuIconsSymbols[index],
            color: isSelected ? Colors.white : Theme.of(context).primaryColorDark,
            size: size * 0.8,
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: MaterialButton(
        padding: EdgeInsets.all(0.0),
        elevation: 0.0,
        onPressed: () => onSelected(index),
        color: Colors.transparent,
        splashColor: symbol == 2 ? Colors.white : Theme.of(context).primaryColor,
        child: _getChild(
          context,
          symbol,
          isSelected,
          size,
        ),
      ),
    );
  }
}
