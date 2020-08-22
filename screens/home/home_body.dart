import 'dart:math';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final bool menuOpened;
  final int selectedPage;
  final List<Widget> pages;

  HomeBody({
    Key key,
    this.selectedPage,
    this.pages,
    this.menuOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          10.0,
          10.0,
          10.0,
          max(10.0, MediaQuery.of(context).padding.bottom),
        ),
        child: Container(
          color: Colors.transparent,
          child: IndexedStack(
            alignment: Alignment.center,
            sizing: StackFit.expand,
            index: selectedPage,
            children: pages,
          ),
        ),
      ),
    );
  }
}
