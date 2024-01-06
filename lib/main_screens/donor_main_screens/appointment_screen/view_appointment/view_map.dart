import 'dart:async';

import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/google.dart';
import 'package:blood_link/settings/print.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ViewMap extends StatefulWidget {
  const ViewMap(
      {super.key, required this.bank, required this.lat, required this.long});
  final BloodBank bank;
  final double lat;
  final double long;

  @override
  State<ViewMap> createState() => ViewMapState();
}

class ViewMapState extends State<ViewMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _kGooglePlex;
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = Google.apikey;

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  late LatLng startLocation;
  late LatLng endLocation;

  double distance = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startLocation = LatLng(27.6683619, 85.3101895);
    // endLocation = LatLng(27.6875436, 85.2751138);
    try {
      startLocation = LatLng(widget.lat, widget.long);
      endLocation = LatLng(double.parse(widget.bank.latitude.toString()),
          double.parse(widget.bank.longitude.toString()));

      markers.add(Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Starting Point ',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add distination location marker
        markerId: MarkerId(endLocation.toString()),
        position: endLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Destination Point ',
          snippet: 'Destination Marker',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      _kGooglePlex = CameraPosition(
        // target: LatLng(double.parse(widget.bank.latitude),
        //     double.parse(widget.bank.longitude)),
        target: startLocation,
        zoom: 14.4746,
      );
      getDirections();
    } catch (e) {
      Print(e.toString());
      print("jbvelk/nrvdke");
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    // print(result.points.length);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    print(totalDistance);

    setState(() {
      distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Constants.orange,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Map"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              zoomControlsEnabled: true,
              polylines: Set<Polyline>.of(polylines.values), //polylines

              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                try {
                  _controller.complete(controller);
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
            Positioned(
                bottom: 200,
                left: 50,
                child: Container(
                    child: Card(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                          "Total Distance: " +
                              distance.toStringAsFixed(2) +
                              " KM",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                )))
          ],
        ),
      ),
      //   floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
