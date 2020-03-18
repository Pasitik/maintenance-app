import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'map.dart';
import 'stuff.dart';
import 'fun.dart';

class func{

  //Stream<dynamic> query;
  Geoflutterfire geo = Geoflutterfire();
  Firestore firestore = Firestore.instance;
  StreamSubscription subscription;
  final databaseReference = Firestore.instance;
String type;

String get types{
  return type;
}

  Future getReports(type) async {
   /* GeoFirePoint center = geo.point(latitude: 6.6694463, longitude: 1.5615684);
    var collectionReference =  databaseReference.collection(type);
    //var geoRef = geo.collection(collectionRef: collectionReference);
    var stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: 50, field: 'location');*/
    //return geoRef.within(center: center, radius: 50, field: 'info', strictMode: true);

    /*double radius = 50;
    String field = 'location';

    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);


    stream.listen((List<DocumentSnapshot> documentList) {
      // doSomething()
      databaseReference.collection(type).getDocuments();
    });*/

    QuerySnapshot qn = await databaseReference.collection(type).getDocuments();
    return qn.documents;
    //return stream;
  }


  /*void updateLocation() async {
    try {
      Position newPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));

      setState(() {
        _position = newPosition;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }*/

}