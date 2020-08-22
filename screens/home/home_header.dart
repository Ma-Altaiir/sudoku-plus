import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sudokuplus/screens/home/game_widget.dart';
import 'package:sudokuplus/screens/home/menu_widget.dart';
import 'package:sudokuplus/services/lang.dart';

class HomeHeader extends StatefulWidget {
  final int initialLevel;
  final int initialSymbol;
  final int initialPage;
  final void Function(bool opened) onMenuClicked;
  final void Function(int pageIndex) onPageRequested;
  HomeHeader({
    Key key,
    this.initialLevel,
    this.initialSymbol,
    this.initialPage,
    this.onPageRequested,
    this.onMenuClicked,
  }) : super(key: key);
  @override
  HomeHeaderState createState() => HomeHeaderState();
}

class HomeHeaderState extends State<HomeHeader> with SingleTickerProviderStateMixin {
  bool _menuOpened;
  int _menuIndex;
  AnimationController _controller;
  Animation<Color> _menuColorAnimation;
  CurvedAnimation _menuFlipAnimation;

  @override
  void initState() {
    super.initState();
    _menuOpened = false;
    _menuIndex = 0;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _controller.addListener(() => setState(() {
          if (_menuOpened && _controller.value >= 0.5) {
            _menuIndex = 1;
          } else if (!_menuOpened && _controller.value <= 0.5) {
            _menuIndex = 0;
          }
        }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _menuFlipAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );

    _menuColorAnimation = ColorTween(
      begin: Theme.of(context).primaryColor,
      end: Colors.white,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double _width = mediaQuery.size.width;
    double _top = mediaQuery.padding.top;
    double _partialHeight = AppBar().preferredSize.height;

    return Container(
      width: _width,
      height: _top + 3 * _partialHeight,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          //Background Decoration
          Positioned(
            left: 0.0,
            top: 0.0,
            right: 0.0,
            height: _top + 2 * _partialHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Foreground Widgets
          Positioned(
            left: 0.0,
            top: 0.0,
            right: 0.0,
            height: _top + 3 * _partialHeight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, _top, 10, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //Title And Menu Button Button
                  Container(
                    height: _partialHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            AppLang.of(context).localize('game_title'),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 0.5 * _partialHeight,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateZ(_menuFlipAnimation.value * pi / 4),
                          child: Container(
                            width: 0.5 * _partialHeight,
                            height: 0.5 * _partialHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                0.25 * _partialHeight,
                              ),
                              color: _menuColorAnimation.value,
                            ),
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              onPressed: () {
                                setState(() {
                                  _menuOpened = !_menuOpened;
                                });
                                if (_menuOpened)
                                  _controller.forward();
                                else
                                  _controller.reverse();
                                widget.onMenuClicked(_menuOpened);
                              },
                              child: Tooltip(
                                message: AppLang.of(context).localize(_menuOpened ? 'menu_close' : 'menu_open'),
                                child: Icon(
                                  Icons.add,
                                  size: 0.5 * _partialHeight,
                                  color: _menuOpened ? Theme.of(context).primaryColor : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Game and Menu Widget
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateX(_menuFlipAnimation.value * pi),
                    child: Container(
                      height: 2 * _partialHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IndexedStack(
                        alignment: Alignment.center,
                        sizing: StackFit.expand,
                        index: _menuIndex,
                        children: <Widget>[
                          //Game
                          GameWidget(
                            menuOpened: _menuOpened,
                          ),
                          //Menu
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateX(-pi),
                            child: MenuWidget(
                              menuOpened: _menuOpened,
                              initialPage: widget.initialPage,
                              onPageRequested: widget.onPageRequested,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } //Build

}
