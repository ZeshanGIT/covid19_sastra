import 'dart:io';
import 'dart:async' show Future;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart' as EsysFlutterShare;

class PDFScreen extends StatelessWidget {
  String title, filename;
  PDFScreen(this.title, this.filename);
  List<int> bytes;

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
              title: Text(title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    EsysFlutterShare.Share.file(
                      'COVID 19 - Awarness',
                      "Do's and Don'ts - COVID 19",
                      bytes,
                      'application/pdf',
                    );
                  },
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
    final ByteData _bytes =
        await DefaultAssetBundle.of(context).load('assets/$filename');
    final Uint8List list = _bytes.buffer.asUint8List();
    bytes = list;
    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/assets/$filename';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
}
