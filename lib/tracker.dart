import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: SafeArea(
        child: WebView(
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl('https://www.bing.com/covid');
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
