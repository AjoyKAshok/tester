import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}
class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(11.711685, 79.762685);
  static const LatLng destination = LatLng(11.71677, 79.767321);

  BitmapDescriptor customIcon;


  LocationData currentLocation;

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDKEaHXFJX0ZZ0zlCII7lG4vL9F0NlTqQE", // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      print("getpolypointss...${result.points.length}..${result.status}");
      setState(() {});
    }
  }
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
            setState(() {
              currentLocation = location;
            });

            print("current loc...$currentLocation");
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
            ),
          ),
        );
        setState(() {
          currentLocation = newLoc;
        });
        print("onLocationChanged....${newLoc.longitude}..${newLoc.latitude}");
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPolyPoints();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(20, 20)),
        'images/rider.png')
        .then((d) {
      customIcon = d;
    });
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        height: double.infinity,
        child:  currentLocation == null
            ? const Center(child: Text("Loading"))
            : GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
                currentLocation.latitude, currentLocation.longitude),
            zoom: 13.5,
          ),
          compassEnabled: true,
          markers: {
            Marker(
              markerId: const MarkerId("currentLocation"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
              position: LatLng(
                  currentLocation.latitude, currentLocation.longitude),
            ),
             Marker(
              markerId: MarkerId("source"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              position: sourceLocation,
            ),
            const Marker(
              markerId: MarkerId("destination"),
              position: destination,
            ),
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
            getPolyPoints();
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: const Color(0xFF7B61FF),
              width: 6,
            ),
          },
        ),
      )

     ,
    );
  }
}