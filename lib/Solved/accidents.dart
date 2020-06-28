import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:maintenance/Nav.dart';
import 'package:maintenance/map.dart';
import 'package:maintenance/existing.dart';
import 'package:maintenance/userLocation.dart';

class AccidentsPage extends StatefulWidget {
  @override
  _AccidentsPageState createState() => _AccidentsPageState();
}

class _AccidentsPageState extends State<AccidentsPage> {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accidents"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Accidents').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
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
                ));
              }).toList(),
            );
          }),
    );
  }
}
