import 'package:flutter/material.dart';
import 'package:sudokuplus/services/preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PoliciesPage extends StatelessWidget {
  final bool shown;
  const PoliciesPage({
    Key key,
    this.shown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: shown ? 1.0 : 0.0,
      child: Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: WebView(
            initialUrl: Preferences.PRIVACY_URL,
            javascriptMode: JavascriptMode.disabled,
            navigationDelegate: (navigation) async {
              if (await canLaunch(navigation.url)) {
                launch(navigation.url);
              }
              return NavigationDecision.prevent;
            },
          ),
        ),
      ),
    );
  }
}
