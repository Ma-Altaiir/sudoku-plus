import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sudokuplus/screens/home/home_body.dart';
import 'package:sudokuplus/screens/home/home_header.dart';
import 'package:sudokuplus/screens/pages/help_page.dart';
import 'package:sudokuplus/screens/pages/policies_page.dart';
import 'package:sudokuplus/screens/pages/info_page.dart';
import 'package:sudokuplus/screens/pages/results/results_page.dart';
import 'package:sudokuplus/screens/pages/settings/settings_page.dart';
import 'package:sudokuplus/screens/pages/source_page.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:sudokuplus/services/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  int _currentLevel = 0;
  int _currentSymbol = 0;
  bool _menuOpened = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (Preferences.privacy == false) {
          showPrivacyConsentDialog();
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //Header
          HomeHeader(
            initialPage: _currentPage,
            initialLevel: _currentLevel,
            initialSymbol: _currentSymbol,
            onMenuClicked: (bool opened) => setState(() {
              _menuOpened = opened;
              if (!opened) {
                _currentPage = 0;
              }
            }),
            onPageRequested: (int page) => setState(() => _currentPage = page),
          ),
          //Body
          HomeBody(
            selectedPage: _currentPage,
            menuOpened: _menuOpened,
            pages: <Widget>[
              ResultsPage(
                shown: _currentPage == 0,
              ),
              SettingsPage(
                shown: _currentPage == 1,
              ),
              HelpPage(
                shown: _currentPage == 2,
              ),
              InfoPage(
                shown: _currentPage == 3,
              ),
              PoliciesPage(
                shown: _currentPage == 4,
              ),
              SourcePage(
                shown: _currentPage == 5,
              ),
            ],
          )
        ],
      ),
    );
  }

  //Privacy Consent Dialog
  void showPrivacyConsentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        elevation: 4.0,
        backgroundColor: Theme.of(context).primaryColorDark,
        scrollable: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text(
          AppLang.of(context).localize('privacypolicy'),
          style: TextStyle(color: Colors.white),
        ),
        content: RichText(
          text: TextSpan(
            text: AppLang.of(context).localize('privacypolicyconsent'),
            style: TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: AppLang.of(context).localize('privacypolicylink'),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    if (await canLaunch(Preferences.PRIVACY_URL)) {
                      await launch(Preferences.PRIVACY_URL);
                    }
                  },
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            color: Theme.of(context).primaryColor,
            splashColor: Theme.of(context).primaryColorLight,
            textColor: Colors.white,
            child: Text(AppLang.of(context).localize('accept')),
            onPressed: () async {
              await Preferences.updatePrivacy(true);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            splashColor: Theme.of(context).primaryColorLight,
            textColor: Colors.white,
            child: Text(AppLang.of(context).localize('refuse')),
            onPressed: () async {
              await Preferences.updatePrivacy(false);
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
