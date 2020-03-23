import 'dart:io';
import 'dart:async' show Future;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatelessWidget {
  String pdf;
  bool isGovt;
  PDFScreen(this.pdf, this.isGovt);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: prepareTestPdf(context),
      initialData: null,
      builder: (_, ss) {
        print('\n\nSnapShot');
        print(ss);
        print('SnapShot Data');
        print(ss.data);
        print('\n\n');
        if (ss.data != null)
          return PDFViewerScaffold(
            appBar: AppBar(
              title: Text(isGovt ? 'Government Labs' : 'Private Labs'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            path: ss.data,
          );
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String> prepareTestPdf(BuildContext context) async {
    final ByteData bytes = await DefaultAssetBundle.of(context)
        .load(isGovt ? 'assets/govt.pdf' : 'assets/private.pdf');
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath =
        '${tempDir.path}/${isGovt ? 'assets/govt.pdf' : 'private.pdf'}';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
}
