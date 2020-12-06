import 'package:after_layout/after_layout.dart';
import 'package:android_intent/android_intent.dart';
import 'package:covid19_sastra/labs.dart';
import 'package:covid19_sastra/labsNearMe.dart';
import 'package:covid19_sastra/listAllhelpLines.dart';
import 'package:covid19_sastra/tracker.dart';
import 'package:covid19_sastra/washHands.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart' as EsysFlutterShare;
import 'allLabs.dart';
import 'shared.dart';
import 'updates/updates.dart';

Future<void> main() async {
  runApp(new MyApp());

  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool check = prefs.getBool('isNotOpened') ?? true;
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) async {
  //   if (check) {
  //     await Workmanager.initialize(callBack);
  //     await Workmanager.registerPeriodicTask(
  //       "2",
  //       "simplePeriodicTask",
  //       frequency: Duration(hours: 2),
  //     );
  //     prefs.setBool('isNotOpened', false);
  //   }
  // });
}

// callBack() {
//   Workmanager.executeTask((_, __) async {
//     await showNoti();
//     return Future.value(true);
//   });
// }

// Future<void> showNoti() async {
//   if (!(DateTime.now().hour < 6 || DateTime.now().hour > 21)) {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('noti_icon');
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//     var initializationSettings = InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       '1',
//       'washYourHands',
//       'for20seconds',
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       1,
//       "Stay germ-free !",
//       'Wash your hands for 20 seconds. Click here to know why.',
//       platformChannelSpecifics,
//     );
//   }
// }

Future onSelectNotification(String payload) async {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        indicatorColor: Colors.red,
      ),
      title: 'COVID 19 - SASTRA',
      debugShowCheckedModeBanner: false,
      routes: {
        '/updates': (_) => Updates(),
        '/tracker': (_) => Tracker(),
        '/govtLabs': (_) => PDFScreen('Government Labs', 'govt.pdf'),
        '/pvtLabs': (_) => PDFScreen('Private Labs', 'pvt.pdf'),
        '/labsNearMe': (_) => LabsNearMe(),
        '/dnd': (_) => PDFScreen("Do's and Dont's", 'dnd.pdf'),
        '/allLabs': (_) => AllLabs(),
        '/listAllHelplines': (_) => ListAllHelplines(),
        '/washHands': (_) => WashHands(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  BuildContext _context;
  double fontSize;
  String state = '';

  void openLocationSetting() async {
    if ((await Geolocator().checkGeolocationPermissionStatus()) ==
        GeolocationStatus.disabled) {
      final AndroidIntent intent = new AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      );
      await intent.launch();
    }
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails.didNotificationLaunchApp) {
      Navigator.of(context).pushNamed('/washHands');
    }
    openLocationSetting();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      state = placemark[0].administrativeArea;
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID 19'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                EsysFlutterShare.Share.text(
                  'COVID 19 - Awarness',
                  'Share the app and save the country.\n*Prevention is better than cure*\n\nhttps://play.google.com/store/apps/details?id=edu.sastra.covid19_sastra',
                  'text/*',
                );
              }),
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(
                        title: Text('About'),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset('assets/goi.jpg'),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Image.asset('assets/logo.png'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              child: Text(
                                'Developed by',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Image.asset('assets/dsc.png'),
                            SizedBox(height: 24),
                            Text(
                              'Developer',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'K S Seshan',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 32),
                            Text(
                              'Under the guidance of',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Dr. V S Shankar Sriram',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Prof. K S Suresh',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              'लोकाः समस्ताः सुखिनोभवंतु',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/logo.png',
              width: double.maxFinite,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  color: Colors.white,
                  onPressed: () {
                    if (state != '')
                      _launchURL('tel:${helpLine[state]}');
                    else
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Sorry'),
                              content: Text(
                                  'Either your Location is not turned on or wait for it load'),
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
                  shape: StadiumBorder(),
                  child: Text(
                    'Call $state helpline',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  color: Colors.white,
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/listAllHelplines');
                  },
                  child: Text(
                    'All helplines',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            RaisedButton(
              color: Colors.white,
              onPressed: _openUpdates,
              child: Container(
                decoration: dec,
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  'Govt. of India Circulars',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/tracker'),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: dec,
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text('COVID 19 Global Tracker', style: textStyle),
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushNamed('/labsNearMe'),
              child: Container(
                decoration: dec,
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  'Testing Labs near me',
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushNamed('/allLabs'),
              child: Container(
                decoration: dec,
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  "All Testing Labs",
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushNamed('/dnd'),
              child: Container(
                decoration: dec,
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  "Do's and Don'ts",
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed('/govtLabs'),
          padding: const EdgeInsets.all(32),
          child: Text(
            'Govt.',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        RaisedButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed('/pvtLabs'),
          padding: const EdgeInsets.all(32),
          child: Text(
            'Private',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }

  void _openUpdates() {
    Navigator.of(_context).pushNamed('/updates');
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) {}
