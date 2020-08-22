import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/admob.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:sudokuplus/services/preferences.dart';

class PowersWidget extends StatefulWidget {
  final int correct;
  final int reveal;
  final int freeze;

  const PowersWidget({Key key, this.correct, this.reveal, this.freeze}) : super(key: key);

  @override
  _PowersWidgetState createState() => _PowersWidgetState();
}

class _PowersWidgetState extends State<PowersWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double height = constraints.maxHeight;
            double width = constraints.maxWidth;
            return ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Colors.white,
                width: width,
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Powers Label
                    Container(
                      color: Theme.of(context).primaryColorDark,
                      padding: EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      width: 20,
                      height: height,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          AppLang.of(context).localize('powers'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _PowersUnit(
                            width: width,
                            height: height / 3,
                            icon: MdiIcons.checkCircle,
                            label: AppLang.of(context).localize('correct'),
                            amount: widget.correct,
                            onAddPower: () {
                              _showConsentDialog(
                                context: context,
                                onRewarded: () {
                                  Preferences.updatePowersCorrect(1);
                                  setState(() {});
                                },
                              );
                            },
                          ),
                          _PowersUnit(
                            width: width,
                            height: height / 3,
                            icon: MdiIcons.eyeCircle,
                            label: AppLang.of(context).localize('reveal'),
                            amount: widget.reveal,
                            onAddPower: () {
                              _showConsentDialog(
                                context: context,
                                onRewarded: () {
                                  Preferences.updatePowersReveal(1);
                                  setState(() {});
                                },
                              );
                            },
                          ),
                          _PowersUnit(
                            width: width,
                            height: height / 3,
                            icon: MdiIcons.timerOff,
                            label: AppLang.of(context).localize('freeze'),
                            amount: widget.freeze,
                            onAddPower: () {
                              _showConsentDialog(
                                context: context,
                                onRewarded: () {
                                  Preferences.updatePowersFreeze(1);
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showConsentDialog({BuildContext context, void Function() onRewarded}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _RewardedVideoAdDialog(onRewarded),
    );
  }
}

class _PowersUnit extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String label;
  final int amount;
  final void Function() onAddPower;

  const _PowersUnit({
    Key key,
    this.width,
    this.height,
    this.icon,
    this.label,
    this.amount,
    this.onAddPower,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).primaryColorLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: height,
            height: height,
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: Icon(
              icon,
              color: Colors.white,
              size: height * 0.8,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: height * 0.6,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: height,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                amount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: height * 0.6, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            width: height,
            height: height,
            alignment: Alignment.center,
            color: Theme.of(context).primaryColorDark,
            child: FlatButton(
              onPressed: onAddPower,
              splashColor: Theme.of(context).primaryColorLight,
              child: Text(
                '+',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: height * 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardedVideoAdDialog extends StatefulWidget {
  final void Function() onRewarded;
  const _RewardedVideoAdDialog(this.onRewarded);
  @override
  __RewardedVideoAdDialogState createState() => __RewardedVideoAdDialogState();
}

class __RewardedVideoAdDialogState extends State<_RewardedVideoAdDialog> {
  AdStatus _videoStatus;

  @override
  void initState() {
    super.initState();
    Admob.loadVideoAd((status) {
      switch (status) {
        case AdStatus.loading:
          if (this.mounted) {
            setState(() => _videoStatus = AdStatus.loading);
          }
          break;
        case AdStatus.loaded:
          if (this.mounted) {
            setState(() => _videoStatus = AdStatus.loaded);
          }
          break;
        case AdStatus.failed:
          if (this.mounted) {
            setState(() => _videoStatus = AdStatus.failed);
          }
          break;
      }
    });
  }

  Widget _getTitle(AdStatus status) {
    if (status == AdStatus.loading) {
      return null;
    } else {
      return Text(
        AppLang.of(context).localize('rewardedvideo'),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      );
    }
  }

  Widget _getContent(AdStatus status) {
    if (status == AdStatus.loading) {
      return Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (status == AdStatus.loaded) {
      return Text(
        AppLang.of(context).localize('rewardedvideotext'),
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        AppLang.of(context).localize('rewardedvideoerror'),
        style: TextStyle(color: Colors.white),
      );
    }
  }

  List<Widget> _getActions(AdStatus status) {
    if (status == AdStatus.loaded) {
      return <Widget>[
        FlatButton(
          color: Colors.transparent,
          splashColor: Colors.white,
          textColor: Theme.of(context).backgroundColor,
          shape: Border.all(
            style: BorderStyle.solid,
            width: 2.0,
            color: Theme.of(context).backgroundColor,
          ),
          child: Text(AppLang.of(context).localize('cancel')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          color: Theme.of(context).primaryColorLight,
          splashColor: Colors.white,
          textColor: Theme.of(context).primaryColorDark,
          child: Text(AppLang.of(context).localize('agree')),
          onPressed: () {
            Admob.showVideoAd(widget.onRewarded);
            Navigator.of(context).pop();
          },
        ),
      ];
    } else {
      return [
        FlatButton(
          color: Theme.of(context).primaryColorLight,
          splashColor: Colors.white,
          textColor: Theme.of(context).primaryColorDark,
          child: Text(AppLang.of(context).localize('close')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 4.0,
      backgroundColor: Theme.of(context).primaryColorDark,
      scrollable: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Container(height: 30.0, child: _getTitle(_videoStatus)),
      content: Container(height: 60.0, child: _getContent(_videoStatus)),
      actions: _getActions(_videoStatus),
    );
  }
}
