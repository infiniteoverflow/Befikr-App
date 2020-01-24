import 'package:befikr_app/account.dart';
import 'package:befikr_app/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget
{
  FirebaseUser user;
  HomePage(user) {
    this.user = user;
  }
  @override
  HomePageState createState() => HomePageState(this.user);
}

class HomePageState extends State<HomePage>
{

  FirebaseUser user;
  HomePageState(user) {
    this.user = user;
  }

  var location = Location();
  double lat,long;
  var db;

  String name="-";

  @override
  void initState() {
    // TODO: implement initState
    db = FirebaseDatabase.instance.reference().child("Users").child(user.uid);
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        if(key == 'Name') {
          setState(() {
            name = values;
          });
        }
    });
 });
    location.onLocationChanged().listen((LocationData currentLocation) {
    setState(() {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      print(user.uid);
      FirebaseDatabase.instance.reference().child("Users").child(user.uid)
                  .child("location").set({
                    'Latitude':lat,
                    'Longitude':long
                  });
      });
    });
    super.initState();
  }

  static final List<String> chartDropdownItems = [ 'Last 7 days', 'Last month', 'Last year' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;



  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text('Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
        
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[

          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text(
                        "Welcome ${name.split(' ')[0]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),
                  Material
                  (
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.person_pin_circle, color: Colors.white, size: 35.0),
                      )
                    )
                  )
                ]
              ),
            ),
            color: Colors.yellow
          ),

          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.teal,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.location_on, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Start Sharing', style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold)),
                  Text('My Location', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 17.0)),
                ]
              ),
            ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AnimateCamera(lat,long,user))),

          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.amber,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  
                  Text('Send ', style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold)),
                  Text('SOS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                ]
              ),
            ),
          ),

          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text(
                        "Account Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        )
                    ],
                  ),
                  Material
                  (
                    color: Colors.blue,
                    shape: CircleBorder(),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.settings, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Account(this.user)));
            }
          ),
          
          _buildTile(
            Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text(
                        "How to Use BEFIKR",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        )
                    ],
                  ),
                  Material
                  (
                    color: Colors.brown,
                    shape: CircleBorder(),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.info, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
                  )
                ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  ),
                      Material(
                        color: Colors.red,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.exit_to_app, color: Colors.white, size: 30.0),
                        )
                      ),
                    ],
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            }
          )
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 110.0), // For Welcome
          StaggeredTile.extent(1, 180.0), // For Maps
          StaggeredTile.extent(1, 180.0), // For SOS
          StaggeredTile.extent(2, 110.0), // For Account Settings
          StaggeredTile.extent(2, 110.0), // For blank
          StaggeredTile.extent(2, 110.0), // For Logout
        ],
      )
    );
  }

  Widget _buildTile(Widget child,{Color color=Colors.white,Function() onTap }) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      color:color,
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}