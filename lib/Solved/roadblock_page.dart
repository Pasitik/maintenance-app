import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/map.dart';
import 'package:maintenance/userLocation.dart';
import 'package:maintenance/Nav.dart';
import 'package:location/location.dart';

class RoadblockPage extends StatefulWidget {
  @override
  _RoadblockPageState createState() => _RoadblockPageState();
}

class _RoadblockPageState extends State<RoadblockPage> {

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlockedRoad"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Blockage').snapshots(),
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
