// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:location/location.dart';


class AnimateCamera extends StatefulWidget {

  double lat,long;
  FirebaseUser user;
  AnimateCamera(double lat,double long,user) {
    this.lat = lat;
    this.long = long;
    this.user = user;
  }

  @override
  State createState() => AnimateCameraState(this.lat,this.long,this.user);
}

class AnimateCameraState extends State<AnimateCamera> {
  GoogleMapController mapController;

  var currentLocation = LocationData;

  var location = new Location();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        lat,
        long,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  double lat,long;
  FirebaseUser user;

  AnimateCameraState(double lat,double long,user) {
    this.lat = lat;
    this.long = long;
    this.user = user;
  }

  Future<bool> Function() _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
        ) ??
        false;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMap();
  }

  @override
  void initState() {
    askPermission();
    print("hii");
    location.onLocationChanged().listen((LocationData currentLocation) {
    setState(() {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;

      _add();
  
      FirebaseDatabase.instance.reference().child("Users")
            .child(user.uid)
            .child("location")
            .update({
              'Latitude' : lat,
              'Longitude' : long,
            });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void askPermission() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
  }

  void setMap() {
    print(lat);
    print(long);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(lat,long),
          tilt: 40.0,
          zoom:16.0
        )
      )
    );
  }

  Future<bool> Function() onWill() {
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                    const CameraPosition(target: LatLng(0.0, 0.0)),
                markers: Set<Marker>.of(markers.values)
              ),
            ),
          ),
        ],
      ),
      );
  }
}
