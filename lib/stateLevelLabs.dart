import 'package:covid19_sastra/shared.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class StateLevelLabs extends StatefulWidget {
  final String state;

  const StateLevelLabs(this.state, {Key key}) : super(key: key);
  @override
  _StateLevelLabsState createState() => _StateLevelLabsState();
}

class _StateLevelLabsState extends State<StateLevelLabs> {
  String state;

  bool expanded = false;
  List<String> govtLabs;
  List<String> pvtLabs;
  @override
  void initState() {
    state = widget.state;
    govtLabs = govt[state];
    pvtLabs = pvt[state];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labs in $state'),
      ),
      body: govtLabs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ExpansionTile(
                        onExpansionChanged: (state) {
                          setState(() {
                            expanded = state;
                          });
                        },
                        title: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Government Labs',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        children: List.generate(govtLabs.length, (i) {
                          return Column(
                            children: <Widget>[
                              Divider(color: Colors.black38),
                              RaisedButton(
                                elevation: 2,
                                color: Colors.white,
                                onPressed: () {
                                  MapsLauncher.launchQuery(
                                      'https://www.google.com/maps/search/${govtLabs[i].replaceAll(' ', '+')}+$state');
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    govtLabs[i],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      ExpansionTile(
                        onExpansionChanged: (state) {
                          setState(() {
                            expanded = state;
                          });
                        },
                        title: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Private Labs',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        children: (pvtLabs ?? []).isEmpty
                            ? [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Sorry there are no private labs near you',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(pvtLabs.length, (i) {
                                return Column(
                                  children: <Widget>[
                                    Divider(color: Colors.black38),
                                    RaisedButton(
                                      elevation: 2,
                                      color: Colors.white,
                                      onPressed: () {
                                        MapsLauncher.launchQuery(
                                            'https://www.google.com/maps/search/${govtLabs[i].replaceAll(' ', '+')}+$state');
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 16,
                                        ),
                                        child: Text(
                                          govtLabs[i],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: expanded ? 0 : 1,
                      child: Image.asset('assets/footer.jpg')),
                ),
              ],
            ),
    );
  }
}
