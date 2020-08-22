import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcePage extends StatelessWidget {
  final bool shown;
  const SourcePage({
    Key key,
    this.shown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: shown ? 1.0 : 0.0,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                SourcePackage(
                  name: 'Flutter',
                  version: 'v1.20.2',
                  description:
                      "Flutter is Google's SDK for crafting beautiful, fast user experiences for mobile, web, and desktop from a single codebase.",
                  link: 'https://github.com/flutter/flutter',
                  license: 'https://github.com/flutter/flutter/blob/master/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'shared_preferences',
                  version: 'v0.5.8',
                  description:
                      "Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android.",
                  link: 'https://github.com/flutter/plugins/tree/master/packages/shared_preferences/shared_preferences',
                  license:
                      'https://github.com/flutter/plugins/blob/master/packages/shared_preferences/shared_preferences/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'material_design_icons_flutter',
                  version: 'v4.0.5345',
                  description:
                      "Flutter is Google's SDK for crafting beautiful, fast user experiences for mobile, web, and desktop from a single codebase.",
                  link: 'https://github.com/ziofat/material_design_icons_flutter',
                  license: 'https://github.com/ziofat/material_design_icons_flutter/blob/master/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'url_launcher',
                  version: 'v5.5.0',
                  description: "A Flutter plugin for launching a URL in the mobile platform. Supports iOS and Android.",
                  link: 'https://github.com/flutter/plugins/tree/master/packages/url_launcher/url_launcher',
                  license: 'https://github.com/flutter/plugins/blob/master/packages/url_launcher/url_launcher/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'webview_flutter',
                  version: 'v0.3.22+1',
                  description: "A Flutter plugin for launching web pages inside a flutter widget.",
                  link: 'https://github.com/flutter/plugins/tree/master/packages/webview_flutter',
                  license: 'https://github.com/flutter/plugins/blob/master/packages/webview_flutter/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'firebase_core',
                  version: 'v0.4.5',
                  description: "Firebase Core provides APIs to manage your Firebase application instances and credentials.",
                  link: 'https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_core/firebase_core',
                  license:
                      'https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_core/firebase_core/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'firebase_auth',
                  version: 'v0.16.1',
                  description:
                      "Firebase Authentication provides backend services & easy-to-use SDKs to authenticate users to mobile and web app.",
                  link: 'https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_auth/firebase_auth',
                  license:
                      'https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'cloud_firestore',
                  version: 'v0.13.7',
                  description:
                      "Cloud Firestore is a NoSQL document database that lets you easily store, sync, and query data for your mobile and web apps - at global scale.",
                  link: 'https://github.com/FirebaseExtended/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore',
                  license:
                      'https://github.com/FirebaseExtended/flutterfire/blob/master/packages/cloud_firestore/cloud_firestore/LICENSE',
                ),
                SizedBox(height: 20.0),
                SourcePackage(
                  name: 'firebase_admob',
                  version: 'v0.9.3+4',
                  description:
                      "Google AdMob is a mobile advertising platform that you can use to generate revenue from your app. Using AdMob with Firebase provides you with additional app usage data and analytics capabilities.",
                  link: 'https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_admob',
                  license: 'https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_admob/LICENSE',
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SourcePackage extends StatelessWidget {
  final String name;
  final String version;
  final String description;
  final String link;
  final String license;

  const SourcePackage({
    Key key,
    this.name,
    this.version,
    this.description,
    this.link,
    this.license,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 30.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Theme.of(context).primaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        decoration: TextDecoration.none,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      version,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        decoration: TextDecoration.none,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 14.0,
                  backgroundColor: Colors.transparent,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 30.0,
              color: Colors.white70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      child: Text(
                        'Link',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () async {
                        if (await canLaunch(link)) {
                          try {
                            await launch(link);
                          } catch (_) {}
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      child: Text(
                        'License',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () async {
                        if (await canLaunch(license)) {
                          try {
                            await launch(license);
                          } catch (_) {}
                        }
                      },
                    ),
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
