import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'userLocation.dart';
import 'Nav.dart';
class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
  //final name;
  //FireMap(this.name);
}

class FireMapState extends State<FireMap> {
  String _modeOfTransport = "";
  LocationData _currentLocation;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Marker _marker;

  final databaseReference = Firestore.instance;
  var query=Firestore.instance.collection('Accidents');
  bool _isLoading = false;
  Map<String, dynamic> forShow;

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      return new Scaffold(
        floatingActionButton: new RaisedButton(
          elevation: 14.0,
          color: Colors.blue,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: new Container(
            child: new Text(
              "Start Navigation",
              style: new TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          onPressed: () async {
            SimpleDialog a = new SimpleDialog(
              contentPadding: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: new Center(
                    child: new Text("Please select your mode of transport"),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: new RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _modeOfTransport = "walking";
                      });
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Walking",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: new RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _modeOfTransport = "driving";
                      });
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Driving",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            );
            await showDialog(
                context: context,
                builder: ((c) {
                  return a;
                }));
            // setState(() {
            //   _isLoading = true;
            // });
            Nav n;
            _currentLocation = await getUserLoc();
            if (_currentLocation == null) {
              n = new Nav(5.6127806, -0.2518546, forShow['loc']['lat'],
                  forShow['loc']['long'], _modeOfTransport);
            } else {
    n = new Nav(
                  _currentLocation.latitude,
                  _currentLocation.longitude,
                  forShow['loc']['lat'],
                  forShow['loc']['long'],
                  _modeOfTransport);
            }

            await n.startNav(() {
              // setState(() {
              //   _isLoading = false;
              // });
            });
          },
        ),
        body: new GoogleMap(
            mapToolbarEnabled: true,
            trafficEnabled: true,
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.4),
            myLocationEnabled: true,
            onMapCreated: (con) async {
              _marker = new Marker(
                markerId: MarkerId("1"),
                draggable: false,
                position: LatLng(forShow['loc']['lat'], forShow['loc']['long']),
                infoWindow: InfoWindow(title: "Problem Location"),//widget.name),
              );
              setState(() {
                markers[MarkerId("1")] = _marker;
              });
            },
            myLocationButtonEnabled: true,
            compassEnabled: true,
            markers: Set<Marker>.of(markers.values),
            initialCameraPosition: new CameraPosition(
                zoom: 14.0,
                target: LatLng(forShow['loc']['lat'], forShow['loc']['long']))),
      );
    } else {
      return new Container(
        color: Colors.white,
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }
  }
}
