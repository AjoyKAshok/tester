import 'package:flutter/material.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/utils/background.dart';
import '../../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';
import 'package:merchandising/api/FMapi/timesheetdelete.dart';
import 'package:merchandising/Fieldmanager/addoutlets.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Fieldmanager/fmcustomeractivites.dart';
import 'package:merchandising/api/customer_activites_api/Competitioncheckapi.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/competition_details.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/Fieldmanager/addjp.dart';
import 'package:merchandising/clients/reports.dart';
import 'package:merchandising/api/clientapi/stockexpirydetailes.dart';
import 'package:merchandising/api/clientapi/clientpromodetailes.dart';

class WeeklyJourneyListBuilder extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<WeeklyJourneyListBuilder> {
  bool isApiCallProcess = false;
  bool sundaytapped = false;
  bool mondaytapped = false;
  bool tuesdaytapped = false;
  bool wednesdaytapped = false;
  bool thursdaytapped = false;
  bool fridaytapped = false;
  bool saturdaytapped = false;
  bool isexpanded = false;
  // var dayAddress;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Stack(
      children: [
        BackGround(),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.00),
                  // color: containerscolor,
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 00,
                          // top: 5,
                          right: 00,
                        ),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              dayTile1(
                                'Sunday',
                                Icons.wb_sunny_outlined,
                                0XFFF76F8D,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                              dayTile1(
                                'Monday',
                                Icons.wb_sunny_outlined,
                                0XFF1EC2C1,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                              dayTile1(
                                'Tuesday',
                                Icons.wb_sunny_outlined,
                                0XFF5589EA,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                              dayTile1(
                                'Wednesday',
                                Icons.wb_sunny_outlined,
                                0XFFF4B947,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                              dayTile1(
                                'Thursday',
                                Icons.wb_sunny_outlined,
                                0XFFF76F8D,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                              dayTile1(
                                'Friday',
                                Icons.wb_sunny_outlined,
                                0XFF1EC2C1,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                              dayTile1(
                                'Saturday',
                                Icons.wb_sunny_outlined,
                                0XFF5589EA,
                                // Icons.add,
                                0XFFE84201,
                                isexpanded,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                      //       child: Container(
                      //         color: Colors.white,
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               "Sunday",
                      //               style: TextStyle(fontSize: 16),
                      //             ),
                      //             IconButton(
                      //                 icon: Icon(
                      //                   sundaytapped == true
                      //                       ? Icons.remove
                      //                       : Icons.add,
                      //                   color: orange,
                      //                   size: 29,
                      //                 ),
                      //                 onPressed: () {
                      //                   print(getweeklyjp.sundaystorenames);
                      //                   setState(() {
                      //                     sundaytapped == true
                      //                         ? sundaytapped = false
                      //                         : sundaytapped = true;
                      //                   });
                      //                 }),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     sundaytapped == true
                      //         ? ListView.builder(
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount: getweeklyjp.sundayaddress.length,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return Container(
                      //                 margin:
                      //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      //                 padding: EdgeInsets.all(10.0),
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.white,
                      //                     borderRadius: BorderRadius.all(
                      //                         Radius.circular(10))),
                      //                 height: 80,
                      //                 width: double.infinity,
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     SingleChildScrollView(
                      //                       scrollDirection: Axis.horizontal,
                      //                       child: Row(
                      //                         children: [
                      //                           Text(
                      //                             '[${getweeklyjp.sundaystorecodes[index]}]',
                      //                             style: TextStyle(
                      //                                 fontSize: 15.0,
                      //                                 fontWeight: FontWeight.bold),
                      //                           ),
                      //                           SizedBox(
                      //                             width: 5,
                      //                           ),
                      //                           Text(
                      //                             '${getweeklyjp.sundaystorenames[index]}',
                      //                             style: TextStyle(
                      //                                 fontSize: 15.0,
                      //                                 fontWeight: FontWeight.bold),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                     SizedBox(height: 5),
                      //                     Text(
                      //                         '${getweeklyjp.sundayaddress[index]}',
                      //                         style: TextStyle(
                      //                           fontSize: 15.0,
                      //                         )),
                      //                     Spacer(),
                      //                     Table(
                      //                       children: [
                      //                         TableRow(children: [
                      //                           Text('Contact Number :',
                      //                               style: TextStyle(
                      //                                 fontSize: 13.0,
                      //                               )),
                      //                           Text(
                      //                               '${getweeklyjp.sundaycontactnumbers[index]}',
                      //                               style:
                      //                                   TextStyle(color: orange)),
                      //                         ]),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             })
                      //         : SizedBox()
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Monday",
                  //               style: TextStyle(fontSize: 16),
                  //             ),
                  //             IconButton(
                  //                 icon: Icon(
                  //                   mondaytapped == true
                  //                       ? Icons.remove
                  //                       : Icons.add,
                  //                   color: orange,
                  //                   size: 29,
                  //                 ),
                  //                 onPressed: () {
                  //                   print(getweeklyjp.mondaystorenames);
                  //                   setState(() {
                  //                     mondaytapped == true
                  //                         ? mondaytapped = false
                  //                         : mondaytapped = true;
                  //                   });
                  //                 }),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     mondaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.mondayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin:
                  //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  //                 padding: EdgeInsets.all(10.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10))),
                  //                 height: 80,
                  //                 width: double.infinity,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SingleChildScrollView(
                  //                       scrollDirection: Axis.horizontal,
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             '[${getweeklyjp.mondaystorecodes[index]}]',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '${getweeklyjp.mondaystorenames[index]}',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     Text(
                  //                         '${getweeklyjp.mondayaddress[index]}',
                  //                         style: TextStyle(
                  //                           fontSize: 15.0,
                  //                         )),
                  //                     Spacer(),
                  //                     Table(
                  //                       children: [
                  //                         TableRow(children: [
                  //                           Text('Contact Number :',
                  //                               style: TextStyle(
                  //                                 fontSize: 13.0,
                  //                               )),
                  //                           Text(
                  //                               '${getweeklyjp.mondaycontactnumbers[index]}',
                  //                               style:
                  //                                   TextStyle(color: orange)),
                  //                         ]),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Tuesday",
                  //               style: TextStyle(fontSize: 16),
                  //             ),
                  //             IconButton(
                  //                 icon: Icon(
                  //                   tuesdaytapped == true
                  //                       ? Icons.remove
                  //                       : Icons.add,
                  //                   color: orange,
                  //                   size: 29,
                  //                 ),
                  //                 onPressed: () {
                  //                   print(getweeklyjp.tuesdaystorenames);
                  //                   setState(() {
                  //                     tuesdaytapped == true
                  //                         ? tuesdaytapped = false
                  //                         : tuesdaytapped = true;
                  //                   });
                  //                 }),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     tuesdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.tuesdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin:
                  //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  //                 padding: EdgeInsets.all(10.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10))),
                  //                 height: 80,
                  //                 width: double.infinity,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SingleChildScrollView(
                  //                       scrollDirection: Axis.horizontal,
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             '[${getweeklyjp.tuesdaystorecodes[index]}]',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '${getweeklyjp.tuesdaystorenames[index]}',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     Text(
                  //                         '${getweeklyjp.tuesdayaddress[index]}',
                  //                         style: TextStyle(
                  //                           fontSize: 15.0,
                  //                         )),
                  //                     Spacer(),
                  //                     Table(
                  //                       children: [
                  //                         TableRow(children: [
                  //                           Text('Contact Number :',
                  //                               style: TextStyle(
                  //                                 fontSize: 13.0,
                  //                               )),
                  //                           Text(
                  //                               '${getweeklyjp.tuesdaycontactnumbers[index]}',
                  //                               style:
                  //                                   TextStyle(color: orange)),
                  //                         ]),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Wednesday",
                  //               style: TextStyle(fontSize: 16),
                  //             ),
                  //             IconButton(
                  //                 icon: Icon(
                  //                   wednesdaytapped == true
                  //                       ? Icons.remove
                  //                       : Icons.add,
                  //                   color: orange,
                  //                   size: 29,
                  //                 ),
                  //                 onPressed: () {
                  //                   print(getweeklyjp.wednesdaystorenames);
                  //                   setState(() {
                  //                     wednesdaytapped == true
                  //                         ? wednesdaytapped = false
                  //                         : wednesdaytapped = true;
                  //                   });
                  //                 }),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     wednesdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.wednesdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin:
                  //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  //                 padding: EdgeInsets.all(10.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10))),
                  //                 height: 80,
                  //                 width: double.infinity,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SingleChildScrollView(
                  //                       scrollDirection: Axis.horizontal,
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             '[${getweeklyjp.wednesdaystorecodes[index]}]',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '${getweeklyjp.wednesdaystorenames[index]}',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     Text(
                  //                         '${getweeklyjp.wednesdayaddress[index]}',
                  //                         style: TextStyle(
                  //                           fontSize: 15.0,
                  //                         )),
                  //                     Spacer(),
                  //                     Table(
                  //                       children: [
                  //                         TableRow(children: [
                  //                           Text('Contact Number :',
                  //                               style: TextStyle(
                  //                                 fontSize: 13.0,
                  //                               )),
                  //                           Text(
                  //                               '${getweeklyjp.wednesdaycontactnumbers[index]}',
                  //                               style:
                  //                                   TextStyle(color: orange)),
                  //                         ]),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Thursday",
                  //               style: TextStyle(fontSize: 16),
                  //             ),
                  //             IconButton(
                  //                 icon: Icon(
                  //                   thursdaytapped == true
                  //                       ? Icons.remove
                  //                       : Icons.add,
                  //                   color: orange,
                  //                   size: 29,
                  //                 ),
                  //                 onPressed: () {
                  //                   print(getweeklyjp.thrusdaystorenames);
                  //                   setState(() {
                  //                     thursdaytapped == true
                  //                         ? thursdaytapped = false
                  //                         : thursdaytapped = true;
                  //                   });
                  //                 }),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     thursdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.thrusdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin:
                  //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  //                 padding: EdgeInsets.all(10.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10))),
                  //                 height: 80,
                  //                 width: double.infinity,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SingleChildScrollView(
                  //                       scrollDirection: Axis.horizontal,
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             '[${getweeklyjp.thrusdaystorecodes[index]}]',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '${getweeklyjp.thrusdaystorenames[index]}',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     Text(
                  //                         '${getweeklyjp.thrusdayaddress[index]}',
                  //                         style: TextStyle(
                  //                           fontSize: 15.0,
                  //                         )),
                  //                     Spacer(),
                  //                     Table(
                  //                       children: [
                  //                         TableRow(children: [
                  //                           Text('Contact Number :',
                  //                               style: TextStyle(
                  //                                 fontSize: 13.0,
                  //                               )),
                  //                           Text(
                  //                               '${getweeklyjp.thrusdaycontactnumbers[index]}',
                  //                               style:
                  //                                   TextStyle(color: orange)),
                  //                         ]),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Friday",
                  //               style: TextStyle(fontSize: 16),
                  //             ),
                  //             IconButton(
                  //                 icon: Icon(
                  //                   fridaytapped == true
                  //                       ? Icons.remove
                  //                       : Icons.add,
                  //                   color: orange,
                  //                   size: 29,
                  //                 ),
                  //                 onPressed: () {
                  //                   print(getweeklyjp.fridaystorenames);
                  //                   setState(() {
                  //                     fridaytapped == true
                  //                         ? fridaytapped = false
                  //                         : fridaytapped = true;
                  //                   });
                  //                 }),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     fridaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.fridayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin:
                  //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  //                 padding: EdgeInsets.all(10.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10))),
                  //                 height: 80,
                  //                 width: double.infinity,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SingleChildScrollView(
                  //                       scrollDirection: Axis.horizontal,
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             '[${getweeklyjp.fridaystorecodes[index]}]',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '${getweeklyjp.fridaystorenames[index]}',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     Text(
                  //                         '${getweeklyjp.fridayaddress[index]}',
                  //                         style: TextStyle(
                  //                           fontSize: 15.0,
                  //                         )),
                  //                     Spacer(),
                  //                     Table(
                  //                       children: [
                  //                         TableRow(children: [
                  //                           Text('Contact Number :',
                  //                               style: TextStyle(
                  //                                 fontSize: 13.0,
                  //                               )),
                  //                           Text(
                  //                               '${getweeklyjp.fridaycontactnumbers[index]}',
                  //                               style:
                  //                                   TextStyle(color: orange)),
                  //                         ]),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20.0, right: 20),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Saturday",
                  //               style: TextStyle(fontSize: 16),
                  //             ),
                  //             IconButton(
                  //                 icon: Icon(
                  //                   saturdaytapped == true
                  //                       ? Icons.remove
                  //                       : Icons.add,
                  //                   color: orange,
                  //                   size: 29,
                  //                 ),
                  //                 onPressed: () {
                  //                   print(getweeklyjp.saturdaystorenames);
                  //                   setState(() {
                  //                     saturdaytapped == true
                  //                         ? saturdaytapped = false
                  //                         : saturdaytapped = true;
                  //                   });
                  //                 }),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     saturdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.tuesdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return Container(
                  //                 margin:
                  //                     EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  //                 padding: EdgeInsets.all(10.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10))),
                  //                 height: 80,
                  //                 width: double.infinity,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     SingleChildScrollView(
                  //                       scrollDirection: Axis.horizontal,
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             '[${getweeklyjp.saturdaystorecodes[index]}]',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '${getweeklyjp.saturdaystorenames[index]}',
                  //                             style: TextStyle(
                  //                                 fontSize: 15.0,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     Text(
                  //                         '${getweeklyjp.saturdayaddress[index]}',
                  //                         style: TextStyle(
                  //                           fontSize: 15.0,
                  //                         )),
                  //                     Spacer(),
                  //                     Table(
                  //                       children: [
                  //                         TableRow(children: [
                  //                           Text('Contact Number :',
                  //                               style: TextStyle(
                  //                                 fontSize: 13.0,
                  //                               )),
                  //                           Text(
                  //                               '${getweeklyjp.saturdaycontactnumbers[index]}',
                  //                               style:
                  //                                   TextStyle(color: orange)),
                  //                         ]),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Divider(thickness: 2, color: Color(0XFF909090),),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         IconButton(
                  //             icon: Icon(
                  //               mondaytapped == true
                  //                   ? CupertinoIcons.arrowtriangle_down_fill
                  //                   : CupertinoIcons.arrowtriangle_right_fill,
                  //               color: orange,
                  //               size: 20,
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 mondaytapped == true
                  //                     ? mondaytapped = false
                  //                     : mondaytapped = true;
                  //               });
                  //             }),
                  //         Text(
                  //           "Monday",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //     mondaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.mondayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onLongPress: () {
                  //                   if (currentuser.roleid == 5) {
                  //                     showDialog(
                  //                         context: context,
                  //                         builder:
                  //                             (_) => StatefulBuilder(builder:
                  //                                     (context, setState) {
                  //                                   return ProgressHUD(
                  //                                       inAsyncCall:
                  //                                           isApiCallProcess,
                  //                                       opacity: 0.3,
                  //                                       child: AlertDialog(
                  //                                         backgroundColor:
                  //                                             alertboxcolor,
                  //                                         shape: RoundedRectangleBorder(
                  //                                             borderRadius: BorderRadius
                  //                                                 .all(Radius
                  //                                                     .circular(
                  //                                                         10.0))),
                  //                                         content: Builder(
                  //                                           builder: (context) {
                  //                                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  //                                             return Container(
                  //                                               child: SizedBox(
                  //                                                 child: Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   crossAxisAlignment:
                  //                                                       CrossAxisAlignment
                  //                                                           .start,
                  //                                                   children: [
                  //                                                     Text(
                  //                                                       "Alert",
                  //                                                       style: TextStyle(
                  //                                                           fontSize:
                  //                                                               16,
                  //                                                           fontWeight:
                  //                                                               FontWeight.bold),
                  //                                                     ),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           15.00,
                  //                                                     ),
                  //                                                     Text(
                  //                                                         "Are you sure do you want to Delete this TimeSheet?",
                  //                                                         style:
                  //                                                             TextStyle(fontSize: 14)),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           25.00,
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisAlignment:
                  //                                                           MainAxisAlignment.center,
                  //                                                       children: [
                  //                                                         GestureDetector(
                  //                                                           onTap:
                  //                                                               () async {
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = true;
                  //                                                             });
                  //                                                             timesheetiddel = getweeklyjp.mondayid[index];
                  //                                                             await deletetimesheet();
                  //                                                             //updateoutlet.outletedit = true;
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = false;
                  //                                                             });
                  //                                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                  //                                                           },
                  //                                                           child:
                  //                                                               Container(
                  //                                                             height: 40,
                  //                                                             width: 70,
                  //                                                             decoration: BoxDecoration(
                  //                                                               color: orange,
                  //                                                               borderRadius: BorderRadius.circular(5),
                  //                                                             ),
                  //                                                             margin: EdgeInsets.only(right: 10.00),
                  //                                                             child: Center(child: Text("yes")),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             );
                  //                                           },
                  //                                         ),
                  //                                       ));
                  //                                 }));
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.fromLTRB(
                  //                       10.0, 0, 10.0, 10.0),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   height: 80,
                  //                   width: double.infinity,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       SingleChildScrollView(
                  //                         scrollDirection: Axis.horizontal,
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               '[${getweeklyjp.mondaystorecodes[index]}]',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Text(
                  //                               '${getweeklyjp.mondaystorenames[index]}',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 5),
                  //                       Text(
                  //                           '${getweeklyjp.mondayaddress[index]}',
                  //                           style: TextStyle(
                  //                             fontSize: 15.0,
                  //                           )),
                  //                       Spacer(),
                  //                       Table(
                  //                         children: [
                  //                           TableRow(children: [
                  //                             Text('Contact Number :',
                  //                                 style: TextStyle(
                  //                                   fontSize: 13.0,
                  //                                 )),
                  //                             Text(
                  //                                 '${getweeklyjp.mondaycontactnumbers[index]}',
                  //                                 style:
                  //                                     TextStyle(color: orange)),
                  //                           ]),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         IconButton(
                  //             icon: Icon(
                  //               tuesdaytapped == true
                  //                   ? CupertinoIcons.arrowtriangle_down_fill
                  //                   : CupertinoIcons.arrowtriangle_right_fill,
                  //               color: orange,
                  //               size: 20,
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 tuesdaytapped == true
                  //                     ? tuesdaytapped = false
                  //                     : tuesdaytapped = true;
                  //               });
                  //             }),
                  //         Text(
                  //           "Tuesday",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //     tuesdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.tuesdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onLongPress: () {
                  //                   if (currentuser.roleid == 5) {
                  //                     showDialog(
                  //                         context: context,
                  //                         builder:
                  //                             (_) => StatefulBuilder(builder:
                  //                                     (context, setState) {
                  //                                   return ProgressHUD(
                  //                                       inAsyncCall:
                  //                                           isApiCallProcess,
                  //                                       opacity: 0.3,
                  //                                       child: AlertDialog(
                  //                                         backgroundColor:
                  //                                             alertboxcolor,
                  //                                         shape: RoundedRectangleBorder(
                  //                                             borderRadius: BorderRadius
                  //                                                 .all(Radius
                  //                                                     .circular(
                  //                                                         10.0))),
                  //                                         content: Builder(
                  //                                           builder: (context) {
                  //                                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  //                                             return Container(
                  //                                               child: SizedBox(
                  //                                                 child: Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   crossAxisAlignment:
                  //                                                       CrossAxisAlignment
                  //                                                           .start,
                  //                                                   children: [
                  //                                                     Text(
                  //                                                       "Alert",
                  //                                                       style: TextStyle(
                  //                                                           fontSize:
                  //                                                               16,
                  //                                                           fontWeight:
                  //                                                               FontWeight.bold),
                  //                                                     ),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           15.00,
                  //                                                     ),
                  //                                                     Text(
                  //                                                         "Are you sure do you want to Delete this TimeSheet?",
                  //                                                         style:
                  //                                                             TextStyle(fontSize: 14)),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           25.00,
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisAlignment:
                  //                                                           MainAxisAlignment.center,
                  //                                                       children: [
                  //                                                         GestureDetector(
                  //                                                           onTap:
                  //                                                               () async {
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = true;
                  //                                                             });
                  //                                                             timesheetiddel = getweeklyjp.tuesdayid[index];
                  //                                                             await deletetimesheet();
                  //                                                             //updateoutlet.outletedit = true;
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = false;
                  //                                                             });
                  //                                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                  //                                                           },
                  //                                                           child:
                  //                                                               Container(
                  //                                                             height: 40,
                  //                                                             width: 70,
                  //                                                             decoration: BoxDecoration(
                  //                                                               color: orange,
                  //                                                               borderRadius: BorderRadius.circular(5),
                  //                                                             ),
                  //                                                             margin: EdgeInsets.only(right: 10.00),
                  //                                                             child: Center(child: Text("yes")),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             );
                  //                                           },
                  //                                         ),
                  //                                       ));
                  //                                 }));
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.fromLTRB(
                  //                       10.0, 0, 10.0, 10.0),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   height: 80,
                  //                   width: double.infinity,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       SingleChildScrollView(
                  //                         scrollDirection: Axis.horizontal,
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               '[${getweeklyjp.tuesdaystorecodes[index]}]',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Text(
                  //                               '${getweeklyjp.tuesdaystorenames[index]}',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 5),
                  //                       Text(
                  //                           '${getweeklyjp.tuesdayaddress[index]}',
                  //                           style: TextStyle(
                  //                             fontSize: 15.0,
                  //                           )),
                  //                       Spacer(),
                  //                       Table(
                  //                         children: [
                  //                           TableRow(children: [
                  //                             Text('Contact Number :',
                  //                                 style: TextStyle(
                  //                                   fontSize: 13.0,
                  //                                 )),
                  //                             Text(
                  //                                 '${getweeklyjp.tuesdaycontactnumbers[index]}',
                  //                                 style:
                  //                                     TextStyle(color: orange)),
                  //                           ]),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         IconButton(
                  //             icon: Icon(
                  //               wednesdaytapped == true
                  //                   ? CupertinoIcons.arrowtriangle_down_fill
                  //                   : CupertinoIcons.arrowtriangle_right_fill,
                  //               color: orange,
                  //               size: 20,
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 wednesdaytapped == true
                  //                     ? wednesdaytapped = false
                  //                     : wednesdaytapped = true;
                  //               });
                  //             }),
                  //         Text(
                  //           "Wednesday",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //     wednesdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.wednesdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onLongPress: () {
                  //                   if (currentuser.roleid == 5) {
                  //                     showDialog(
                  //                         context: context,
                  //                         builder:
                  //                             (_) => StatefulBuilder(builder:
                  //                                     (context, setState) {
                  //                                   return ProgressHUD(
                  //                                       inAsyncCall:
                  //                                           isApiCallProcess,
                  //                                       opacity: 0.3,
                  //                                       child: AlertDialog(
                  //                                         backgroundColor:
                  //                                             alertboxcolor,
                  //                                         shape: RoundedRectangleBorder(
                  //                                             borderRadius: BorderRadius
                  //                                                 .all(Radius
                  //                                                     .circular(
                  //                                                         10.0))),
                  //                                         content: Builder(
                  //                                           builder: (context) {
                  //                                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  //                                             return Container(
                  //                                               child: SizedBox(
                  //                                                 child: Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   crossAxisAlignment:
                  //                                                       CrossAxisAlignment
                  //                                                           .start,
                  //                                                   children: [
                  //                                                     Text(
                  //                                                       "Alert",
                  //                                                       style: TextStyle(
                  //                                                           fontSize:
                  //                                                               16,
                  //                                                           fontWeight:
                  //                                                               FontWeight.bold),
                  //                                                     ),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           15.00,
                  //                                                     ),
                  //                                                     Text(
                  //                                                         "Are you sure do you want to Delete this TimeSheet?",
                  //                                                         style:
                  //                                                             TextStyle(fontSize: 14)),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           25.00,
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisAlignment:
                  //                                                           MainAxisAlignment.center,
                  //                                                       children: [
                  //                                                         GestureDetector(
                  //                                                           onTap:
                  //                                                               () async {
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = true;
                  //                                                             });
                  //                                                             timesheetiddel = getweeklyjp.wednesdayid[index];
                  //                                                             await deletetimesheet();
                  //                                                             //updateoutlet.outletedit = true;
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = false;
                  //                                                             });
                  //                                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                  //                                                           },
                  //                                                           child:
                  //                                                               Container(
                  //                                                             height: 40,
                  //                                                             width: 70,
                  //                                                             decoration: BoxDecoration(
                  //                                                               color: orange,
                  //                                                               borderRadius: BorderRadius.circular(5),
                  //                                                             ),
                  //                                                             margin: EdgeInsets.only(right: 10.00),
                  //                                                             child: Center(child: Text("yes")),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             );
                  //                                           },
                  //                                         ),
                  //                                       ));
                  //                                 }));
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.fromLTRB(
                  //                       10.0, 0, 10.0, 10.0),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   height: 80,
                  //                   width: double.infinity,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       SingleChildScrollView(
                  //                         scrollDirection: Axis.horizontal,
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               '[${getweeklyjp.wednesdaystorecodes[index]}]',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Text(
                  //                               '${getweeklyjp.wednesdaystorenames[index]}',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 5),
                  //                       Text(
                  //                           '${getweeklyjp.wednesdayaddress[index]}',
                  //                           style: TextStyle(
                  //                             fontSize: 15.0,
                  //                           )),
                  //                       Spacer(),
                  //                       Table(
                  //                         children: [
                  //                           TableRow(children: [
                  //                             Text('Contact Number :',
                  //                                 style: TextStyle(
                  //                                   fontSize: 13.0,
                  //                                 )),
                  //                             Text(
                  //                                 '${getweeklyjp.wednesdaycontactnumbers[index]}',
                  //                                 style:
                  //                                     TextStyle(color: orange)),
                  //                           ]),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         IconButton(
                  //             icon: Icon(
                  //               thursdaytapped == true
                  //                   ? CupertinoIcons.arrowtriangle_down_fill
                  //                   : CupertinoIcons.arrowtriangle_right_fill,
                  //               color: orange,
                  //               size: 20,
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 thursdaytapped == true
                  //                     ? thursdaytapped = false
                  //                     : thursdaytapped = true;
                  //               });
                  //             }),
                  //         Text(
                  //           "Thursday",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //     thursdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.thrusdayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onLongPress: () {
                  //                   if (currentuser.roleid == 5) {
                  //                     showDialog(
                  //                         context: context,
                  //                         builder:
                  //                             (_) => StatefulBuilder(builder:
                  //                                     (context, setState) {
                  //                                   return ProgressHUD(
                  //                                       inAsyncCall:
                  //                                           isApiCallProcess,
                  //                                       opacity: 0.3,
                  //                                       child: AlertDialog(
                  //                                         backgroundColor:
                  //                                             alertboxcolor,
                  //                                         shape: RoundedRectangleBorder(
                  //                                             borderRadius: BorderRadius
                  //                                                 .all(Radius
                  //                                                     .circular(
                  //                                                         10.0))),
                  //                                         content: Builder(
                  //                                           builder: (context) {
                  //                                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  //                                             return Container(
                  //                                               child: SizedBox(
                  //                                                 child: Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   crossAxisAlignment:
                  //                                                       CrossAxisAlignment
                  //                                                           .start,
                  //                                                   children: [
                  //                                                     Text(
                  //                                                       "Alert",
                  //                                                       style: TextStyle(
                  //                                                           fontSize:
                  //                                                               16,
                  //                                                           fontWeight:
                  //                                                               FontWeight.bold),
                  //                                                     ),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           15.00,
                  //                                                     ),
                  //                                                     Text(
                  //                                                         "Are you sure do you want to Delete this TimeSheet?",
                  //                                                         style:
                  //                                                             TextStyle(fontSize: 14)),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           25.00,
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisAlignment:
                  //                                                           MainAxisAlignment.center,
                  //                                                       children: [
                  //                                                         GestureDetector(
                  //                                                           onTap:
                  //                                                               () async {
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = true;
                  //                                                             });
                  //                                                             timesheetiddel = getweeklyjp.thrusdayid[index];
                  //                                                             await deletetimesheet();
                  //                                                             //updateoutlet.outletedit = true;
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = false;
                  //                                                             });
                  //                                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                  //                                                           },
                  //                                                           child:
                  //                                                               Container(
                  //                                                             height: 40,
                  //                                                             width: 70,
                  //                                                             decoration: BoxDecoration(
                  //                                                               color: orange,
                  //                                                               borderRadius: BorderRadius.circular(5),
                  //                                                             ),
                  //                                                             margin: EdgeInsets.only(right: 10.00),
                  //                                                             child: Center(child: Text("yes")),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             );
                  //                                           },
                  //                                         ),
                  //                                       ));
                  //                                 }));
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.fromLTRB(
                  //                       10.0, 0, 10.0, 10.0),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   height: 80,
                  //                   width: double.infinity,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       SingleChildScrollView(
                  //                         scrollDirection: Axis.horizontal,
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               '[${getweeklyjp.thrusdaystorecodes[index]}]',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Text(
                  //                               '${getweeklyjp.thrusdaystorenames[index]}',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 5),
                  //                       Text(
                  //                           '${getweeklyjp.thrusdayaddress[index]}',
                  //                           style: TextStyle(
                  //                             fontSize: 15.0,
                  //                           )),
                  //                       Spacer(),
                  //                       Table(
                  //                         children: [
                  //                           TableRow(children: [
                  //                             Text('Contact Number :',
                  //                                 style: TextStyle(
                  //                                   fontSize: 13.0,
                  //                                 )),
                  //                             Text(
                  //                                 '${getweeklyjp.thrusdaycontactnumbers[index]}',
                  //                                 style:
                  //                                     TextStyle(color: orange)),
                  //                           ]),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         IconButton(
                  //             icon: Icon(
                  //               fridaytapped == true
                  //                   ? CupertinoIcons.arrowtriangle_down_fill
                  //                   : CupertinoIcons.arrowtriangle_right_fill,
                  //               color: orange,
                  //               size: 20,
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 fridaytapped == true
                  //                     ? fridaytapped = false
                  //                     : fridaytapped = true;
                  //               });
                  //             }),
                  //         Text(
                  //           "Friday",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //     fridaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.fridayaddress.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onLongPress: () {
                  //                   if (currentuser.roleid == 5) {
                  //                     showDialog(
                  //                         context: context,
                  //                         builder:
                  //                             (_) => StatefulBuilder(builder:
                  //                                     (context, setState) {
                  //                                   return ProgressHUD(
                  //                                       inAsyncCall:
                  //                                           isApiCallProcess,
                  //                                       opacity: 0.3,
                  //                                       child: AlertDialog(
                  //                                         backgroundColor:
                  //                                             alertboxcolor,
                  //                                         shape: RoundedRectangleBorder(
                  //                                             borderRadius: BorderRadius
                  //                                                 .all(Radius
                  //                                                     .circular(
                  //                                                         10.0))),
                  //                                         content: Builder(
                  //                                           builder: (context) {
                  //                                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  //                                             return Container(
                  //                                               child: SizedBox(
                  //                                                 child: Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   crossAxisAlignment:
                  //                                                       CrossAxisAlignment
                  //                                                           .start,
                  //                                                   children: [
                  //                                                     Text(
                  //                                                       "Alert",
                  //                                                       style: TextStyle(
                  //                                                           fontSize:
                  //                                                               16,
                  //                                                           fontWeight:
                  //                                                               FontWeight.bold),
                  //                                                     ),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           15.00,
                  //                                                     ),
                  //                                                     Text(
                  //                                                         "Are you sure do you want to Delete this TimeSheet?",
                  //                                                         style:
                  //                                                             TextStyle(fontSize: 14)),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           25.00,
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisAlignment:
                  //                                                           MainAxisAlignment.center,
                  //                                                       children: [
                  //                                                         GestureDetector(
                  //                                                           onTap:
                  //                                                               () async {
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = true;
                  //                                                             });
                  //                                                             timesheetiddel = getweeklyjp.fridayid[index];
                  //                                                             await deletetimesheet();
                  //                                                             //updateoutlet.outletedit = true;
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = false;
                  //                                                             });
                  //                                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                  //                                                           },
                  //                                                           child:
                  //                                                               Container(
                  //                                                             height: 40,
                  //                                                             width: 70,
                  //                                                             decoration: BoxDecoration(
                  //                                                               color: orange,
                  //                                                               borderRadius: BorderRadius.circular(5),
                  //                                                             ),
                  //                                                             margin: EdgeInsets.only(right: 10.00),
                  //                                                             child: Center(child: Text("yes")),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             );
                  //                                           },
                  //                                         ),
                  //                                       ));
                  //                                 }));
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.fromLTRB(
                  //                       10.0, 0, 10.0, 10.0),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   height: 80,
                  //                   width: double.infinity,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       SingleChildScrollView(
                  //                         scrollDirection: Axis.horizontal,
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               '[${getweeklyjp.fridaystorecodes[index]}]',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Text(
                  //                               '${getweeklyjp.fridaystorenames[index]}',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 5),
                  //                       Text(
                  //                           '${getweeklyjp.fridayaddress[index]}',
                  //                           style: TextStyle(
                  //                             fontSize: 15.0,
                  //                           )),
                  //                       Spacer(),
                  //                       Table(
                  //                         children: [
                  //                           TableRow(children: [
                  //                             Text('Contact Number :',
                  //                                 style: TextStyle(
                  //                                   fontSize: 13.0,
                  //                                 )),
                  //                             Text(
                  //                                 '${getweeklyjp.fridaycontactnumbers[index]}',
                  //                                 style:
                  //                                     TextStyle(color: orange)),
                  //                           ]),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(
                  //         left: 20.0,
                  //         right: 20,
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(Icons.wb_sunny_outlined,
                  //                   color: Color(0XFF909090)),
                  //               SizedBox(
                  //                 width: 6,
                  //               ),
                  //               Text(
                  //                 "Saturday",
                  //                 style: TextStyle(fontSize: 16),
                  //               ),
                  //             ],
                  //           ),
                  //           IconButton(
                  //               icon: Icon(
                  //                 saturdaytapped == true
                  //                     ? CupertinoIcons.arrowtriangle_down_fill
                  //                     : CupertinoIcons.arrowtriangle_right_fill,
                  //                 color: orange,
                  //                 size: 20,
                  //               ),
                  //               onPressed: () {
                  //                 setState(() {
                  //                   saturdaytapped == true
                  //                       ? saturdaytapped = false
                  //                       : saturdaytapped = true;
                  //                 });
                  //               }),
                  //         ],
                  //       ),
                  //     ),
                  //     saturdaytapped == true
                  //         ? ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: getweeklyjp.saturdaystorenames.length,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return GestureDetector(
                  //                 onLongPress: () {
                  //                   if (currentuser.roleid == 5) {
                  //                     showDialog(
                  //                         context: context,
                  //                         builder:
                  //                             (_) => StatefulBuilder(builder:
                  //                                     (context, setState) {
                  //                                   return ProgressHUD(
                  //                                       inAsyncCall:
                  //                                           isApiCallProcess,
                  //                                       opacity: 0.3,
                  //                                       child: AlertDialog(
                  //                                         backgroundColor:
                  //                                             alertboxcolor,
                  //                                         shape: RoundedRectangleBorder(
                  //                                             borderRadius: BorderRadius
                  //                                                 .all(Radius
                  //                                                     .circular(
                  //                                                         10.0))),
                  //                                         content: Builder(
                  //                                           builder: (context) {
                  //                                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  //                                             return Container(
                  //                                               child: SizedBox(
                  //                                                 child: Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   crossAxisAlignment:
                  //                                                       CrossAxisAlignment
                  //                                                           .start,
                  //                                                   children: [
                  //                                                     Text(
                  //                                                       "Alert",
                  //                                                       style: TextStyle(
                  //                                                           fontSize:
                  //                                                               16,
                  //                                                           fontWeight:
                  //                                                               FontWeight.bold),
                  //                                                     ),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           15.00,
                  //                                                     ),
                  //                                                     Text(
                  //                                                         "Are you sure do you want to Delete this TimeSheet?",
                  //                                                         style:
                  //                                                             TextStyle(fontSize: 14)),
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           25.00,
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisAlignment:
                  //                                                           MainAxisAlignment.center,
                  //                                                       children: [
                  //                                                         GestureDetector(
                  //                                                           onTap:
                  //                                                               () async {
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = true;
                  //                                                             });
                  //                                                             timesheetiddel = getweeklyjp.saturdayid[index];
                  //                                                             await deletetimesheet();
                  //                                                             //updateoutlet.outletedit = true;
                  //                                                             setState(() {
                  //                                                               isApiCallProcess = false;
                  //                                                             });
                  //                                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                  //                                                           },
                  //                                                           child:
                  //                                                               Container(
                  //                                                             height: 40,
                  //                                                             width: 70,
                  //                                                             decoration: BoxDecoration(
                  //                                                               color: orange,
                  //                                                               borderRadius: BorderRadius.circular(5),
                  //                                                             ),
                  //                                                             margin: EdgeInsets.only(right: 10.00),
                  //                                                             child: Center(child: Text("yes")),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             );
                  //                                           },
                  //                                         ),
                  //                                       ));
                  //                                 }));
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.fromLTRB(
                  //                       10.0, 0, 10.0, 10.0),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   height: 80,
                  //                   width: double.infinity,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       SingleChildScrollView(
                  //                         scrollDirection: Axis.horizontal,
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               '[${getweeklyjp.saturdaystorecodes[index]}]',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Text(
                  //                               '${getweeklyjp.saturdaystorenames[index]}',
                  //                               style: TextStyle(
                  //                                   fontSize: 15.0,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 5),
                  //                       Text(
                  //                           '${getweeklyjp.saturdayaddress[index]}',
                  //                           style: TextStyle(
                  //                             fontSize: 12.0,
                  //                             color: Color(0XFF909090),
                  //                           )),
                  //                       Spacer(),
                  //                       Row(
                  //                         children: [
                  //                           Padding(
                  //                             padding: EdgeInsets.only(
                  //                               left: 3,
                  //                               top: 3,
                  //                             ),
                  //                             child: Container(
                  //                               height: 12,
                  //                               width: 12,
                  //                               decoration: BoxDecoration(
                  //                                 color: Color(0XFFE84201),
                  //                               ),
                  //                               child: Icon(
                  //                                 Icons.phone,
                  //                                 color: Colors.white,
                  //                                 size: 10,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 12,
                  //                           ),
                  //                           Padding(
                  //                             padding: EdgeInsets.only(
                  //                               left: 3,
                  //                               top: 3,
                  //                             ),
                  //                             child: Text(
                  //                               '${getweeklyjp.saturdaycontactnumbers[index]}',
                  //                               style: TextStyle(
                  //                                 fontSize: 12.0,
                  //                                 color: Color(0XFF909090),
                  //                               ),
                  //                               textAlign: TextAlign.center,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),

                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             })
                  //         : SizedBox()
                  //   ],
                  // ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ExpansionTile dayTile1(
    String DayName,
    IconData icon,
    int colorCode,
    // IconData addIcon,
    int iconColorCode,
    bool isExpanded,
  ) {
    // var dayAddress;
    return ExpansionTile(
      title: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(colorCode),
              ),
              width: 3,
              height: 45,
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: const Color(0XFF909090),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              DayName,
              style: const TextStyle(
                color: Color(0XFF505050),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // ),
      ),
      iconColor: Color(iconColorCode),
      collapsedIconColor: Color(iconColorCode),
      onExpansionChanged: (bool expanded) {
        setState(() {
          isExpanded = expanded;

          print(isExpanded.toString());
          isExpanded == true
              ? DayName == 'Sunday'
                  ? setState(() {
                      print('Sunday Tapped');

                      sundaytapped == true
                      ? sundaytapped = false
                      : sundaytapped = true;
                    })
                  : DayName == 'Monday'
                      ? setState(() {
                          print('Monday Tapped');
                          mondaytapped == true
                          ? mondaytapped = false
                          : mondaytapped = true;
                        })
                      : DayName == 'Tuesday'
                          ? setState(() {
                              print('Tuesday Tapped');
                              tuesdaytapped == true
                              ? tuesdaytapped = false
                              : tuesdaytapped = true;
                            })
                          : DayName == 'Wednesday'
                              ? setState(() {
                                  print('Wednesday Tapped');
                                  wednesdaytapped == true
                                  ? wednesdaytapped = false
                                  : wednesdaytapped = true;
                                })
                              : DayName == 'Thursday'
                                  ? setState(() {
                                      print('Thursday Tapped');
                                      thursdaytapped == true
                                      ? thursdaytapped = false
                                      : thursdaytapped = true;
                                    })
                                  : DayName == 'Friday'
                                      ? setState(() {
                                          print('Friday Tapped');
                                          fridaytapped == true
                                          ? fridaytapped = false
                                          : fridaytapped = true;
                                        })
                                      : setState(() {
                                          print('Saturday Tapped');
                                          saturdaytapped == true
                                          ? saturdaytapped = false
                                          : saturdaytapped = true;
                                        })
              : setState(() {
                  sundaytapped = false;
                  mondaytapped = false;
                  tuesdaytapped = false;
                  wednesdaytapped = false;
                  thursdaytapped = false;
                  fridaytapped = false;
                  saturdaytapped = false;
                });
        });
      },
      children: [
        sundaytapped == true
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: getweeklyjp.sundayaddress.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onLongPress: () {
                      if (currentuser.roleid == 5) {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                StatefulBuilder(builder: (context, setState) {
                                  return ProgressHUD(
                                      inAsyncCall: isApiCallProcess,
                                      opacity: 0.3,
                                      child: AlertDialog(
                                        backgroundColor: alertboxcolor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        content: Builder(
                                          builder: (context) {
                                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                            return Container(
                                              child: SizedBox(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Alert",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 15.00,
                                                    ),
                                                    Text(
                                                        "Are you sure do you want to Delete this TimeSheet?",
                                                        style: TextStyle(
                                                            fontSize: 14)),
                                                    SizedBox(
                                                      height: 25.00,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              isApiCallProcess =
                                                                  true;
                                                            });
                                                            timesheetiddel =
                                                                getweeklyjp
                                                                        .sundayid[
                                                                    index];
                                                            await deletetimesheet();
                                                            //updateoutlet.outletedit = true;
                                                            setState(() {
                                                              isApiCallProcess =
                                                                  false;
                                                            });
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AddJourneyPlan()));
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: orange,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        10.00),
                                                            child: Center(
                                                                child: Text(
                                                                    "yes")),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ));
                                }));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  '[${getweeklyjp.sundaystorecodes[index]}]',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getweeklyjp.sundaystorenames[index]}',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('${getweeklyjp.sundayaddress[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          Spacer(),
                          Table(
                            children: [
                              TableRow(children: [
                                Text('Contact Number :',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                    )),
                                Text(
                                    '${getweeklyjp.sundaycontactnumbers[index]}',
                                    style: TextStyle(color: orange)),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : mondaytapped == true
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getweeklyjp.mondayaddress.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onLongPress: () {
                          if (currentuser.roleid == 5) {
                            showDialog(
                                context: context,
                                builder: (_) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return ProgressHUD(
                                          inAsyncCall: isApiCallProcess,
                                          opacity: 0.3,
                                          child: AlertDialog(
                                            backgroundColor: alertboxcolor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            content: Builder(
                                              builder: (context) {
                                                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                return Container(
                                                  child: SizedBox(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Alert",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 15.00,
                                                        ),
                                                        Text(
                                                            "Are you sure do you want to Delete this TimeSheet?",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        SizedBox(
                                                          height: 25.00,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                setState(() {
                                                                  isApiCallProcess =
                                                                      true;
                                                                });
                                                                timesheetiddel =
                                                                    getweeklyjp
                                                                            .mondayid[
                                                                        index];
                                                                await deletetimesheet();
                                                                //updateoutlet.outletedit = true;
                                                                setState(() {
                                                                  isApiCallProcess =
                                                                      false;
                                                                });
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                AddJourneyPlan()));
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                width: 70,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: orange,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10.00),
                                                                child: Center(
                                                                    child: Text(
                                                                        "yes")),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ));
                                    }));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 80,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      '[${getweeklyjp.mondaystorecodes[index]}]',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${getweeklyjp.mondaystorenames[index]}',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text('${getweeklyjp.mondayaddress[index]}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  )),
                              Spacer(),
                              Table(
                                children: [
                                  TableRow(children: [
                                    Text('Contact Number :',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                        )),
                                    Text(
                                        '${getweeklyjp.mondaycontactnumbers[index]}',
                                        style: TextStyle(color: orange)),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : tuesdaytapped == true
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getweeklyjp.tuesdayaddress.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onLongPress: () {
                              if (currentuser.roleid == 5) {
                                showDialog(
                                    context: context,
                                    builder:
                                        (_) => StatefulBuilder(
                                                builder: (context, setState) {
                                              return ProgressHUD(
                                                  inAsyncCall: isApiCallProcess,
                                                  opacity: 0.3,
                                                  child: AlertDialog(
                                                    backgroundColor:
                                                        alertboxcolor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    content: Builder(
                                                      builder: (context) {
                                                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                        return Container(
                                                          child: SizedBox(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Alert",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 15.00,
                                                                ),
                                                                Text(
                                                                    "Are you sure do you want to Delete this TimeSheet?",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14)),
                                                                SizedBox(
                                                                  height: 25.00,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              true;
                                                                        });
                                                                        timesheetiddel =
                                                                            getweeklyjp.tuesdayid[index];
                                                                        await deletetimesheet();
                                                                        //updateoutlet.outletedit = true;
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              false;
                                                                        });
                                                                        Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            70,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              orange,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                10.00),
                                                                        child: Center(
                                                                            child:
                                                                                Text("yes")),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ));
                                            }));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 80,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          '[${getweeklyjp.tuesdaystorecodes[index]}]',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${getweeklyjp.tuesdaystorenames[index]}',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('${getweeklyjp.tuesdayaddress[index]}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      )),
                                  Spacer(),
                                  Table(
                                    children: [
                                      TableRow(children: [
                                        Text('Contact Number :',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                            '${getweeklyjp.tuesdaycontactnumbers[index]}',
                                            style: TextStyle(color: orange)),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : wednesdaytapped == true
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getweeklyjp.wednesdayaddress.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onLongPress: () {
                              if (currentuser.roleid == 5) {
                                showDialog(
                                    context: context,
                                    builder:
                                        (_) => StatefulBuilder(
                                                builder: (context, setState) {
                                              return ProgressHUD(
                                                  inAsyncCall: isApiCallProcess,
                                                  opacity: 0.3,
                                                  child: AlertDialog(
                                                    backgroundColor:
                                                        alertboxcolor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    content: Builder(
                                                      builder: (context) {
                                                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                        return Container(
                                                          child: SizedBox(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Alert",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 15.00,
                                                                ),
                                                                Text(
                                                                    "Are you sure do you want to Delete this TimeSheet?",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14)),
                                                                SizedBox(
                                                                  height: 25.00,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              true;
                                                                        });
                                                                        timesheetiddel =
                                                                            getweeklyjp.wednesdayid[index];
                                                                        await deletetimesheet();
                                                                        //updateoutlet.outletedit = true;
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              false;
                                                                        });
                                                                        Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            70,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              orange,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                10.00),
                                                                        child: Center(
                                                                            child:
                                                                                Text("yes")),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ));
                                            }));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 80,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          '[${getweeklyjp.wednesdaystorecodes[index]}]',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${getweeklyjp.wednesdaystorenames[index]}',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('${getweeklyjp.wednesdayaddress[index]}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      )),
                                  Spacer(),
                                  Table(
                                    children: [
                                      TableRow(children: [
                                        Text('Contact Number :',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                            '${getweeklyjp.wednesdaycontactnumbers[index]}',
                                            style: TextStyle(color: orange)),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                        : thursdaytapped == true
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getweeklyjp.thrusdayaddress.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      if (currentuser.roleid == 5) {
                                        showDialog(
                                            context: context,
                                            builder:
                                                (_) => StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return ProgressHUD(
                                                          inAsyncCall:
                                                              isApiCallProcess,
                                                          opacity: 0.3,
                                                          child: AlertDialog(
                                                            backgroundColor:
                                                                alertboxcolor,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            content: Builder(
                                                              builder:
                                                                  (context) {
                                                                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                                return Container(
                                                                  child:
                                                                      SizedBox(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Alert",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15.00,
                                                                        ),
                                                                        Text(
                                                                            "Are you sure do you want to Delete this TimeSheet?",
                                                                            style:
                                                                                TextStyle(fontSize: 14)),
                                                                        SizedBox(
                                                                          height:
                                                                              25.00,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                setState(() {
                                                                                  isApiCallProcess = true;
                                                                                });
                                                                                timesheetiddel = getweeklyjp.thrusdayid[index];
                                                                                await deletetimesheet();
                                                                                //updateoutlet.outletedit = true;
                                                                                setState(() {
                                                                                  isApiCallProcess = false;
                                                                                });
                                                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                                                                              },
                                                                              child: Container(
                                                                                height: 40,
                                                                                width: 70,
                                                                                decoration: BoxDecoration(
                                                                                  color: orange,
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                margin: EdgeInsets.only(right: 10.00),
                                                                                child: Center(child: Text("yes")),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ));
                                                    }));
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 0, 10.0, 10.0),
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: 80,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Text(
                                                  '[${getweeklyjp.thrusdaystorecodes[index]}]',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${getweeklyjp.thrusdaystorenames[index]}',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              '${getweeklyjp.thrusdayaddress[index]}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              )),
                                          Spacer(),
                                          Table(
                                            children: [
                                              TableRow(children: [
                                                Text('Contact Number :',
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                    )),
                                                Text(
                                                    '${getweeklyjp.thrusdaycontactnumbers[index]}',
                                                    style: TextStyle(
                                                        color: orange)),
                                              ]),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : fridaytapped == true
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: getweeklyjp.fridayaddress.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          if (currentuser.roleid == 5) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (_) => StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return ProgressHUD(
                                                              inAsyncCall:
                                                                  isApiCallProcess,
                                                              opacity: 0.3,
                                                              child:
                                                                  AlertDialog(
                                                                backgroundColor:
                                                                    alertboxcolor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                content:
                                                                    Builder(
                                                                  builder:
                                                                      (context) {
                                                                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                                    return Container(
                                                                      child:
                                                                          SizedBox(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Alert",
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15.00,
                                                                            ),
                                                                            Text("Are you sure do you want to Delete this TimeSheet?",
                                                                                style: TextStyle(fontSize: 14)),
                                                                            SizedBox(
                                                                              height: 25.00,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () async {
                                                                                    setState(() {
                                                                                      isApiCallProcess = true;
                                                                                    });
                                                                                    timesheetiddel = getweeklyjp.fridayid[index];
                                                                                    await deletetimesheet();
                                                                                    //updateoutlet.outletedit = true;
                                                                                    setState(() {
                                                                                      isApiCallProcess = false;
                                                                                    });
                                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 40,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(
                                                                                      color: orange,
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),
                                                                                    margin: EdgeInsets.only(right: 10.00),
                                                                                    child: Center(child: Text("yes")),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ));
                                                        }));
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10.0, 0, 10.0, 10.0),
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          height: 80,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '[${getweeklyjp.fridaystorecodes[index]}]',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${getweeklyjp.fridaystorenames[index]}',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                  '${getweeklyjp.fridayaddress[index]}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  )),
                                              Spacer(),
                                              Table(
                                                children: [
                                                  TableRow(children: [
                                                    Text('Contact Number :',
                                                        style: TextStyle(
                                                          fontSize: 13.0,
                                                        )),
                                                    Text(
                                                        '${getweeklyjp.fridaycontactnumbers[index]}',
                                                        style: TextStyle(
                                                            color: orange)),
                                                  ]),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : saturdaytapped == true
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            getweeklyjp.saturdayaddress.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onLongPress: () {
                                              if (currentuser.roleid == 5) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        StatefulBuilder(builder:
                                                            (context,
                                                                setState) {
                                                          return ProgressHUD(
                                                              inAsyncCall:
                                                                  isApiCallProcess,
                                                              opacity: 0.3,
                                                              child:
                                                                  AlertDialog(
                                                                backgroundColor:
                                                                    alertboxcolor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                content:
                                                                    Builder(
                                                                  builder:
                                                                      (context) {
                                                                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                                    return Container(
                                                                      child:
                                                                          SizedBox(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Alert",
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15.00,
                                                                            ),
                                                                            Text("Are you sure do you want to Delete this TimeSheet?",
                                                                                style: TextStyle(fontSize: 14)),
                                                                            SizedBox(
                                                                              height: 25.00,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () async {
                                                                                    setState(() {
                                                                                      isApiCallProcess = true;
                                                                                    });
                                                                                    timesheetiddel = getweeklyjp.saturdayid[index];
                                                                                    await deletetimesheet();
                                                                                    //updateoutlet.outletedit = true;
                                                                                    setState(() {
                                                                                      isApiCallProcess = false;
                                                                                    });
                                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddJourneyPlan()));
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 40,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(
                                                                                      color: orange,
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),
                                                                                    margin: EdgeInsets.only(right: 10.00),
                                                                                    child: Center(child: Text("yes")),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ));
                                                        }));
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10.0, 0, 10.0, 10.0),
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              height: 80,
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '[${getweeklyjp.saturdaystorecodes[index]}]',
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${getweeklyjp.saturdaystorenames[index]}',
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                      '${getweeklyjp.saturdayaddress[index]}',
                                                      style: TextStyle(
                                                        fontSize: 13.0,
                                                        color:
                                                            Color(0XFF909090),
                                                      )),
                                                  Spacer(),
                                                  Table(
                                                    children: [
                                                      TableRow(children: [
                                                        Text('Contact Number :',
                                                            style: TextStyle(
                                                              fontSize: 13.0,
                                                            )),
                                                        Text(
                                                            '${getweeklyjp.saturdaycontactnumbers[index]}',
                                                            style: TextStyle(
                                                                color: orange)),
                                                      ]),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    : SizedBox()
      ],
    );
  }
}
