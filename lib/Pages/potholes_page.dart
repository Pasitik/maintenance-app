import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/map.dart';


class PotholesPage extends StatefulWidget {
  @override
  _PotholesPageState createState() => _PotholesPageState();
}

class _PotholesPageState extends State<PotholesPage> {

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Potholes"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Potholes').snapshots(),
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
