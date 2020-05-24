import 'package:location/location.dart';
import 'package:flutter/services.dart';

var currentLocation;

var location = new Location();
var error;

// Platform messages may fail, so we use a try/catch PlatformException.
Future<LocationData> getUserLoc() async {
  try {
    currentLocation = await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      error = 'Permission denied';
    }
    currentLocation = null;
  }

  return currentLocation;

}

void holdWait(){

}