import 'package:covid19_sastra/shared.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListAllHelplines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Helplines')),
      body: ListView.builder(
        itemCount: helpLine.keys.length,
        itemBuilder: (_, i) {
          String state = helpLine.keys.toList()[i];
          return Column(
            children: <Widget>[
              Divider(color: Colors.black38),
              RaisedButton(
                elevation: 2,
                color: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: helpLine[state].map((f) {
                                return FlatButton(
                                  onPressed: () {
                                    _launchURL('tel:$f');
                                  },
                                  child: Text(
                                    'Call $f',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }).toList()),
                          title: Text(state),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        state,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
