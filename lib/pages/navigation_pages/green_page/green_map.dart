import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:location/location.dart';

class GreenMap extends StatefulWidget {
  const GreenMap({super.key});

  @override
  State<GreenMap> createState() => _GreenMapState();
}

class _GreenMapState extends State<GreenMap> {
  LatLng atakum = LatLng(41.330949, 36.290303);
  LatLng atakum2 = LatLng(41.313949, 36.280303);
  LocationData? currentLocation;
  Location location = Location();
  Completer<GoogleMapController> _controller = Completer();,



  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    currentLocation = await location.getLocation();
    location.onLocationChanged.listen((LocationData loc) {
      setState(() {
        currentLocation = loc;
      });
      _moveCamera();
    });
  }

  Future<void> _moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    if (currentLocation != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 15,
        ),
      ));
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    width: 100, // Adjust the width as needed
                    height: 5, // Adjust the height as needed
                    decoration: BoxDecoration(
                      color: MyColors().color8, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(
                          5), // Adjust the border radius as needed
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Calculate your carbon emission',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColors().color8,
                  ),
                ),
              ),


            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              zoom: 12,
              target: atakum,
            ),
            markers: {
              Marker(
                markerId: MarkerId('sourceLocation'),
                icon: BitmapDescriptor.defaultMarker,
                position: atakum,
              ),
              Marker(
                markerId: MarkerId('destinationLocation'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
                position: atakum2,
              ),
              if (currentLocation != null)
                Marker(
                  markerId: MarkerId('currentLocation'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Positioned(
          top: 30,
          left: 20,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors().color10.withOpacity(0.7),
              elevation: 20,
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: MyColors().color6,
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 10,
          child: FloatingActionButton(
            elevation: 20,
            onPressed: _moveCamera,
            backgroundColor: MyColors().color10.withOpacity(0.7),
            child: Icon(
              Icons.my_location,
              color: MyColors().color6,
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 10,
          child: FloatingActionButton(
            onPressed: _openBottomSheet,
            elevation: 20,
            backgroundColor: MyColors().color10.withOpacity(0.7),
            child: Icon(
              Icons.energy_savings_leaf_rounded,
              color: MyColors().color6,
            ),
          ),
        ),
      ],
    );
  }
}
