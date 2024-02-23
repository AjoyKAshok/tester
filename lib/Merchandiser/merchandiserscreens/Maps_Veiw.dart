import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:merchandising/Fieldmanager/product_details.dart';
import 'package:merchandising/model/Location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'dart:math';
import 'package:merchandising/model/googledirections.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';

class markers {
  static Set<Marker> outlets = {};
}

class polyline {
  static Set<Polyline> route = {};
}

var points;
var destinationpoints;
double optimisedlat;
double optimisedlong;
int nearestoutletindex;

class mapmarkersinfo {
  static var int = "id";
  static var name = 'storename';
  static var area = 'area';
  static var country = 'country';
  static var number = 'number';
  static var distance = 'distance';
  static var city = 'city';
}

class MapVeiw extends StatefulWidget {
  @override
  _MapVeiwState createState() => _MapVeiwState();
}

class _MapVeiwState extends State<MapVeiw> {
  @override
  void initState() {
    super.initState();
    print("MAPView...");
    markers.outlets.clear();
    addmarker();
    addallpolylines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Text(
          'Journey Plan Map Veiw',
          style: TextStyle(color: orange),
        ),
      ),
      // drawer: Drawer(
      //   child: Menu(),
      // ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: pink,
          ),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 13.5,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            markers: Set<Marker>.of(markers.outlets),
            polylines: polyline.route,
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  polyline.route.clear();
                });
                optimisedlat = lat;
                optimisedlong = long;
                print(gettodayjp.distanceinmeters);
                List<double> nearestoutlet = gettodayjp.sortdistnce;
                nearestoutlet.sort();
                print(gettodayjp.sortdistnce);
                print(nearestoutlet);
                for (int i = 0; i < nearestoutlet.length; i++) {
                  var points = await DirectionsRepository().getDirections(
                    origin: LatLng(optimisedlat, optimisedlong),
                    destination: LatLng(
                        double.parse(gettodayjp.outletlat[gettodayjp
                            .distanceinmeters
                            .indexOf(nearestoutlet[i])]),
                        double.parse(gettodayjp.outletlong[gettodayjp
                            .distanceinmeters
                            .indexOf(nearestoutlet[i])])),
                  );
                  optimisedlat = double.parse(gettodayjp.outletlat[
                      gettodayjp.distanceinmeters.indexOf(nearestoutlet[i])]);
                  optimisedlong = double.parse(gettodayjp.outletlong[
                      gettodayjp.distanceinmeters.indexOf(nearestoutlet[i])]);
                  setState(() {
                    polyline.route.add(Polyline(
                      polylineId: PolylineId('optimisedroutes$i'),
                      visible: true,
                      points: points.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                      color: orange,
                      width: 2,
                    ));
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  "Optimise",
                  style: TextStyle(color: pink),
                ),
              ),
            ),
          ),
        ),
        nearestoutletindex != null
            ? SafeArea(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    '[${gettodayjp.storecodes[nearestoutletindex]}] ${gettodayjp.storenames[nearestoutletindex]}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  gettodayjp.isscheduled[nearestoutletindex] ==
                                          0
                                      ? Text(
                                          '(unscheduled)',
                                          style: TextStyle(
                                              fontSize: 13.0, color: orange),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                    '${gettodayjp.outletarea[nearestoutletindex]}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '${gettodayjp.outletcity[nearestoutletindex]}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '${gettodayjp.outletcountry[nearestoutletindex]}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                              ],
                            ),
                            Spacer(),
                            Table(
                              children: [
                                TableRow(children: [
                                  Text('Contact Number :',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      )),
                                  Text(
                                      '${gettodayjp.contactnumbers[nearestoutletindex]}',
                                      style: TextStyle(color: orange)),
                                ]),
                                TableRow(children: [
                                  Text('Distance :',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      )),
                                  Row(
                                    children: [
                                      Text(
                                          '${gettodayjp.distanceinmeters[nearestoutletindex].toStringAsFixed(2)}',
                                          style: TextStyle(color: orange)),
                                      Text("KM",
                                          style: TextStyle(color: orange))
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )))
            : SizedBox()
      ]),
    );
  }

  addmarker() {
    for (int u = 0; u < gettodayjp.outletlat.length; u++) {
      markers.outlets.add(Marker(
        markerId: MarkerId("Markers$u"),
        position: LatLng(double.parse(gettodayjp.outletlat[u]),
            double.parse(gettodayjp.outletlong[u])),
        //infoWindow: InfoWindow(title: gettodayjp.storenames[u],
        //  snippet: 'Distance: ${gettodayjp.distanceinmeters[u].toStringAsFixed(2)} KM'),
        onTap: () async {
          if (gettodayjp.distanceinmeters.length > 0) {
            nearestoutletindex = u;
            setState(() {
              polyline.route.clear();
            });
            print('${gettodayjp.outletlat[u]},${gettodayjp.outletlong[u]}');
            var points = await DirectionsRepository().getDirections(
              origin: LatLng(lat, long),
              destination: LatLng(double.parse(gettodayjp.outletlat[u]),
                  double.parse(gettodayjp.outletlong[u])),
            );
            polyline.route = {};
            setState(() {
              polyline.route.add(Polyline(
                polylineId: PolylineId('routes'),
                visible: true,
                points: points.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
                color: orange,
                width: 2,
              ));
            });
          }
        },
      ));
    }
  }

  addallpolylines() async {
    if (gettodayjp.distanceinmeters.length > 0) {
      polyline.route = {};
      for (int u = 0; u < gettodayjp.outletlat.length; u++) {
        var points = await DirectionsRepository().getDirections(
          origin: LatLng(lat, long),
          destination: LatLng(double.parse(gettodayjp.outletlat[u]),
              double.parse(gettodayjp.outletlong[u])),
        );
        setState(() {
          polyline.route.add(Polyline(
            polylineId: PolylineId('routes$u'),
            visible: true,
            points: points.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
            color: orange,
            width: 2,
          ));
        });
      }
    }
  }
}
