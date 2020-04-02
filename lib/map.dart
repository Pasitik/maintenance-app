
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}


class FireMapState extends State<FireMap> {
  @override
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(24.150, -110.32),
    zoom: 10,
  );
  GoogleMapController mapController;
  CameraPosition _position = _kInitialPosition;
  MapType _currentMapType = MapType.normal;


  final Firestore _database = Firestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


//marker
  void initMarker(lugar, lugaresid) {
    var markerIdVal = lugaresid;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lugar['Latitud'], lugar['Longitud']),
      infoWindow: InfoWindow(title: lugar['Lugar'], snippet: lugar['tipo']),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  build(context) {
    // widgets go here
    return Scaffold(
          body: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
                mapType: _currentMapType,
                //trackCameraPosition: true
              onCameraMove:  _updateCameraPosition,

            ),
          ]
      ),
    );
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _position = position;
    });
  }


  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}

