import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WashHands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Wash your hands'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Wash your hands with soap for 20 seconds.\nWatch the video to know why.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              height: w / 1.7,
              width: w,
              child: WebView(
                initialUrl: Uri.dataFromString(
                  '<html><body><iframe width="$w" height="${w / 1.7}" src="https://www.youtube.com/embed/-LKVUarhtvE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></body></html>',
                  mimeType: 'text/html',
                ).toString(),
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            SizedBox(height: 16),
            Text('Follow the steps provided in the video to be germ free'),
            Container(
              alignment: Alignment.center,
              height: w / 1.7,
              width: w,
              child: WebView(
                initialUrl: Uri.dataFromString(
                  '<html><body><iframe width="$w" height="${w / 1.7}" src="https://www.youtube.com/embed/seA1wbXUQTs?start=2" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></body></html>',
                  mimeType: 'text/html',
                ).toString(),
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
