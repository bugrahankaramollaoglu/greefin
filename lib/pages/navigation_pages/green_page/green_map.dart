import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as asd;
import 'package:maps_toolkit/maps_toolkit.dart' as xxx;

class GreenMap extends StatefulWidget {
  const GreenMap({Key? key}) : super(key: key);

  @override
  State<GreenMap> createState() => _GreenMapState();
}

class _GreenMapState extends State<GreenMap> {
  xxx.LatLng? sourceLatLng;
  xxx.LatLng? destinationLatLng;
  Completer<asd.GoogleMapController> _controller = Completer();
  Set<asd.Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  void _addMarker(asd.LatLng latLng) {
    xxx.LatLng convertedLatLng = xxx.LatLng(latLng.latitude, latLng.longitude);
    setState(() {
      if (sourceLatLng == null) {
        // Add source marker (red)
        sourceLatLng = convertedLatLng;
        destinationLatLng = null; // Clear destination if any
        _markers = {
          asd.Marker(
            markerId: asd.MarkerId('sourceMarker'),
            position: latLng,
            icon: asd.BitmapDescriptor.defaultMarkerWithHue(
                asd.BitmapDescriptor.hueRed),
            infoWindow: asd.InfoWindow(
              title: 'Source',
              snippet: 'Source location',
            ),
          ),
        };
      } else if (destinationLatLng == null) {
        // Add destination marker (blue)
        destinationLatLng = convertedLatLng;
        _markers.add(
          asd.Marker(
            markerId: asd.MarkerId('destinationMarker'),
            position: latLng,
            icon: asd.BitmapDescriptor.defaultMarkerWithHue(
                asd.BitmapDescriptor.hueBlue),
            infoWindow: asd.InfoWindow(
              title: 'Destination',
              snippet: 'Destination location',
            ),
          ),
        );
      } else {
        // Clear markers and start over
        sourceLatLng = null;
        destinationLatLng = null;
        _markers.clear();
      }
    });
  }

  void _calculateDistance() {
    if (sourceLatLng != null && destinationLatLng != null) {
      double distance = xxx.SphericalUtil.computeDistanceBetween(
        sourceLatLng!,
        destinationLatLng!,
      ).toDouble();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Distance Calculation'),
            content: Text(
                'Distance between source and destination: ${(distance / 1000).toStringAsFixed(2)} km'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: asd.GoogleMap(
            initialCameraPosition: asd.CameraPosition(
              target: asd.LatLng(41.330949, 36.290303),
              zoom: 12,
            ),
            markers: _markers,
            onMapCreated: (asd.GoogleMapController controller) {
              _controller.complete(controller);
            },
            onLongPress: _addMarker,
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
              backgroundColor: Colors.green.withOpacity(0.7),
              elevation: 20,
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: ElevatedButton(
            onPressed: _calculateDistance,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.withOpacity(0.7),
              elevation: 20,
            ),
            child: Icon(
              Icons.calculate_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
