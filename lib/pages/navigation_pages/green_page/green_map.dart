import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GreenMap extends StatefulWidget {
  const GreenMap({super.key});

  @override
  State<GreenMap> createState() => _GreenMapState();
}

class _GreenMapState extends State<GreenMap> {
  static const myLocation = LatLng(41.32859, 36.2846729);
  static const myDestination = LatLng(41.32059, 36.2946729);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: myLocation,
        zoom: 14
      ),
      markers: {
        Marker(
          markerId: MarkerId('current_location'),
          icon: BitmapDescriptor.defaultMarker,
          position: myLocation,
        ),
        Marker(
          markerId: MarkerId('current_destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: myDestination,
        ),
      },
    ));
  }
}
