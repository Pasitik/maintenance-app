import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/map.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:maintenance/userLocation.dart';
import 'package:maintenance/Nav.dart';
import 'package:location/location.dart';




class RobberyCasesPage extends StatefulWidget {
  @override
  _RobberyCasesPageState createState() => _RobberyCasesPageState();
}

class _RobberyCasesPageState extends State<RobberyCasesPage> {

  Geoflutterfire geo = Geoflutterfire();
  final databaseReference = Firestore.instance;
  Stream stream;

  //GeoFirePoint center = Geoflutterfire().point(latitude: 6.6694463, longitude: 1.5615684);

  //var collectionReference = databaseReference.collection('locations');

  //double radius = 50;
  //String field = 'info';

  //Stream streamer= Geoflutterfire().collection(collectionRef: Firestore.instance.collection("Robbery"))
    //  .within(center: Geoflutterfire().point(latitude: 6.6694463, longitude: 1.5615684), radius: 50, field:"info");


  @override
  void initState(){
    super.initState();
    geo = Geoflutterfire();
    var radius= 25.0;
    GeoFirePoint center = geo.point(latitude: 6.6694463, longitude: 1.5615684);
    stream =
      //var collectionReference = databaseReference.collection('Robbery');
       geo.collection(collectionRef: databaseReference.collection('Robbery')).within(
          center: center, radius: radius, field: 'info', strictMode: true);

  }

  var query=Firestore.instance.collection('Robbery');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Robbery cases"),
      ),
          body: StreamBuilder(
              //stream: Firestore.instance.collection('Robbery').snapshots(),
            stream: query.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator(),
          );
          return ListView(
            children: snapshot.data.documents.map((document) {
              return Card(
                child: ListTile(
                  title: Text(document['info']),
                  subtitle: Text(document['info']),
                  trailing: Icon(Icons.my_location),
                  onTap: () async {
                    GeoPoint destloc = document.data['location']['geopoint'];
                    LocationData loc = await getUserLoc();
                    Nav n = new Nav(loc.latitude,loc.longitude, destloc.latitude, destloc.longitude, "walking");
                    n.navSetup();
                    n.startNav();
                  },
                )
              );
            }).toList(),
          );
        }
      ),
    );
  }
}
