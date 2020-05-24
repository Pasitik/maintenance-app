import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/map.dart';


class TrafficPage extends StatefulWidget {
  @override
  _TrafficPageState createState() => _TrafficPageState();
}

class _TrafficPageState extends State<TrafficPage> {

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Lights"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Traffic').snapshots(),
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder:  (context) => FireMap())
                        );
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
