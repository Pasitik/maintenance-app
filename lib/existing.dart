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

  func Func=new func();



  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (_, index) {
                  return Center(
                      child: Card(
                          color: Colors.greenAccent,
                          child: ListTile(
                            title: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 400.0),
                                new InkWell(
                                    splashColor: Colors.red,
                                    onTap: () {
                                        Func.type = "Robbery";

                                      //Func.getReports("Robbery");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>Stuff()),
                                      );
                                      //Func.getReports("Robbery");
                                      //print("I was tapped");
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Text(
                                        'Robbery',
                                        textScaleFactor: 2.0,
                                      ),
                                    )),
                                new InkWell(
                                    splashColor: Colors.red,
                                    onTap: () {
                                      Func.getReports("");
                                      print("I was tapped");
                                    },
                                    child: Card(
                                      shape: BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        'Card with Beveled border',
                                        textScaleFactor: 2.0,
                                      ),
                                    )),
                                new InkWell(
                                    splashColor: Colors.red,
                                    onTap: () {
                                      print("I was tapped");
                                    },
                                    child: Card(
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Text(
                                        'Card with Beveled border',
                                        textScaleFactor: 2.0,
                                      ),
                                    )),
                                new Card(),
                                new Card()
                              ],
                            ),
                          )));
                })));
  }
}
