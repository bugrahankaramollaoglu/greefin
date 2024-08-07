import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as asd;
import 'package:greefin/utilities/my_colors.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as xxx;
import 'package:text_divider/text_divider.dart';

class GreenMap extends StatefulWidget {
  const GreenMap({super.key});

  @override
  State<GreenMap> createState() => _GreenMapState();
}

class _GreenMapState extends State<GreenMap> {
  xxx.LatLng? sourceLatLng;
  xxx.LatLng? destinationLatLng;
  final Completer<asd.GoogleMapController> _controller = Completer();
  Set<asd.Marker> _markers = {};
  Set<asd.Polyline> _polylines = {};

  int walk_minute = 0;
  double walk_carbon = 0.0;

  int bicycle_minute = 0;
  double bicycle_carbon = 0.0;

  int car_minute = 0;
  double car_carbon = 0.0;

  int bike_minute = 0;
  double bike_carbon = 0.0;

  int calculateWalkMinute(int distance) {
    int d = distance * 1000;
    return (d / 96).round();
  }

  int calculateBicycleMinute(int distance) {
    int d = distance * 1000;
    return (d / 200).round();
  }

  int calculateCarMinute(int distance) {
    int d = distance * 1000;
    return (d / 800).round();
  }

  int calculateBikeMinute(int distance) {
    int d = distance * 1000;
    return (d / 600).round();
  }

  void _addMarker(asd.LatLng latLng) {
    xxx.LatLng convertedLatLng = xxx.LatLng(latLng.latitude, latLng.longitude);
    setState(() {
      if (sourceLatLng == null) {
        sourceLatLng = convertedLatLng;
        destinationLatLng = null;
        _markers = {
          asd.Marker(
            markerId: const asd.MarkerId('sourceMarker'),
            position: latLng,
            icon: asd.BitmapDescriptor.defaultMarkerWithHue(
                asd.BitmapDescriptor.hueRed),
            infoWindow: const asd.InfoWindow(
              title: 'Source',
              snippet: 'Source location',
            ),
          ),
        };
        _polylines.clear();
      } else if (destinationLatLng == null) {
        destinationLatLng = convertedLatLng;
        _markers.add(
          asd.Marker(
            markerId: const asd.MarkerId('destinationMarker'),
            position: latLng,
            icon: asd.BitmapDescriptor.defaultMarkerWithHue(
                asd.BitmapDescriptor.hueBlue),
            infoWindow: const asd.InfoWindow(
              title: 'Destination',
              snippet: 'Destination location',
            ),
          ),
        );
        _addPolyline();
      } else {
        sourceLatLng = null;
        destinationLatLng = null;
        _markers.clear();
        _polylines.clear();
      }
    });
  }

  void _openMapHint() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Center(child: Text('Hold on the map to pin source & destination!')),
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addPolyline() {
    if (sourceLatLng != null && destinationLatLng != null) {
      setState(() {
        _polylines = {
          asd.Polyline(
            polylineId: const asd.PolylineId('polyline'),
            points: [
              asd.LatLng(sourceLatLng!.latitude, sourceLatLng!.longitude),
              asd.LatLng(
                  destinationLatLng!.latitude, destinationLatLng!.longitude),
            ],
            color: Colors.green,
            width: 5,
          ),
        };
      });
    }
  }

/*   void _calculateDistance() {
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
  } */

  String formatTime(int minutes) {
    if (minutes < 60) {
      return '${minutes}mn';
    } else if (minutes < 1440) {
      // 1440 minutes in a day
      final hours = (minutes / 60).floor();
      final remainingMinutes = minutes % 60;
      return '${hours}h${remainingMinutes > 0 ? '$remainingMinutes mn.' : ''}';
    } else {
      final days = (minutes / 1440).floor();
      final remainingMinutes = minutes % 1440;
      final hours = (remainingMinutes / 60).floor();
      final remainingMinutesAfterHours = remainingMinutes % 60;
      return '${days}d${hours > 0 ? ' ${hours}h' : ''}';
    }
  }

