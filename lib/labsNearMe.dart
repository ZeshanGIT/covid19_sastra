import 'package:after_layout/after_layout.dart';
import 'package:android_intent/android_intent.dart';
import 'package:covid19_sastra/shared.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';

class LabsNearMe extends StatefulWidget {
  @override
  _LabsNearMeState createState() => _LabsNearMeState();
}

class _LabsNearMeState extends State<LabsNearMe> with AfterLayoutMixin {
  String state = '';
  List<String> govtLabs = [];
  List<String> pvtLabs = [];

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Labs in $state'),
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Nearest labs appear first',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                            'Government Labs',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        children: (govtLabs ?? []).isEmpty
                            ? [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Sorry there are no government labs near you',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(govtLabs.length, (i) {
                                return Column(
                                  children: <Widget>[
                                    Divider(color: Colors.black38),
                                    RaisedButton(
                                      elevation: 2,
                                      color: Colors.white,
                                      onPressed: () {
                                        MapsLauncher.launchQuery(
                                            '${govtLabs[i]}, $state');
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
                                            '${pvtLabs[i]}, $state');
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

  void openLocationSetting() async {
    if ((await Geolocator().checkGeolocationPermissionStatus()) !=
        GeolocationStatus.granted) {
      final AndroidIntent intent = new AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      );
      await intent.launch();
    }
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    openLocationSetting();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    state = placemark[0].administrativeArea;
    initializeGovt(position);
    initializePvt(position);
  }

  initializeGovt(Position position) {
    govtLabs = govt[state];
    Map<String, int> distances = {};

    govtLabs.forEach((f) async {
      List<Placemark> placemarkA =
          await Geolocator().placemarkFromAddress(f + ', ' + state);
      Placemark kA = placemarkA[0];
      double distance = await Geolocator().distanceBetween(
        position.latitude,
        position.longitude,
        kA.position.latitude,
        kA.position.longitude,
      );
      distances[f] = distance.toInt();
      if (govtLabs.last == f) {
        List<String> labsTemp = List<String>.from(govtLabs);
        labsTemp.sort((a, b) {
          return distances[a] - distances[b];
        });
        setState(() {
          state = state;
          govtLabs = labsTemp;
        });
      }
    });
  }

  initializePvt(Position position) {
    pvtLabs = pvt[state];
    Map<String, int> distances = {};

    (pvtLabs ?? []).forEach((f) async {
      List<Placemark> placemarkA =
          await Geolocator().placemarkFromAddress(f + ', ' + state);
      Placemark kA = placemarkA[0];
      double distance = await Geolocator().distanceBetween(
        position.latitude,
        position.longitude,
        kA.position.latitude,
        kA.position.longitude,
      );
      distances[f] = distance.toInt();
      if (pvtLabs.last == f) {
        List<String> labsTemp = List<String>.from(pvtLabs);
        labsTemp.sort((a, b) {
          return distances[a] - distances[b];
        });
        setState(() {
          state = state;
          pvtLabs = labsTemp;
        });
      }
    });
  }
}
