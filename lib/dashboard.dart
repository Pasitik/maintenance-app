import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'repairs.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GoogleMapController mapController;
  Location location = new Location();

  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  // Stateful Data
  //BehaviorSubject<double> radius = BehaviorSubject(seedValue: 100.0);
  Stream<dynamic> query;

  // Subscription
  StreamSubscription subscription;
  var Timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;

  Material MyItems(IconData icon, String heading, int color, String page) {
    return Material(
      color: Colors.black45,
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadiusDirectional.circular(24.0),
      //child: GestureDetector(
      //onTap: () {
      //Navigator.pushNamed(context, page);
      //},
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
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Material(
                  color: new Color(color),
                  borderRadius: BorderRadius.circular(24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ); //);
  }

  LocationData currentLocation;

  //submit location to db

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    //appbar
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.grey,
        /*title: Text('Dash',
            style: TextStyle(
              color: Colors.white,
            )),*/
      ),*/
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        children: <Widget>[
          InkWell(
            child: MyItems(
                Icons.healing, "Maintainance Issues", 0xffed622b, "/health"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Repairs()));
            },
          ),
          InkWell(
            child: MyItems(Icons.directions_bus, "Roads", 0xff26cb3c, "/roads"),
            onTap: () {
              Future<DocumentReference> addGeoPoint() async {
                var pos = await location.getLocation();
                GeoFirePoint point =
                    geo.point(latitude: pos.latitude, longitude: pos.longitude);
                return databaseReference.collection("Robbery").add({
                  "info": 'there is a roberry taking place',
                  "location": point.data,
                  "timestamp": Timestamp
                });
              }

              addGeoPoint();
            },
          ),
          InkWell(
            child: MyItems(Icons.book, "Accident", 0xffff3266, "/edu"),
            onTap: () {
              print(Timestamp);
              Future<DocumentReference> addGeoPoint() async {
                var pos = await location.getLocation();
                GeoFirePoint point =
                    geo.point(latitude: pos.latitude, longitude: pos.longitude);
                return databaseReference.collection("Accidents").add({
                  "info": 'An accident just occured',
                  "location": point.data,
                  "timestamp": Timestamp
                });
              }

              addGeoPoint();
            },
          ),
          InkWell(
              child: MyItems(Icons.cloud, "Robbery", 0xfff4c83f, "/sec"),
              onTap: () {
                Future<DocumentReference> addGeoPoint() async {
                  var pos = await location.getLocation();
                  GeoFirePoint point = geo.point(
                      latitude: pos.latitude, longitude: pos.longitude);
                  return databaseReference.collection("Robbery").add({
                    "info": 'there is a roberry taking place',
                    "location": point.data,
                    "timestamp": Timestamp
                  });
                }

                addGeoPoint();
              }),
          InkWell(
            child: MyItems(Icons.healing, "Car Breakdown", 0xff622f74, "/san"),
            onTap: () {
              Future<DocumentReference> addGeoPoint() async {
                var pos = await location.getLocation();
                GeoFirePoint point =
                    geo.point(latitude: pos.latitude, longitude: pos.longitude);
                return databaseReference.collection("Car_breakdown").add({
                  "info": 'Car breakdown, we need a toling service or mechanic',
                  "location": point.data,
                  "timestamp": Timestamp
                });
              }

              addGeoPoint();

              // print("Blockage");
            },
          ),

          // MyItems(Icons.directions_railway, "railways", 0xff7297ff, "/rail"),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          //StaggeredTile.extent(2, 120.0),
        ],
      ),
    );
  }
}
