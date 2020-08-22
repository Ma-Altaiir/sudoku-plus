import 'package:flutter/material.dart';
import 'package:sudokuplus/services/admob.dart';

class GameBanner extends StatefulWidget {
  @override
  _GameBannerState createState() => _GameBannerState();
}

class _GameBannerState extends State<GameBanner> {
  double _width;
  double _height;
  double _bottom;

  @override
  void initState() {
    super.initState();
    Admob.loadBanner(onLoaded: () => Admob.showBanner(10.0));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _width = MediaQuery.of(context).size.width;
    _height = 120.0;
    _bottom = MediaQuery.of(context).padding.bottom;
  }

  @override
  void dispose() {
    Admob.destroyBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      margin: EdgeInsets.only(bottom: _bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
    );
  }
}
