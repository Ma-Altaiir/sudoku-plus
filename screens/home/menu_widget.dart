import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/lang.dart';

class MenuWidget extends StatefulWidget {
  final bool menuOpened;
  final int initialPage;
  final void Function(int pageIndex) onPageRequested;
  MenuWidget({
    Key key,
    this.menuOpened,
    this.initialPage,
    this.onPageRequested,
  }) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    double partialHeight = AppBar().preferredSize.height;
    double fontSize = (2 * partialHeight / 3) * 0.45;
    int selectedPage = widget.initialPage;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      opacity: widget.menuOpened ? 1.0 : 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _MenuButton(
                    selected: selectedPage == 0,
                    iconData: MdiIcons.filePercent,
                    label: AppLang.of(context).localize('results'),
                    fontSize: fontSize,
                    onPressed: () {
                      setState(() {
                        selectedPage = 0;
                      });
                      widget.onPageRequested(selectedPage);
                    },
                  ),
                  _MenuButton(
                    selected: selectedPage == 1,
                    iconData: MdiIcons.fileCog,
                    label: AppLang.of(context).localize('settings'),
                    fontSize: fontSize,
                    onPressed: () {
                      setState(() {
                        selectedPage = 1;
                      });
                      widget.onPageRequested(selectedPage);
                    },
                  ),
                  _MenuButton(
                    selected: selectedPage == 2,
                    iconData: MdiIcons.fileAlert,
                    label: AppLang.of(context).localize('help'),
                    fontSize: fontSize,
                    onPressed: () {
                      setState(() {
                        selectedPage = 2;
                      });
                      widget.onPageRequested(selectedPage);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _MenuButton(
                    selected: selectedPage == 3,
                    iconData: MdiIcons.fileStar,
                    label: AppLang.of(context).localize('info'),
                    fontSize: fontSize,
                    onPressed: () {
                      setState(() {
                        selectedPage = 3;
                      });
                      widget.onPageRequested(selectedPage);
                    },
                  ),
                  _MenuButton(
                    selected: selectedPage == 4,
                    iconData: MdiIcons.fileEye,
                    label: AppLang.of(context).localize('policies'),
                    fontSize: fontSize,
                    onPressed: () {
                      setState(() {
                        selectedPage = 4;
                      });
                      widget.onPageRequested(selectedPage);
                    },
                  ),
                  _MenuButton(
                    selected: selectedPage == 5,
                    iconData: MdiIcons.fileCode,
                    label: AppLang.of(context).localize('source'),
                    fontSize: fontSize,
                    onPressed: () {
                      setState(() {
                        selectedPage = 5;
                      });
                      widget.onPageRequested(selectedPage);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final bool selected;
  final IconData iconData;
  final String label;
  final double fontSize;
  final void Function() onPressed;

  const _MenuButton({
    this.selected,
    this.iconData,
    this.label,
    this.fontSize,
    this.onPressed,
  });

  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: MaterialButton(
        padding: EdgeInsets.all(0.0),
        elevation: 0.0,
        onPressed: onPressed,
        color: selected ? Theme.of(context).primaryColor : Colors.white,
        splashColor: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(
              iconData,
              size: fontSize,
              color: selected ? Colors.white : Theme.of(context).primaryColorDark,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: selected ? Colors.white : Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
