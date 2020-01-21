// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:location/location.dart';


class AnimateCamera extends StatefulWidget {
  const AnimateCamera();
  @override
  State createState() => AnimateCameraState();
}

class AnimateCameraState extends State<AnimateCamera> {
  GoogleMapController mapController;

  var currentLocation = LocationData;

  var location = new Location();

  double lat = 0.0,long = 0.0;

  Future<bool> _onBackPressed() {
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
    location.onLocationChanged().listen((LocationData currentLocation) {
    setState(() {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      });
    });
  }
  void askPermission() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
  }

  void setMap() {
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
            ),
          ),
        ),
      ],
    ),
    );
  }
}
