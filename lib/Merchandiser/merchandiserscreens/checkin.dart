import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchandising/api/FMapi/outlet%20brand%20mappingapi.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/model/database.dart';
import '../../api/api_service2.dart';
import 'outletdetailes.dart';
import 'package:merchandising/api/customer_activites_api/Competitioncheckapi.dart';
import 'package:merchandising/api/api_service.dart';
import 'Customers Activities.dart';
import 'package:merchandising/model/Location_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/competition_details.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/FMapi/nbl_detailsapi.dart';
import 'package:merchandising/api/myattendanceapi.dart';
import 'package:merchandising/api/clientapi/stockexpirydetailes.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enough_mail/smtp/smtp_exception.dart';
import 'package:enough_mail/smtp/smtp_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:merchandising/api/clientapi/stockexpirydetailes.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Journeyplan.dart';

class CheckIn extends StatefulWidget {
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        createlog("Check In tapped from outlet details", "true");
        print("distance");
        print(chekinoutlet.currentdistance);
        if (chekinoutlet.currentdistance > 400) {
          //FORCE CHECK IN DISABLED
         showDialog(
              context: context,
              builder: (_) => StatefulBuilder(builder: (context, setState) {
                    return ProgressHUD(
                        inAsyncCall: isApiCallProcess,
                        opacity: 0.3,
                        child: AlertDialog(
                          backgroundColor: alertboxcolor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          content: Builder(
                            builder: (context) {
                              // Get available height and width of the build area of this widget. Make a choice depending on the size.
                              return Container(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Alert",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "It seems that you are not at the customer location.\nDo you want to do Force CheckIn?",
                                          style: TextStyle(fontSize: 13.6)),
                                      SizedBox(
                                        height: 10.00,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          OutLet()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Color(0xffAEB7B5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10.00),
                                              child:
                                                  Center(child: Text("cancel")),
                                            ),
                                          ),
                                          ForceCheckin(),
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
                  /// THE BELOW PORTION OF CODE IS REQUIRED, DISABLED NOW JUST SO THAT IT WONT LOOK BAD WHEN FORCE CHECK IN IS ASKED FOR.
          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(
          //       top: Radius.circular(20),
          //     ),
          //   ),
          //   context: context,
          //   builder: (context) => BottomModalSheet(),
          // );

          // Fluttertoast.showToast(
          //     msg: "It seems that you are not at the customer location",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.orange[200],
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );
        } else {
          setState(() {
            isApiCallProcess = true;
          });
          SubmitCheckin();
          normalcheckin = true;
          forcecheck.reason = "normal checkin less than 300m";
          await addforeccheckin();
          ////testing
          //getTaskList();
          //getVisibility();
          //getPlanogram();
          //getPromotionDetails();
          // Addedstockdataformerch();
          //getNBLdetails();
          //getShareofshelf();
          // await getAvaiablitity();
          // COMMENTED OUT AS THE BELOW TWO FUNCTIONS ARE NOT USED WHILE CHECK IN.
          
          // await getaddedexpiryproducts();
          // await getmyattandance();
          await addattendence();
          /// COMMENTED OUT 18 FEB 2024
          // if (onlinemode.value) {
          //   await smtpExampleCheckinCheckout(
          //       'Check In details for empid ${DBrequestdata.receivedempid}');
          // }
          setState(() {
            isApiCallProcess = false;
          });
          normalcheckin = false;
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CustomerActivities();
          }), (Route<dynamic> route) => false);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .90,
        padding: EdgeInsets.all(15.0),
        // margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          // color: pink,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFF88200), Color(0xFFE43700)]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Check In",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class BottomModalSheet extends StatefulWidget {
  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  // bool isUniformChecked = false;
  // bool isChargerChecked = false;
  // bool isTransportationChecked = false;
  // bool isPOSMChecked = false;
  // bool isLocationChecked = false;
  // bool isAllChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .39,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 27,
                    top: 18,
                  ),
                  child: Text(
                    'Alert',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 23,
                    top: 20,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        print('Close Button Tapped');
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 15,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
              color: Color(0XFFC4C4C4),
            ),
            // SizedBox(
            //   height: 15,
            // ),
             Center(
               child: Container(
                  height: 75,
                  width: 90,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 85,
                    color: Color(0XFF909090),
                  ),
                ),
             ),
             SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         checkColor: Colors.white,
            //         activeColor: Colors.orange,
            //         value: isUniformChecked,
            //         onChanged: (value) {
            //           setState(() {
            //             isUniformChecked = value;
            //           });
            //         },
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('Uniform & Hygiene'),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         checkColor: Colors.white,
            //         activeColor: Colors.orange,
            //         value: isChargerChecked,
            //         onChanged: (value) {
            //           setState(() {
            //             isChargerChecked = value;
            //           });
            //         },
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('Hand held unit charge'),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         checkColor: Colors.white,
            //         activeColor: Colors.orange,
            //         value: isTransportationChecked,
            //         onChanged: (value) {
            //           setState(() {
            //             isTransportationChecked = value;
            //           });
            //         },
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('Transportation'),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         checkColor: Colors.white,
            //         activeColor: Colors.orange,
            //         value: isPOSMChecked,
            //         onChanged: (value) {
            //           setState(() {
            //             isPOSMChecked = value;
            //           });
            //         },
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('POSM'),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         checkColor: Colors.white,
            //         activeColor: Colors.orange,
            //         value: isLocationChecked,
            //         onChanged: (value) {
            //           setState(() {
            //             isLocationChecked = value;
            //           });
            //         },
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('Location'),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            Center(
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Text(
                    'It seems that you are not at the customer location. Please try after reaching the customer location!!!'),
              ),
            ),
            SizedBox(
              height: 27,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  // isAllChecked
                  //     ? print('All Checked')
                  //     : print('All parameters are not checked');
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    // if (isUniformChecked &&
                    //     isChargerChecked &&
                    //     isTransportationChecked &&
                    //     isPOSMChecked) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (BuildContext context) =>
                    //               JourneyPlanPage()));
                    //   // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => JourneyPlanPage()));
                    // }
                  },
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFF88200), Color(0xFFE43700)],
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ForceCheckin extends StatefulWidget {
  @override
  _ForceCheckinState createState() => _ForceCheckinState();
}

