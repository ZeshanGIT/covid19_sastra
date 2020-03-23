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
  List<String> labs = [];
  List<Position> coordinates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places in $state'),
      ),
      body: ListView.builder(
        itemCount: labs.length,
        itemBuilder: (_, i) {
          return RaisedButton(
            onPressed: () {
              MapsLauncher.launchQuery(
                  'https://www.google.com/maps/search/${labs[i].replaceAll(' ', '+')}+$state');
            },
            child: Text(
              labs[i],
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          );
        },
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

    // setState(() {
    // });

    state = placemark[0].administrativeArea;
    labs = data[state];
    Map<String, int> distances = {};

    labs.forEach((f) async {
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
      if (labs.last == f) {
        List<String> labsTemp = List<String>.from(labs);
        labsTemp.sort((a, b) {
          return distances[a] - distances[b];
        });
        setState(() {
          state = state;
          labs = labsTemp;
        });
      }
    });
  }
}
