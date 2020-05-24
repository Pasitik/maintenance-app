import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/map.dart';


class BreakdownPage extends StatefulWidget {
  @override
  _BreakdownPageState createState() => _BreakdownPageState();
}

class _BreakdownPageState extends State<BreakdownPage> {

  final databaseReference = Firestore.instance;
  var query=Firestore.instance.collection('Car_breakdown');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BreakdownPage"),
      ),
      body: StreamBuilder(
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
