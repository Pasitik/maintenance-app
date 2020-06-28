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

class Repairs extends StatefulWidget {
  @override
  _RepairsState createState() => _RepairsState();
}

class _RepairsState extends State<Repairs> {
  GoogleMapController mapController;
  Location location = new Location();

  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  // Stateful Data
  //BehaviorSubject<double> radius = BehaviorSubject(seedValue: 100.0);
  Stream<dynamic> query;

  // Subscription
  StreamSubscription subscription;


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
    );//);
  }

  _addGeoPoint() async {
    var error;
    LocationData currentLocation ;

    var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
      currentLocation = null;
    }
    Navigator.of(context).pop();
  }


  LocationData currentLocation;




  //submit location to db

  var Timestamp=DateTime.now().toUtc().millisecondsSinceEpoch;


  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    //appbar
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
       /* title: Text('Dash',
            style: TextStyle(
              color: Colors.white,
            )),*/
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        children: <Widget>[
          InkWell(
            child:MyItems(Icons.healing, "Traffic lights", 0xffed622b, "/health"),
              onTap: () {
                Future<DocumentReference> addGeoPoint() async{
                  var pos = await location.getLocation();
                  GeoFirePoint point= geo.point(latitude: pos.latitude, longitude: pos.longitude);
                  return databaseReference.collection("Traffic").add({
                    "info":'Faulty traffic lights',
                    "location":point.data,
                    "timestamp": Timestamp

                  });
                }
                addGeoPoint();

              }),

          InkWell(
            child: MyItems(Icons.directions_bus, "Street lights", 0xff26cb3c, "/roads"),
              onTap: () {
                Future<DocumentReference> addGeoPoint() async{
                  var pos = await location.getLocation();
                  GeoFirePoint point= geo.point(latitude: pos.latitude, longitude: pos.longitude);
                  return databaseReference.collection("Street_lights").add({
                    "info":'Faulty Steet lights',
                    "location":point.data,
                    "timestamp": Timestamp

                  });
                }
                addGeoPoint();

              }),
          InkWell(
            child: MyItems(Icons.book, "Potholes", 0xffff3266, "/edu"),
              onTap: () {
                Future<DocumentReference> addGeoPoint() async{
                  var pos = await location.getLocation();
                  GeoFirePoint point= geo.point(latitude: pos.latitude, longitude: pos.longitude);
                  return databaseReference.collection("Potholes").add({
                    "info":'Potholes',
                    "location":point.data,
                    "timestamp": Timestamp

                  });

                }
                addGeoPoint();

              }),
          InkWell(
            child: MyItems(Icons.healing, "Blockage", 0xff622f74, "/san"),
              onTap: () {
                Future<DocumentReference> addGeoPoint() async{
                  var pos = await location.getLocation();
                  GeoFirePoint point= geo.point(latitude: pos.latitude, longitude: pos.longitude);
                  return databaseReference.collection("Blockage").add({
                    "info":'There is something blocking this road',
                    "location":point.data,
                    "timestamp": Timestamp

                  });
                }
                addGeoPoint();

              }),

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
      /*drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Bandoh Kelvin"),
              accountEmail: new Text('kelquans@gmail.com'),
            ),
            new ListTile(
              title: new Text("Home"),
              leading: new Icon(Icons.home),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            new ListTile(
              title: new Text("view ratings"),
              leading: new Icon(Icons.add_to_queue),
            ),
            new ListTile(
              title: new Text("logout"),
              leading: new Icon(Icons.arrow_downward),
            )
          ],
        ),
      ),*/
    );
  }
}