import 'package:covid19_sastra/labs.dart';
import 'package:covid19_sastra/labsNearMe.dart';
import 'package:covid19_sastra/tracker.dart';
import 'package:flutter/material.dart';

import 'shared.dart';
import 'updates/updates.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID 19 - SASTRA',
      debugShowCheckedModeBanner: false,
      routes: {
        '/updates': (_) => Updates(),
        '/tracker': (_) => Tracker(),
        '/govtLabs': (_) => PDFScreen('Government Labs', true),
        '/pvtLabs': (_) => PDFScreen('Private Labs', false),
        '/labsNearMe': (_) => LabsNearMe(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  BuildContext _context;

  double fontSize;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID 19'),
      ),
      body: Column(
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
          RaisedButton(
            color: Colors.white,
            onPressed: _openUpdates,
            child: Container(
              decoration: dec,
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              width: double.maxFinite,
              child: Text(
                'Govt. of India Updates',
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
        ],
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
}
