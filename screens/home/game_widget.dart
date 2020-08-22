import 'package:flutter/material.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/sudoku.dart';

class GameWidget extends StatefulWidget {
  final bool menuOpened;

  GameWidget({
    Key key,
    this.menuOpened,
  }) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  double partialHeight = AppBar().preferredSize.height;
  int requestedLevel = 0;
  int requestedSymbol = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      opacity: widget.menuOpened ? 0.0 : 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: _MultiChoiceMenu(
                  initialIndex: requestedLevel,
                  partialHeight: partialHeight,
                  menuItems: List.generate(SudokuBackend.SudokuLevelsNames.length,
                      (index) => AppLang.of(context).localize(SudokuBackend.SudokuLevelsNames[index])),
                  onMenuItemSelected: (selectedIndex) => setState(() => requestedLevel = selectedIndex),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: _MultiChoiceMenu(
                  initialIndex: requestedSymbol,
                  partialHeight: partialHeight,
                  menuItems: List.generate(SudokuBackend.SudokuSymbolsNames.length,
                      (index) => AppLang.of(context).localize(SudokuBackend.SudokuSymbolsNames[index])),
                  onMenuItemSelected: (selectedIndex) => setState(() => requestedSymbol = selectedIndex),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: _StartGameButton(
                partialHeight: partialHeight,
                level: requestedLevel,
                symbol: requestedSymbol,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MultiChoiceMenu extends StatelessWidget {
  final int initialIndex;
  final double partialHeight;
  final List<String> menuItems;
  final void Function(int selectedIndex) onMenuItemSelected;
  const _MultiChoiceMenu({
    Key key,
    this.initialIndex,
    this.onMenuItemSelected,
    this.menuItems,
    this.partialHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: MaterialButton(
            padding: EdgeInsets.all(0.0),
            elevation: 0.0,
            color: initialIndex == 0 ? Theme.of(context).primaryColorLight : Colors.white,
            child: Text(
              menuItems[0],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: (2 * partialHeight / 3) * 0.4,
              ),
            ),
            onPressed: () {
              onMenuItemSelected(0);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: MaterialButton(
            padding: EdgeInsets.all(0.0),
            elevation: 0.0,
            color: initialIndex == 1 ? Theme.of(context).primaryColorLight : Colors.white,
            child: Text(
              menuItems[1],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: (2 * partialHeight / 3) * 0.4,
              ),
            ),
            onPressed: () {
              onMenuItemSelected(1);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: MaterialButton(
            padding: EdgeInsets.all(0.0),
            elevation: 0.0,
            color: initialIndex == 2 ? Theme.of(context).primaryColorLight : Colors.white,
            child: Text(
              menuItems[2],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: (2 * partialHeight / 3) * 0.4,
              ),
            ),
            onPressed: () {
              onMenuItemSelected(2);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: MaterialButton(
            padding: EdgeInsets.all(0.0),
            elevation: 0.0,
            color: initialIndex == 3 ? Theme.of(context).primaryColorLight : Colors.white,
            child: Text(
              menuItems[3],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: (2 * partialHeight / 3) * 0.4,
              ),
            ),
            onPressed: () {
              onMenuItemSelected(3);
            },
          ),
        ),
      ],
    );
  }
}

class _StartGameButton extends StatefulWidget {
  final double partialHeight;
  final int level;
  final int symbol;

  _StartGameButton({Key key, this.partialHeight, this.level, this.symbol}) : super(key: key);

  @override
  _StartGameButtonState createState() => _StartGameButtonState();
}

class _StartGameButtonState extends State<_StartGameButton> {
  int _loadingStatus = 0;
  Widget _getIcon(int status, double size) {
    if (status == 0) {
      return Icon(
        MdiIcons.viewGridPlus,
        size: size,
        color: Colors.white,
      );
    } else if (status == 1) {
      return Container(
        width: (2 * widget.partialHeight / 3) * 0.5,
        height: (2 * widget.partialHeight / 3) * 0.5,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(
        MdiIcons.headAlert,
        size: size,
        color: Colors.white,
      );
    }
  }

  String _getText(int status) {
    if (status == 0)
      return AppLang.of(context).localize('loadgrid');
    else if (status == 1)
      return AppLang.of(context).localize('loadinggrid');
    else
      return AppLang.of(context).localize('loadinggriderror');
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: EdgeInsets.all(0.0),
      color: Theme.of(context).primaryColorDark,
      splashColor: Theme.of(context).primaryColor,
      icon: _getIcon(_loadingStatus, (2 * widget.partialHeight / 3) * 0.5),
      label: Text(
        _getText(_loadingStatus),
        style: TextStyle(
          color: Colors.white,
          fontSize: (2 * widget.partialHeight / 3) * 0.5,
        ),
      ),
      onPressed: () async {
        setState(() => _loadingStatus = 1);
        SudokuGrid grid = await SudokuBackend.getSudokuGrid(widget.level, widget.symbol);
        if (grid == null) {
          setState(() => _loadingStatus = -1);
        } else {
          setState(() => _loadingStatus = 0);
          Navigator.of(context).pushNamed('/game', arguments: grid);
        }
      },
    );
  }
}
