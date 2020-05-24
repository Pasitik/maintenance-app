import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class Nav {
  bool _arrived = false;
  MapboxNavigation _directions;
  double _startLat;
  double _endLat;
  double _startLong;
  double _endLong;
  String _mode;

  Nav(startLat, startLong, endLat, endLong, modeOfTransport) {
    this._startLat = startLat;
    this._startLong = startLong;
    this._endLat = endLat;
    this._endLong = endLong;
    this._mode = modeOfTransport;
  }

  void navSetup() {
    this._directions = MapboxNavigation(onRouteProgress: (arrived) async {
      this._arrived = arrived;
      if (_arrived) {
        this._directions.finishNavigation();

      }
    }, );
  }

  Future<void> startNav( Function a) async {

    navSetup();
    final start = Location(
        name: "Source", latitude: this._startLat, longitude: this._startLong);
    final end = Location(
        name: "Destination", latitude: this._endLat, longitude: this._endLong);
    a();
    await _directions.startNavigation(
        origin: start,
        destination: end,
        mode: this._mode=="driving"? NavigationMode.driving: NavigationMode.walking,
        simulateRoute: false);

  }
}
