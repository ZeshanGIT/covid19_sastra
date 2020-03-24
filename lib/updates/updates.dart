import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Updates extends StatelessWidget {
  String js = '''
    function removeElementsByClass(className){
    var elements = document.getElementsByClassName(className);
    while(elements.length > 0){
        elements[0].parentNode.removeChild(elements[0]);
    }
}
removeElementsByClass('header');
removeElementsByClass('progress-block-area');
removeElementsByClass('menu');
  ''';

  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl('https://www.mohfw.gov.in/');
            _webViewController = webViewController;
          },
          onPageFinished: (_) {
            _webViewController.evaluateJavascript(js);
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      // body: StreamBuilder<List<dynamic>>(
      //   initialData: [],
      //   stream:
      //       Firestore.instance.collection('posts').snapshots().map(fromQuerySS),
      //   builder: (_, ass) {
      //     List<dynamic> data = ass.data;
      //     // print(ass);
      //     if (ass.hasData)
      //       return ListView.builder(
      //         itemCount: data.length,
      //         itemBuilder: (_, i) => MyPost(
      //           data[i].title,
      //           data[i].uid,
      //           data[i].description,
      //           data[i].url,
      //           data[i].mediaType,
      //         ),
      //       );
      //     else
      //       return Center(child: CircularProgressIndicator());
      //   },
      // ),
    );
  }
}
