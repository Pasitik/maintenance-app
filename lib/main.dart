import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'existing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:dashboard/edu.dart';
//import 'package:dashboard/health.dart';
//import 'package:dashboard/roads.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar( 
              backgroundColor: Colors.black45,
              bottom: TabBar(
                tabs: [
                  Text("Report"),
                  Text("Existing"),
                  Text("Solved"),
                ],
              ),
              title: Text('Road Master'),
            ),
            body: TabBarView(
              children: [
                Dashboard(),
                Existing(),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        )
    );
  }
}
