import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AccountState();
  }
  
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Account Details",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold 
      //     ),
      //   ),
      //   elevation: 10,
      //   backgroundColor: Colors.white,
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: Center(
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        
          children: <Widget>[

            Padding(padding: EdgeInsets.all(10),),

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
                      color: Colors.blue,
                      shape: CircleBorder(),
                      child: Padding
                      (
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.person, color: Colors.white, size: 30.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('View', style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold)),
                    Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
                  ]
                ),
              ),
            onTap: () {},

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
                        child: Icon(Icons.edit, color: Colors.white, size: 30.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    
                    Text('Edit ', style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold)),
                    Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
                  ]
                ),
              ),
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
                      color: Colors.green,
                      shape: CircleBorder(),
                      child: Padding
                      (
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.verified_user, color: Colors.white, size: 30.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    
                    Text('Verify ', style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold)),
                    Text('User', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  ]
                ),
              ),
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
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.settings_applications, color: Colors.white, size: 35.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('App', style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold)),
                    Text('Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
                  ]
                ),
              ),
            onTap: () {},

            ),
            

            
          ],
          staggeredTiles: [
            StaggeredTile.extent(2,100.0),
            StaggeredTile.extent(1, 180.0), // For Maps
            StaggeredTile.extent(1, 180.0), // For SOS
            StaggeredTile.extent(1, 180.0), // For Account Settings
            StaggeredTile.extent(1, 180.0), // For blank
          ],
        ),
      ),
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