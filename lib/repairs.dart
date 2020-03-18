import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dashboard.dart';
import 'map.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
class Repairs extends StatefulWidget {
  @override
  _RepairsState createState() => _RepairsState();
}

class _RepairsState extends State<Repairs> {
  Material MyItems(IconData icon, String heading, int color, String page) {
    return Material(
      color: Colors.black45,
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadiusDirectional.circular(24.0),
      //child: GestureDetector(
      //onTap: () {
      //Navigator.pushNamed(context, page);
      //},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    heading,
                    style: TextStyle(
                      color: new Color(color),
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Material(
                  color: new Color(color),
                  borderRadius: BorderRadius.circular(24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );//);
  }

  _addGeoPoint() async {
    var error;
    LocationData currentLocation ;

    var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
      currentLocation = null;
    }
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    //appbar
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
       /* title: Text('Dash',
            style: TextStyle(
              color: Colors.white,
            )),*/
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        children: <Widget>[
          InkWell(
            child:MyItems(Icons.healing, "Traffic lights", 0xffed622b, "/health"),
            onTap: (){
              //YYDialog YYDialogDemo(BuildContext context) {
                return YYDialog().build(context)
                  ..width = 220
                  ..height = 300
                  ..barrierColor = Colors.black.withOpacity(.3)
                  ..animatedFunc = (child, animation) {
                    return ScaleTransition(
                      child: child,
                      scale: Tween(begin: 0.0, end: 1.0).animate(animation),
                    );
                  }
                  ..widget(
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text( "By selcting this option you will be reporting faulty trafic lights in your cuurent location. We will like to inform that your current location will be submitted with you report.  "
                                  "Tap submit if you will like to proceed with your report."),
                              new RaisedButton(onPressed: _addGeoPoint(),
                                  child: Text("Submit")),
                            ],
                          ),
                        )
                      ),
                    ),
                  )
                  ..show();

              //}
            },
          ),
          InkWell(
            child: MyItems(Icons.directions_bus, "Street lights", 0xff26cb3c, "/roads"),
            onTap: (){
              return YYDialog().build(context)
                ..width = 220
                ..height = 300
                ..barrierColor = Colors.black.withOpacity(.3)
                ..animatedFunc = (child, animation) {
                  return ScaleTransition(
                    child: child,
                    scale: Tween(begin: 0.0, end: 1.0).animate(animation),
                  );
                }
                ..widget(
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text( "By selcting this option you will be reporting faulty trafic lights in your cuurent location. We will like to inform that your current location will be submitted with you report.  "
                                  "Tap submit if you will like to proceed with your report."),
                              new RaisedButton(onPressed: _addGeoPoint(),
                                  child: Text("Submit")),
                            ],
                          ),
                        /*  child:Text(
                            "By selcting this option you will be reporting faulty trafic lights in your cuurent location. We will like to inform that your current location will be submitted with you report.  "
                                "Tap submit if you will like to proceed with your report.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w100,
                            ),
                          ),*/
                        )
                    ),
                  ),

                )
                ..show();
            },
          ),
          InkWell(
            child: MyItems(Icons.book, "Potholes", 0xffff3266, "/edu"),
            onTap: (){
              return YYDialog().build(context)
                ..width = 220
                ..height = 300
                ..barrierColor = Colors.black.withOpacity(.3)
                ..animatedFunc = (child, animation) {
                  return ScaleTransition(
                    child: child,
                    scale: Tween(begin: 0.0, end: 1.0).animate(animation),
                  );
                }
                ..widget(
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text( "By selcting this option you will be reporting Potholes in your cuurent location. We will like to inform that your current location will be submitted with you report.  "
                                  "Tap submit if you will like to proceed with your report."),
                              new RaisedButton(onPressed: _addGeoPoint(),
                                  child: Text("Submit")),
                            ],
                          ),
                        )
                    ),
                  ),
                )
                ..show();
            },
          ),
          //InkWell(
           // child: MyItems(Icons.cloud, "Robbery", 0xfff4c83f, "/sec"),
           // onTap: (){
              //print("robbery");
            //},
         // ),
          InkWell(
            child: MyItems(Icons.healing, "Blockage", 0xff622f74, "/san"),
            onTap: (){
              return YYDialog().build(context)
                ..width = 220
                ..height = 300
                ..barrierColor = Colors.black.withOpacity(.3)
                ..animatedFunc = (child, animation) {
                  return ScaleTransition(
                    child: child,
                    scale: Tween(begin: 0.0, end: 1.0).animate(animation),
                  );
                }
                ..widget(
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text( "By selcting this option you will be reporting Road blockages in your cuurent location. We will like to inform that your current location will be submitted with you report.  "
                                  "Tap submit if you will like to proceed with your report."),
                              new RaisedButton(onPressed: _addGeoPoint(),
                                  child: Text("Submit")),
                            ],
                          ),
                        )
                    ),
                  ),
                )
                ..show();
            },
          ),

          // MyItems(Icons.directions_railway, "railways", 0xff7297ff, "/rail"),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          //StaggeredTile.extent(2, 120.0),
        ],
      ),
      /*drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Bandoh Kelvin"),
              accountEmail: new Text('kelquans@gmail.com'),
            ),
            new ListTile(
              title: new Text("Home"),
              leading: new Icon(Icons.home),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            new ListTile(
              title: new Text("view ratings"),
              leading: new Icon(Icons.add_to_queue),
            ),
            new ListTile(
              title: new Text("logout"),
              leading: new Icon(Icons.arrow_downward),
            )
          ],
        ),
      ),*/
    );
  }
}