  void _openBottomSheet() {
    setState(() {
      walk_minute = calculateWalkMinute(
          (xxx.SphericalUtil.computeDistanceBetween(
                      sourceLatLng!, destinationLatLng!) /
                  1000)
              .round());
      walk_carbon = walk_minute * 0;

      bicycle_minute = calculateBicycleMinute(
          (xxx.SphericalUtil.computeDistanceBetween(
                      sourceLatLng!, destinationLatLng!) /
                  1000)
              .round());
      bicycle_carbon = bicycle_minute * 0;

      car_minute = calculateCarMinute((xxx.SphericalUtil.computeDistanceBetween(
                  sourceLatLng!, destinationLatLng!) /
              1000)
          .round());
      car_carbon = car_minute * 0.171;
      car_carbon = double.parse(car_carbon.toStringAsFixed(2));

      bike_minute = calculateBikeMinute(
          (xxx.SphericalUtil.computeDistanceBetween(
                      sourceLatLng!, destinationLatLng!) /
                  1000)
              .round());
      bike_carbon = bike_minute * 0.129;
      bike_carbon = double.parse(bike_carbon.toStringAsFixed(2));
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20,
          ),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: 600,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 224, 221, 221),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 32, 32),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Calculate your carbon emission',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Divider(),
                sourceLatLng != null && destinationLatLng != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(width: 10),
                          Text(
                            'Source: (${sourceLatLng!.latitude.toStringAsFixed(2)}, ${sourceLatLng!.longitude.toStringAsFixed(2)})',
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 10),
                destinationLatLng != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.flag, color: Colors.blue),
                          const SizedBox(width: 10),
                          Text(
                            'Destination: (${destinationLatLng!.latitude.toStringAsFixed(2)}, ${destinationLatLng!.longitude.toStringAsFixed(2)})',
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 20),
                sourceLatLng != null && destinationLatLng != null
                    ? TextDivider.horizontal(
                        text: Text(
                          '${(xxx.SphericalUtil.computeDistanceBetween(sourceLatLng!, destinationLatLng!) / 1000).toStringAsFixed(2)} km',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.black87,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      )
                    : Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 300,
                          ),
                          child: const Text(
                            textAlign: TextAlign.center,
                            'Please select both source and destination markers.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                // Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                MyColors().color10.withOpacity(0.65),
                            child: Icon(
                              Icons.directions_walk,
                              color: MyColors().color6,
                              size: 40,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors().color6.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 240,
                                height: 70,
                                // child: ,
                              ),
                            ),
                            const Positioned(
                              top: 22,
                              left: 35,
                              child: Text(
                                'Walk',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              left: 35,
                              child: Text(
                                formatTime(walk_minute),
                                style: TextStyle(
                                  color: MyColors().color5,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 35,
                              right: 35,
                              child: Text(
                                'Carbon Free!',
                                style: TextStyle(
                                  color: MyColors().color10,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                MyColors().color10.withOpacity(0.65),
                            child: Icon(
                              Icons.pedal_bike,
                              color: MyColors().color6,
                              size: 40,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors().color6.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 240,
                                height: 70,
                                // child: ,
                              ),
                            ),
                            const Positioned(
                              top: 22,
                              left: 35,
                              child: Text(
                                'Bicycle',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              left: 35,
                              child: Text(
                                formatTime(bicycle_minute),
                                style: TextStyle(
                                  color: MyColors().color5,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 35,
                              right: 35,
                              child: Text(
                                'Carbon Free!',
                                style: TextStyle(
                                  color: MyColors().color10,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                MyColors().color10.withOpacity(0.65),
                            child: Icon(
                              Icons.directions_car,
                              color: MyColors().color6,
                              size: 40,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors().color6.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 240,
                                height: 70,
                                // child: ,
                              ),
                            ),
                            const Positioned(
                              top: 22,
                              left: 35,
                              child: Text(
                                'Car',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              left: 35,
                              child: Text(
                                formatTime(car_minute),
                                style: TextStyle(
                                  color: MyColors().color5,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              right: 35,
                              child: Text(
                                '$car_carbon kg CO2',
                                style: TextStyle(
                                  color: MyColors().color5,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                MyColors().color10.withOpacity(0.65),
                            child: Icon(
                              Icons.motorcycle_rounded,
                              color: MyColors().color6,
                              size: 40,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors().color6.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 240,
                                height: 70,
                                // child: ,
                              ),
                            ),
                            const Positioned(
                              top: 22,
                              left: 35,
                              child: Text(
                                'Bike',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              left: 35,
                              child: Text(
                                formatTime(bike_minute),
                                style: TextStyle(
                                  color: MyColors().color5,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              right: 35,
                              child: Text(
                                '$bike_carbon kg CO2',
                                style: TextStyle(
                                  color: MyColors().color5,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: MyColors().color6,
                    ),
                    label: Text(
                      'Close',
                      style: TextStyle(
                        color: MyColors().color6,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors().color10.withOpacity(0.65),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthh = MediaQuery.of(context).size.width;
    double heightt = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          body: asd.GoogleMap(
            initialCameraPosition: const asd.CameraPosition(
              target: asd.LatLng(41.330949, 36.290303),
              zoom: 12,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (asd.GoogleMapController controller) {
              _controller.complete(controller);
            },
            onLongPress: _addMarker,
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors().color10.withOpacity(0.65),
              elevation: 20,
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: widthh / 2.5,
          child: ElevatedButton(
            onPressed: _openMapHint,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.withOpacity(0.7),
              elevation: 20,
            ),
            child: const Icon(
              Icons.help,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: ElevatedButton(
            onPressed: _openBottomSheet,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.withOpacity(0.7),
              elevation: 20,
            ),
            child: const Icon(
              Icons.calculate_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
