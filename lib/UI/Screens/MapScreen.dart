import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide MapType;
import 'package:map_launcher/map_launcher.dart' ;
import 'package:superstore/UI/ColorsUi.dart';//as MapLuncher
class MapScreen extends StatefulWidget {
  // const MyApp({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng superMall = const LatLng(31.516796177849113, 34.45006091147662);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

  }
  goToMapApp(LatLng latLng)async{
    await MapLauncher.launchMap(
        mapType: MapType.google,
        coords: Coords(latLng.latitude, latLng.longitude),
        title: 'Super Mall');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    ToLocationAndAddMarker(LatLng(position.latitude, position.longitude));
    return await Geolocator.getCurrentPosition();
  }

  ToLocationAndAddMarker(LatLng latLng){
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng,16));
    Marker marker =  Marker(markerId: MarkerId("super Mall"),position: latLng);
    markers.clear();
    markers.add(marker);
    setState(() {

    });
  }



  Set<Marker> markers = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Local Super Mall'),
        backgroundColor: ColorsUi.Color2,
        elevation: 0,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()=>goToMapApp(superMall),
      //   // ()=>ToLocationAndAddMarker(tagMall),
      //   child: Icon(Icons.gps_fixed),
      // ),
      body:

      Column(
        children: [
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: ColorsUi.Color2
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    goToMapApp(superMall);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.track_changes_outlined,color: Colors.white,),
                      Text('Track to Super Mall',style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    ToLocationAndAddMarker(superMall);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.location_on,color: Colors.white,),
                      Text('Local Super Mall',style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    _determinePosition();


                  },
                  child: Column(
                    children: [
                      Icon(Icons.gps_fixed,color: Colors.white,),
                      Text('My Local',style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),


              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              // onTap: (LatLng point){
              //   // mapController.animateCamera(CameraUpdate.newLatLngZoom(point,15));
              //   log(point.latitude.toString());
              //   log(point.longitude.toString());
              //   ToLocationAndAddMarker(point);
              // },
              markers: markers,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: superMall,
                zoom: 15,
              ),
            ),
          ),
        ],
      ),
    )
    ;
  }
}