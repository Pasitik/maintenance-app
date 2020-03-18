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
import 'existing.dart';
import 'fun.dart';

class Stuff extends StatefulWidget {
  @override
  StuffState createState() => StuffState();
}

class StuffState extends State<Stuff> {

  String a="Robbery";


  Stream<dynamic> query;
  Firestore firestore = Firestore.instance;
  StreamSubscription subscription;
  final databaseReference = Firestore.instance;

  /*Future getReports(String type) async {
    QuerySnapshot qn = await databaseReference.collection(type).getDocuments();
    return qn.documents;
  }*/
func Func=new func();
  Material MyItems(String type) {
    return Material(
        child: Container(
      child: FutureBuilder(
          future: Func.getReports(type),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator()
              );
            } else {
            return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context , index) {
                    return Card(
                        color: Colors.black12,
                        child: ListTile(
                          title: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                new Text(
                                  snapshot.data[index].data["info"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                          trailing: new Column(
                            children: <Widget>[
                              new IconButton(
                                  icon: new Icon(Icons.map),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FireMap()),
                                    );
                                  }),
                            ],
                          ),
                        ));
                  });
            }
          }),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyItems(a)
    );
  }
}
