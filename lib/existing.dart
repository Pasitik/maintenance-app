import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'robbery_page.dart';
import 'stuff.dart';
import 'fun.dart';

class Existing extends StatefulWidget {
  @override
  ExistingState createState() => ExistingState();
}

class ExistingState extends State<Existing> {
  
  @override
  Stream<dynamic> query;
  Firestore firestore = Firestore.instance;
  StreamSubscription subscription;
  final databaseReference = Firestore.instance;

  /* Future getReports(String type) async {
    QuerySnapshot qn = await databaseReference.collection(type).getDocuments();
    return qn.documents;
  }*/
  Material MyItems( String heading, int color, String page) {
    return Material(
      color: Colors.black45,
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadiusDirectional.circular(24.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    heading,
                    style: TextStyle(
                      color: new Color(color),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ); //);
  }

  Widget build(BuildContext context) {
    return Scaffold(
          body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        children: <Widget>[
          InkWell(
              child: MyItems(
                  "Robbery", 0xffed622b, "/health"),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => RobberyCasesPage()));
            }
          ),
          InkWell(
              child: MyItems(
                   "Robbery", 0xffed622b, "/health"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RobberyCasesPage()));
            }
          ),
          InkWell(
              child: MyItems(
                  "Robbery", 0xffed622b, "/health"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RobberyCasesPage()));
            }
          ),
          InkWell(
              child: MyItems(
                   "Car breakdown", 0xffed622b, "/health"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RobberyCasesPage()));
            }
          ),
          InkWell(
              child: MyItems(
                   "Robbery", 0xffed622b, "/health"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RobberyCasesPage()));
            }
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 120),
        ],
        ),
    );
  }

}
