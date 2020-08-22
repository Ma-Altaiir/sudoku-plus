import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sudokuplus/services/lang.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  final bool shown;
  const InfoPage({
    Key key,
    this.shown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = Uri(scheme: 'mailto', path: 'ma.altaiir@gmail.com', queryParameters: {'subject': 'Sudoku+'}).toString();
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: shown ? 1.0 : 0.0,
      child: Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              InfoWidget(
                title: AppLang.of(context).localize('aboutdevelopertitle'),
                content: AppLang.of(context).localize('aboutdevelopercontent'),
                link: email,
              ),
              SizedBox(height: 10.0),
              InfoWidget(
                title: AppLang.of(context).localize('aboutapptitle'),
                content: AppLang.of(context).localize('aboutappcontent'),
                link: "https://github.com/Ma-Altaiir/sudoku-plus",
              ),
              SizedBox(height: 10.0),
              InfoWidget(
                title: AppLang.of(context).localize('supporttitle'),
                content: AppLang.of(context).localize('supportcontent'),
                link: "http://play.google.com/store/apps/details?id=ma.altaiir.sudokuplus",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String content;
  final String link;

  const InfoWidget({
    Key key,
    this.title,
    this.content,
    this.link,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 30.0,
                alignment: Alignment.center,
                color: Theme.of(context).primaryColorLight,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: FlatButton.icon(
                          color: Colors.transparent,
                          splashColor: Theme.of(context).primaryColor,
                          highlightColor: Colors.transparent,
                          onPressed: () async {
                            if (await canLaunch(link)) {
                              try {
                                await launch(link);
                              } catch (_) {}
                            }
                          },
                          icon: Icon(MdiIcons.link),
                          label: Text(
                            AppLang.of(context).localize('link'),
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 14.0,
                    backgroundColor: Colors.transparent,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
