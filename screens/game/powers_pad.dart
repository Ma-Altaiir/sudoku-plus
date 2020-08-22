import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PowersPad extends StatelessWidget {
  final double width;
  final double height;
  final int availableCorrect;
  final int availableReveal;
  final int availableFreeze;
  final void Function() onReveal;
  final void Function() onCorrect;
  final void Function() onFreeze;

  const PowersPad({
    Key key,
    this.width,
    this.height,
    this.availableCorrect,
    this.availableReveal,
    this.availableFreeze,
    this.onCorrect,
    this.onReveal,
    this.onFreeze,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _PowerWidget(
            width: width / 3 - 4.0,
            height: height,
            icon: MdiIcons.checkCircle,
            label: availableCorrect.toString(),
            onPressed: availableCorrect > 0 ? onCorrect : null,
          ),
          _PowerWidget(
            width: width / 3 - 4.0,
            height: height,
            icon: MdiIcons.eyeCircle,
            label: availableReveal.toString(),
            onPressed: availableReveal > 0 ? onReveal : null,
          ),
          _PowerWidget(
            width: width / 3 - 4.0,
            height: height,
            icon: MdiIcons.timerOff,
            label: availableFreeze.toString(),
            onPressed: availableFreeze > 0 ? onFreeze : null,
          ),
        ],
      ),
    );
  }
}

class _PowerWidget extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String label;
  final void Function() onPressed;

  const _PowerWidget({Key key, this.width, this.height, this.icon, this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        padding: EdgeInsets.all(0.0),
        color: Theme.of(context).primaryColorDark,
        splashColor: Theme.of(context).primaryColor,
        disabledColor: Theme.of(context).primaryColorLight,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: height,
              height: height,
              child: Icon(
                icon,
                size: height * 0.8,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.8,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
