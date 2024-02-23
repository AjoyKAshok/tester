import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/api_service.dart';
// import '../MenuContent.dart';
// import '../checkin.dart';
import 'package:merchandising/model/OutLet_BarChart.dart';
import 'package:merchandising/utils/background.dart';

import '../../../ConstantMethods.dart';
// import '../../../api/api_service2.dart';
import 'NewJourneyPlan.dart';
import 'newCheckIn.dart';

// ignore: must_be_immutable
class NewOutLet extends StatefulWidget {
  double currentdist;

  @override
  _NewOutLetState createState() => _NewOutLetState();
}

class checkedoutlet {
  static bool checkoutlet = false;
}

class _NewOutLetState extends State<NewOutLet> {
  List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId("outletpoint"),
        position: LatLng(
          double.tryParse(chekinoutlet.checkinlat),
          double.tryParse(chekinoutlet.checkinlong),
        ))
  ];
  double distance = chekinoutlet.currentdistance / 1000;

  bool isApiCallProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadValues();
    print("oiutlet...${chekinoutlet.currentdistance}...$distance");
  }

  loadValues() async {
    
    setState(() {
      isApiCallProcess = true;
    });

    setState(() {
      isApiCallProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      opacity: 0.3,
      inAsyncCall: isApiCallProcess,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            // iconTheme: IconThemeData(color: orange),
            leading: IconButton(
              onPressed: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             DashBoard()));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NewJourneyPlanPage()));
              },
              icon: const Icon(Icons.arrow_back),
              color: Color(0XFF909090),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Outlet Details',
                      style: TextStyle(color: Color(0XFF909090)),
                    ),
                    EmpInfo()
                  ],
                ),
              ],
            ),
          ),
          // drawer: Drawer(
          //   child: Menu(),
          // ),
          body: ValueListenableBuilder<bool>(
              valueListenable: onlinemode,
              builder: (context, value, child) {
                return OfflineNotification(
                  body: Stack(
                    children: [
                      BackGround(),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: onlinemode.value ? 0 : 25,
                            ),
                            OutLetContainer(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          '[${chekinoutlet.checkinoutletid}]',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${chekinoutlet.checkinoutletname}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      chekinoutlet.checkinaddress ?? "",
                                      style: TextStyle(
                                        color: Color(0XFF909090),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            chekinoutlet.checkinarea ?? "",
                                            style: TextStyle(
                                              color: Color(0XFF909090),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            chekinoutlet.checkincity ?? "",
                                            style: TextStyle(
                                              color: Color(0XFF909090),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            chekinoutlet.checkinstate ?? "",
                                            style: TextStyle(
                                              color: Color(0XFF909090),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 1.0),
                                          child: Text(
                                            chekinoutlet.checkincountry ?? "",
                                            style: TextStyle(
                                              color: Color(0XFF909090),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 15,
                                        ),
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            color: Color(0XFFE84201),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 15,
                                        ),
                                        child: Text(
                                          '${chekinoutlet.contactnumber.toString()}',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Color(0XFF909090),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          top: 15,
                                        ),
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            color: Color(0XFFE84201),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Icon(
                                            Icons.location_pin,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 15,
                                        ),
                                        child: Text(
                                          '${(distance).toStringAsFixed(2).toString()}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0XFF909090),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 231,
                                    // MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: onlinemode.value
                                          ? GoogleMap(
                                              zoomControlsEnabled: false,
                                              zoomGesturesEnabled: true,
                                              myLocationButtonEnabled: false,
                                              markers: Set<Marker>.of(_markers),
                                              initialCameraPosition:
                                                  CameraPosition(
                                                      target: LatLng(
                                                          double.tryParse(
                                                              chekinoutlet
                                                                  .checkinlat),
                                                          double.tryParse(
                                                              chekinoutlet
                                                                  .checkinlong)),
                                                      zoom: 15),
                                            )
                                          : Center(
                                              child: Text(
                                                "Map is not available in offline mode",
                                                style: TextStyle(color: orange),
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 10.0),
                                width: MediaQuery.of(context).size.width / 1.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: BarChatData(),
                              ),
                            ),
                            SizedBox(
                              height: 42,
                            ),
                            NewCheckIn(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}

class OutLetContainer extends StatelessWidget {
  OutLetContainer({this.child, this.height});

  final child;
  final height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: height,
        width: MediaQuery.of(context).size.width / 1.05,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
