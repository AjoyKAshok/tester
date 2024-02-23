import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:merchandising/model/Location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';

class markers {
  static Set<Marker> outlets = {};
}

String selectedmerch;

class polyline {
  static Set<Polyline> route = {};
}

List<LatLng> routepoints = [
  LatLng(lat, long),
  LatLng(double.parse(gettodayjp.outletlat[0]),
      double.parse(gettodayjp.outletlong[0]))
];

polylines() {
  for (int u = 0; u < gettodayjp.outletlat.length; u++) {
    Polyline(
      polylineId: PolylineId('routes'),
      visible: true,
      points: routepoints,
      color: Colors.blue,
    );
  }
}

class mapmarkersinfo {
  static var int = "id";
  static var name = 'storename';
  static var area = 'area';
  static var country = 'country';
  static var number = 'number';
  static var distance = 'distance';
  static var city = 'city';
}

String Selectedday;
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class MapVeiw extends StatefulWidget {
  @override
  _MapVeiwState createState() => _MapVeiwState();
}

class _MapVeiwState extends State<MapVeiw> {
  void initState() {
    super.initState();
    Selectedday = null;
  }

  static List DropDownItems = [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday"
  ].map((String val) {
    return new DropdownMenuItem<String>(
      value: val,
      child: new Text(val.capitalize()),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Column(
          children: [
            Text(
              'Journey Plan Map View',
              style: TextStyle(color: orange),
            ),
            EmpInfo()
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: Menu(),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: pink,
        ),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: lat != null
                    ? LatLng(lat, long)
                    : LatLng(25.06944764736989, 55.14185053415265),
                zoom: 8,
              ),
              myLocationEnabled: true,
              //myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              markers: Set<Marker>.of(markers.outlets),
              // polylines:polyline.route,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: DropdownButton(
                elevation: 0,
                dropdownColor: Colors.white,
                isExpanded: true,
                underline: Container(color: Colors.transparent),
                iconEnabledColor: orange,
                iconSize: 35.0,
                value: Selectedday,

                onChanged: (newVal) {
                  setState(() {
                    Selectedday = newVal;
                    markers.outlets = {};
                    if (Selectedday == "sunday") {
                      for (int u = 0;
                          u < getweeklyjp.sundaylatitudes.length;
                          u++) {
                        print(u);
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.sundaylatitudes[u]),
                                double.parse(getweeklyjp.sundaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.sundaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.sundayaddress[u]}')));
                      }
                    } else if (Selectedday == "monday") {
                      for (int u = 0;
                          u < getweeklyjp.mondaylatitudes.length;
                          u++) {
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.mondaylatitudes[u]),
                                double.parse(getweeklyjp.mondaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.mondaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.mondayaddress[u]}')));
                      }
                    } else if (Selectedday == "tuesday") {
                      for (int u = 0;
                          u < getweeklyjp.tuesdaylatitudes.length;
                          u++) {
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.tuesdaylatitudes[u]),
                                double.parse(getweeklyjp.tuesdaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.tuesdaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.tuesdayaddress[u]}')));
                      }
                    } else if (Selectedday == "wednesday") {
                      for (int u = 0;
                          u < getweeklyjp.wednesdaylatitudes.length;
                          u++) {
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.wednesdaylatitudes[u]),
                                double.parse(
                                    getweeklyjp.wednesdaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.wednesdaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.wednesdayaddress[u]}')));
                      }
                    } else if (Selectedday == "thursday") {
                      for (int u = 0;
                          u < getweeklyjp.thrusdaylatitudes.length;
                          u++) {
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.thrusdaylatitudes[u]),
                                double.parse(
                                    getweeklyjp.thrusdaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.thrusdaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.thrusdayaddress[u]}')));
                      }
                    } else if (Selectedday == "friday") {
                      for (int u = 0;
                          u < getweeklyjp.fridaylatitudes.length;
                          u++) {
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.fridaylatitudes[u]),
                                double.parse(getweeklyjp.fridaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.fridaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.fridayaddress[u]}')));
                      }
                    } else {
                      for (int u = 0;
                          u < getweeklyjp.saturdaylatitudes.length;
                          u++) {
                        markers.outlets.add(Marker(
                            markerId: MarkerId("Markers$u"),
                            position: LatLng(
                                double.parse(getweeklyjp.saturdaylatitudes[u]),
                                double.parse(
                                    getweeklyjp.saturdaylongitudes[u])),
                            infoWindow: InfoWindow(
                                title: getweeklyjp.saturdaystorenames[u],
                                snippet:
                                    'address :${getweeklyjp.saturdayaddress[u]}')));
                      }
                    }
                    print(markers.outlets.length);
                  });
                },
                items: DropDownItems,
                hint: Text(
                  "Select Day",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Week journey plan for $selectedmerch",
                      style: TextStyle(color: orange, fontSize: 12),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
