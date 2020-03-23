import 'package:covid19_sastra/shared.dart';
import 'package:covid19_sastra/stateLevelLabs.dart';
import 'package:flutter/material.dart';

class AllLabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> states = List.from(govt.keys);
    states.addAll(pvt.keys);
    states = states.toSet().toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID 19 Testing Labs'),
      ),
      body: ListView.builder(
        itemCount: states.length,
        itemBuilder: (_, i) {
          return Column(
            children: <Widget>[
              Divider(color: Colors.black38),
              RaisedButton(
                elevation: 2,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StateLevelLabs(
                        states[i],
                      ),
                    ),
                  );
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
                        states[i],
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
}