class _ForceCheckinState extends State<ForceCheckin> {
  bool isApiCallProcess = false;
  bool gpsnotworking = false;
  bool geolocation = false;
  bool others = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        createlog("yes from alert Tapped", "true");

        showDialog(
            context: context,
            builder: (_) => StatefulBuilder(builder: (context, setState) {
                  return ProgressHUD(
                    inAsyncCall: isApiCallProcess,
                    opacity: 0.1,
                    child: AlertDialog(
                      backgroundColor: alertboxcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      content: Builder(
                        builder: (context) {
                          // Get available height and width of the build area of this widget. Make a choice depending on the size.
                          return Container(
                            child: SizedBox(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Force Check-In",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            gpsnotworking = true;
                                            geolocation = false;
                                            others = false;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            ForcecheckinContent(
                                              child: gpsnotworking == true
                                                  ? Icon(
                                                      Icons.circle,
                                                      size: 15.0,
                                                      color: orange,
                                                    )
                                                  : null,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "GPS Not Working",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            gpsnotworking = false;
                                            geolocation = true;
                                            others = false;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            ForcecheckinContent(
                                              child: geolocation == true
                                                  ? Icon(
                                                      Icons.circle,
                                                      size: 15.0,
                                                      color: orange,
                                                    )
                                                  : null,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Geo Location was wrong",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            gpsnotworking = false;
                                            geolocation = false;
                                            others = true;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            ForcecheckinContent(
                                              child: others == true
                                                  ? Icon(
                                                      Icons.circle,
                                                      size: 15.0,
                                                      color: orange,
                                                    )
                                                  : null,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Others",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            createlog("GPS not working tapped",
                                                "true");
                                            if (gpsnotworking == true) {
                                              forcecheck.reason =
                                                  "GPS not working";
                                              setState(() {
                                                isApiCallProcess = true;
                                              });

                                              addforeccheckin();
                                              addattendence();
                                              //getTaskList();
                                              //getVisibility();
                                              //getPlanogram();
                                              //getPromotionDetails();
                                              // Addedstockdataformerch();
                                              //getNBLdetails();
                                              //getShareofshelf();
                                              SubmitCheckin();
                                              /// COMMENTED OUT 18 FEB 2024
                                              // if (onlinemode.value) {
                                              //   await smtpExampleCheckinCheckout(
                                              //       'Check In details for empid ${DBrequestdata.receivedempid}');
                                              // }
                                              // await getAvaiablitity();
                                              // await getmyattandance();
                                              //  if(noattendance.noatt=="attadded"){
                                              //    print("Attendance added:${noattendance.noatt}");
                                              //  }
                                              //  else{
                                              //     addattendence();
                                              //  }
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return CustomerActivities();
                                              }),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            } else {
                                              if (geolocation == true) {
                                                createlog(
                                                    "Geo Location was wrong tapped",
                                                    "true");
                                                forcecheck.reason =
                                                    "Geolocation was wrong";
                                                setState(() {
                                                  isApiCallProcess = true;
                                                });
                                                addforeccheckin();
                                                addattendence();
                                                SubmitCheckin();
                                                //getTaskList();
                                                //getVisibility();
                                                //getPlanogram();
                                                //getPromotionDetails();
                                                // Addedstockdataformerch();
                                                //getNBLdetails();
                                                // await getAvaiablitity();
                                                // await getShareofshelf();
                                                // await getmyattandance();
                                                // if(noattendance.noatt=="attadded"){
                                                //   print("Attendance added:${noattendance.noatt}");
                                                // }
                                                // else{
                                                //   addattendence();
                                                // }
                                                setState(() {
                                                  isApiCallProcess = false;
                                                });

                                                print("geo Location was wrong");
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                  return CustomerActivities();
                                                }),
                                                    (Route<dynamic> route) =>
                                                        false);
                                              } else {
                                                if (others == true) {
                                                  createlog(
                                                      "Others tapped", "true");
                                                  forcecheck.reason = "Others";
                                                  setState(() {
                                                    isApiCallProcess = true;
                                                  });
                                                  addforeccheckin();
                                                  addattendence();
                                                  //getTaskList();
                                                  //getVisibility();
                                                  //getPlanogram();
                                                  //getPromotionDetails();
                                                  // Addedstockdataformerch();
                                                  //await getNBLdetails();
                                                  //getShareofshelf();
                                                  // await getAvaiablitity();
                                                  await SubmitCheckin();
                                                  /// COMMENTED OUT 18 FEB 2024
                                                  // if (onlinemode.value) {
                                                  //   await smtpExampleCheckinCheckout(
                                                  //       'Check In details for empid ${DBrequestdata.receivedempid}');
                                                  // }
                                                  setState(() {
                                                    isApiCallProcess = false;
                                                  });
                                                  print("others");
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return CustomerActivities();
                                                  }),
                                                      (Route<dynamic> route) =>
                                                          false);
                                                } else {
                                                  null;
                                                }
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: orange,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            margin:
                                                EdgeInsets.only(right: 10.00),
                                            child: Center(
                                                child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }));
      },
      child: Container(
        height: 40,
        width: 70,
        decoration: BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(left: 10.00),
        child: Center(
            child: Text(
          "yes",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}

String userName = 'ramananv@thethoughtfactory.ae';
String password = 'rv13@ttf';
String domain = 'thethoughtfactory.ae';
bool isPopServerSecure = true;
String smtpServerHost = 'mail.$domain';
int smtpServerPort = 587;
bool isSmtpServerSecure = false;
var now = DateTime.now();
var checkintimetosend = DateFormat('HH:mm:ss').format(now);

Future<void> smtpExampleCheckinCheckout(body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentpage = prefs.getString('pageiddata');
  print(".......$currentpage");
  final client = SmtpClient('thethoughtfactory.ae', isLogEnabled: true);
  print(".......:${client}");

  try {
    await client.connectToServer(smtpServerHost, smtpServerPort,
        isSecure: isSmtpServerSecure);
    try {
      await client.ehlo();
    } on HandshakeException catch (e) {
      print(e);
    } on SocketException catch (_) {
      print('SocketException $_');
    } catch (e) {
      print('SMTP failed with $e');
    }

    print(".......");
    if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
      try {
        await client.authenticate(userName, password, AuthMechanism.plain);
        print("..............");
      } catch (e) {
        print('SMTP failed with $e');
      }
      print('plain');
    } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
      try {
        await client.authenticate(userName, password, AuthMechanism.login);
      } catch (e) {
        print('SMTP failed with $e');
      }

      print('login');
    } else {
      return;
    }
    final builder = MessageBuilder.prepareMultipartAlternativeMessage();
    builder.from = [MailAddress('My name', 'ramananv@thethoughtfactory.ae')];
    builder.to = [MailAddress('Your name', 'vilvaroja@gmail.com')];
    builder.subject = body;
    builder.addTextPlain(currentpage != "2"
        ? "Emp id: ${DBrequestdata.receivedempid} TimeSheet id: ${currenttimesheetid}"
            "Check In Time: $checkintimetosend Check In Location: ${getaddress.currentaddress} "
        : "Emp id: ${DBrequestdata.receivedempid} TimeSheet id: ${currenttimesheetid}"
            "Check Out Time: $checkintimetosend Check Out Location: ${getaddress.currentaddress} ");
    // builder.addTextHtml('<p>hello <b>world</b></p>');
    final mimeMessage = builder.buildMimeMessage();
    final sendResponse = await client.sendMessage(mimeMessage);
    print('message sent: ${sendResponse.isOkStatus}');
  } on SmtpException catch (e) {
    print('SMTP failed with $e');
  } on SocketException catch (_) {
    print('SocketException $_');
  } catch (e) {
    print('SMTP failed with $e');
  }
}
//
// class RoundCheckBOX extends StatefulWidget {
//   @override
//   _RoundCheckBOXState createState() => _RoundCheckBOXState();
// }
//
// class _RoundCheckBOXState extends State<RoundCheckBOX> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               gpsnotworking = true;
//               geolocation =false;
//               others = false;
//             });
//           },
//           child: Row(
//             children: [
//               ForcecheckinContent(
//                 child: gpsnotworking == true
//                     ? Icon(
//                   Icons.circle,
//                   size: 15.0,
//                   color: orange,
//                 )
//                     : null,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 "GPS Not Working",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               gpsnotworking = false;
//               geolocation =true;
//               others = false;
//             });
//           },
//           child: Row(
//             children: [
//               ForcecheckinContent(
//                 child: geolocation == true
//                     ? Icon(
//                   Icons.circle,
//                   size: 15.0,
//                   color: orange,
//                 )
//                     : null,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 "Geo Location was wrong",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               gpsnotworking = false;
//               geolocation =false;
//               others = true;
//             });
//           },
//           child: Row(
//             children: [
//               ForcecheckinContent(
//                 child: others == true
//                     ? Icon(
//                   Icons.circle,
//                   size: 15.0,
//                   color: orange,
//                 )
//                     : null,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 "others",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 10,),
//         Center(
//           child: GestureDetector(
//             onTap: ()async{
//               if (gpsnotworking == true) {
//                 setState(() {
//                   isApiCallProcess = true;
//                 });
//                 print("gps not working");
//                 SubmitCheckin();
//                 await Avaiablitity();
//                 await getVisibility();
//                 setState(() {
//                   isApiCallProcess = false;
//                 });
//                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
//                   return CustomerActivities();
//                 }), (Route<dynamic> route) => false);
//               }
//               else {
//                 if(geolocation == true){
//                   SubmitCheckin();
//                   print("geo Location was wrong");
//                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
//                     return CustomerActivities();
//                   }), (Route<dynamic> route) => false);
//                 }
//                 else {
//                   if(others == true){
//                     SubmitCheckin();
//                     print("others");
//                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
//                       return CustomerActivities();
//                     }), (Route<dynamic> route) => false);
//                   }
//                   else{
//                     null ;
//                   }
//                 }
//               }
//             },
//             child: Container(
//               height: 40,
//               width: 70,
//               decoration: BoxDecoration(
//                 color: orange,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               margin: EdgeInsets.only(right: 10.00),
//               child: Center(child: Text("submit",style: TextStyle(color: Colors.white),)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ForcecheckinContent extends StatelessWidget {
  ForcecheckinContent({this.child});

  final child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1.0),
          color: Colors.transparent),
      child: child,
    );
  }
}
