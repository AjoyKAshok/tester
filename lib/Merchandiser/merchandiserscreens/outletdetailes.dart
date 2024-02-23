import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Journeyplan.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/offlinedata/syncreferenceapi.dart';
import '../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'MenuContent.dart';
import 'checkin.dart';
import 'package:merchandising/model/OutLet_BarChart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:merchandising/model/Location_service.dart';
import 'package:merchandising/utils/background.dart';
import '../../api/api_service2.dart';

// ignore: must_be_immutable
class OutLet extends StatefulWidget {
  double currentdist;

  @override
  _OutLetState createState() => _OutLetState();
}

class checkedoutlet {
  static bool checkoutlet = false;
}

class _OutLetState extends State<OutLet> {
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
    // await NBLdetailsoffline();
    // await  PromoDetailsoffline();
    // await  CheckListDetailsoffline();
    // await VisibilityDetailsoffline();
    // await PlanoDetailsoffline();
    // await SOSDetailsoffline();
    // await availabilityDetailsoffline();

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
                                    JourneyPlanPage()));
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
                      'Outlet Details',
                      style: TextStyle(color: Color(0XFF909090)),
                    ),
                    EmpInfo()
                  ],
                ),
                // IconButton(
                //     icon: Icon(
                //       CupertinoIcons.refresh_circled_solid,
                //       color: orange,
                //       size: 30,
                //     ),
                //     onPressed: () async {
                //       createlog(
                //           "Refresh Button Tapped in Outlet Details", "true");
                //       setState(() {
                //         isApiCallProcess = true;
                //       });
                //       await getLocation();
                //       await outletwhencheckin();
                //       setState(() {
                //         print(chekinoutlet.currentdistance / 1000);
                //         distance = chekinoutlet.currentdistance / 1000;
                //         isApiCallProcess = false;
                //       });
                //       print("distance : $distance");
                //       setState(() {
                //         isApiCallProcess = false;
                //       });
                //     })
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
                                        padding: const EdgeInsets.only(left: 12.0),
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
                                          padding: const EdgeInsets.only(left: 12.0),
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
                                          padding: const EdgeInsets.only(left: 12.0),
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
                                          padding: const EdgeInsets.only(left: 12.0),
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
                                          padding: const EdgeInsets.only(left: 1.0),
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
                                            borderRadius: BorderRadius.circular(100),
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
                                            borderRadius: BorderRadius.circular(100),
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
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     SingleChildScrollView(
                                  //       scrollDirection: Axis.horizontal,
                                  //       child: Row(
                                  //         children: [
                                  //           Text(
                                  //             '[${chekinoutlet.checkinoutletid}]',
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //           SizedBox(
                                  //             width: 5,
                                  //           ),
                                  //           Text(
                                  //             '${chekinoutlet.checkinoutletname}'
                                  //            ,
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     Text(chekinoutlet.checkinaddress??""),
                                  //     SingleChildScrollView(
                                  //       scrollDirection: Axis.horizontal,
                                  //       child: Row(
                                  //         children: [

                                  //           Text(chekinoutlet.checkinarea??""),
                                  //           SizedBox(
                                  //             width: 5,
                                  //           ),

                                  //           Text(chekinoutlet.checkincity??""),
                                  //           SizedBox(
                                  //             width: 5,
                                  //           ),
                                  //           Text(chekinoutlet.checkinstate??""),
                                  //           SizedBox(
                                  //             width: 5,
                                  //           ),
                                  //           Text(chekinoutlet.checkincountry??""),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 5,
                                  //     ),
                                  //     Table(
                                  //       columnWidths: {
                                  //         0: FlexColumnWidth(2.5),
                                  //         1: FlexColumnWidth(1),
                                  //         2: FlexColumnWidth(2),
                                  //       },
                                  //       children: [
                                  //         TableRow(children: [
                                  //           Text(
                                  //             'Contact Number',
                                  //           ),
                                  //           Text(":"),
                                  //           SelectableText('${chekinoutlet.contactnumber
                                  //               .toString()}'
                                  //               ,
                                  //               style:
                                  //                   TextStyle(color: orange)),
                                  //         ]),
                                  //         // TableRow(children: [Text('Programme Name',Text(":"),Text(oprogramname, style: TextStyle(color: orange)),]),
                                  //         TableRow(children: [
                                  //           Text(
                                  //             'Distance',
                                  //           ),
                                  //           Text(":"),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                   (distance)
                                  //                       .toStringAsFixed(2)
                                  //                       .toString(),
                                  //                   style: TextStyle(
                                  //                       color: orange)),
                                  //               Text("KM",
                                  //                   style: TextStyle(
                                  //                       color: orange))
                                  //             ],
                                  //           ),
                                  //         ]),
                                  //         //TableRow(children: [Text('Coverage Productivity %',),Text(":"),Text(oproductivity, style: TextStyle(color: orange)),]),
                                  //         //TableRow(children: [Text('Last Visit',),Text(":"), Text(olastvisit, style: TextStyle(color: orange)),]),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
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
                            CheckIn(),
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
