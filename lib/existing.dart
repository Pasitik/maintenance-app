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

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Robbery').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(
          child: CircularProgressIndicator(),
        );
        return ListView(
          children: snapshot.data.documents.map( (document) {
            return Card(
                          child: ListTile(
                title: Text(document['info']),
                subtitle: Text(document['info']),
                trailing: Icon(Icons.my_location),
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FireMap()));
                },
              ),
            );
          } ).toList(),
        );
      });
  }

  // read data from cloud firestore
  // void getData() async {
  //   await databaseReference
  //     .collection("Robbery")
  //     .getDocuments()
  //     .then((QuerySnapshot snapshot) {
  //       snapshot.documents.forEach((f) => print(f.data));
  //     });
  //     print("Hello");
  // }

}
