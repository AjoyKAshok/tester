import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Customers Activities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/testjourneyplanpage.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/offlinedata/syncreferenceapi.dart';
import 'package:merchandising/offlinedata/syncsendapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:merchandising/api/timesheetapi.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:merchandising/model/merchandiserschatusers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Leave Request.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Time Sheet.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:merchandising/api/timesheetmonthly.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Constants.dart';
import '../../../../utils/merchandiserdrawer.dart';

import 'package:merchandising/model/distanceinmeters.dart';
import 'package:merchandising/api/leavestakenapi.dart';
import 'package:merchandising/model/chatscreen.dart';
import 'package:merchandising/offlinedata/syncdata.dart';

import 'package:location_permissions/location_permissions.dart';
import 'package:merchandising/model/Location_service.dart';

import 'NewJourneyPlan.dart';
import 'newCustomerActivities.dart';

Future<bool> checklocationenable() async {
  try {
    bool locationreceived = await getLocation();
    print('The received location is $locationreceived');
    return locationreceived;
  } catch (e) {
    CreateLog("check of location at startday error : $e", "false");
    return true;
  }
}

Future<String> callfrequentlytocheck() async {
  if (lat != null && long != null) {
    await getLocation();
    distinmeters();
  }
}

int workingidnew;
var synctime;
bool MTBSelected = true;
bool TodaySelected = false;
bool selectMTB;
bool selectToday;
bool selectedValue;

class MerchDash extends StatefulWidget {
  @override
  _MerchDashState createState() => _MerchDashState();
}

class _MerchDashState extends State<MerchDash> {
  ///   THE BELOW TWO FUNCTIONS ARE DEFINED FOR CONTROLLIN THE DISPLAY OF THE BOTTAM MODAL SHEET ON CLICK OF THE FLOATING ACTION BUTTON - ONCE FOR A DAY / TILL LOGGED OUT FOR THE DAY.
  Future<bool> checkButtonClickedToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastClickDate = prefs.getString('lastClickDate') ?? '';

    DateTime today = DateTime.now();
    String todayDate = '${today.year}-${today.month}-${today.day}';

    return lastClickDate == todayDate;
  }

  Future<void> saveButtonClickedToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime today = DateTime.now();
    String todayDate = '${today.year}-${today.month}-${today.day}';

    prefs.setString('lastClickDate', todayDate);
  }

  syncNow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dashSync = prefs.getBool('dashsync') ?? false;
    print("syncNow from dashBoard...");
    if (onlinemode.value && !dashSync) {
      currentlysyncing = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => StatefulBuilder(builder: (context, setState) {
                progress.value = 10;
                currentlysyncing = true;
                return ValueListenableBuilder<int>(
                    valueListenable: progress,
                    builder: (context, value, child) {
                      return AlertDialog(
                        backgroundColor: alertboxcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Synchronizing ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    SizedBox(width: 5),
                                    currentlysyncing
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: orange,
                                              strokeWidth: 2,
                                            ))
                                        : SizedBox(),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 0.8,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${progress.value} %",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: orange),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GFProgressBar(
                                    percentage: (progress.value) / 100,
                                    backgroundColor: Colors.black26,
                                    progressBarColor: orange),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(
                                  AppConstants.dont_turn_off,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            );
                          },
                        ),
                      );
                    });
              }));

      if (message.length > 0) {
        await syncingsenddata();
        print('fat');
      }

      await syncingreferencedata();

      prefs.setBool("dashsync", true);
      currentlysyncing = false;
      dispose.value = true;
      Navigator.pop(context,
          MaterialPageRoute(builder: (BuildContext context) => MerchDash()));
    }
  }

  void _launchWebsite() async {
    if (Platform.isIOS) {
      String url =
          "https://apps.apple.com/in/app/rhapsody-merchandising/id1570126675";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      String url =
          "https://play.google.com/store/apps/details?id=rameolic.merchandising&pcampaignid=web_share";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _showAlertDialog(BuildContext context) {
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Update Alert!!!'),
      content: Text(
          'You seem to be on an outdated version of the app. Please update the app to continue...'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Close the dialog
            // Navigator.of(context).pop();
            _launchWebsite();
          },
          child: Text('OK'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future getVersion() async {
    Map versionBody = {
      "number": appversionnumber,
    };
    print('App Version is : ${appversionnumber}');
    try {
      http.Response Response = await http.post(versionCheck,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
          },
          body: jsonEncode(versionBody));
      print('Version Check Status Code : ${Response.statusCode}');
      if (Response.statusCode == 400) {
        _showAlertDialog(context);
      }
    } catch (e) {
      print('Error in Fetching Version : $e');
    }
  }

  @override
  void initState() {
    currentpagestatus('0', '0', '0', '0');
    ischatscreen = 0;

    print("chatscreen from dshbrd: $ischatscreen");

    loadValue();
    // getVersion();
  }

  loadValue() async {
    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   await syncData();
    // });
    /// COMMENTING OUT TEMPORARILY TO CHECK WORKING.
    getVersion();

    if (fromloginscreen) {
      // await initializeService();

      Future.delayed(const Duration(seconds: 2), () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        synctime = DateTime.parse(prefs.getString('lastsyncedonendtime'));

        showDialog(
            context: context,
            builder: (_) => StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor: Colors.white, //alertboxcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Builder(
                      builder: (context) {
                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              greetingMessage(),
                              style: TextStyle(
                                  color: Color(0XFFE84201), fontSize: 20),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Text(
                              AppConstants.greetings,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DBrequestdata.empname,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0XFFE84201), fontSize: 14),
                            ),
                            //SizedBox(height: 5,),
                            synctime != null
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3.0, bottom: 3),
                                    child: Text(
                                      "last synced on : ${DateFormat.yMd().add_jm().format(synctime)}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0XFFE84201),
                                          fontSize: 10),
                                    ))
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image(
                                  height: 30,
                                  image: AssetImage('images/rmsLogo.png'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }));
      });
      fromloginscreen = false;
    }
    print("loadValue from dash");
    currentlysyncing = true;
    setState(() {
      isApiCallProcess = true;
    });
    await DBRequestdaily();
    await DBRequestmonthly();
    setState(() {
      isApiCallProcess = false;
    });
  }

  Container makeDashboardItem(
    String title,
    String userCount,
    IconData icon,
    int colorCode,
    int subColorCode,
  ) {
    // String countUser;
    // countUser = getUserCount(selectedValue);
    return Container(
      height: 95,
      width: 162,
      decoration: BoxDecoration(
        color: Color(colorCode),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          var _value = title;
          if (_value == 'Scheduled Visits') {
            // Navigator.of(context).pushNamed(ClientList.routeName);
          } else if (_value == 'Unscheduled Visits') {
          } else if (_value == "Scheduled Visits Done") {
          } else if (_value == 'Unscheduled Visits Done') {}
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      color: Color(subColorCode),
                      height: 26,
                      width: 26,
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 5,
                    ),
                    child: Text(
                      userCount,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 15,
                ),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// COMMENTING OUT AS LEAVE DETAILS ARE NOT REQUIRED FOR THE DASHBOARD SCREEN FOR THE TIME BEING.
  ///
  // Container makeLeaveDashboardItem(
  //   String title,
  //   String users,
  //   IconData icon,
  //   int colorCode,
  //   int subColorCode,
  // ) {
  //   return Container(
  //     height: 95,
  //     width: 162,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: InkWell(
  //       onTap: () async {
  //         var _value = title;
  //         if (_value == 'Available Leaves') {
  //           if (onlinemode.value) {
  //             setState(() {
  //               isApiCallProcess = true;
  //             });
  //             await leaveData();
  //             await Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (BuildContext context) => leavestatusPage()));
  //             setState(() {
  //               isApiCallProcess = false;
  //             });
  //           } else {
  //             await Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (BuildContext context) => leavestatusPage()));
  //           }
  //         } else if (_value == 'HQ Communication') {
  //           //  Navigator.push(
  //           //       context,
  //           //       MaterialPageRoute(
  //           //           builder: (buildContext) => HQCommunication()));
  //           setState(() {
  //             ischatscreen = 1;
  //             newmsgavaiable = false;
  //             chat.receiver = fieldmanagerofcurrentmerch;
  //           });
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (BuildContext context) => ChatUsersformerch()));
  //         }
  //       },
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Row(
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.all(10),
  //                   child: Container(
  //                     color: Color(subColorCode),
  //                     height: 26,
  //                     width: 26,
  //                     child: Icon(
  //                       icon,
  //                       color: Color(colorCode),
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     top: 5,
  //                   ),
  //                   child: Text(
  //                     users,
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(
  //                 left: 10,
  //                 top: 15,
  //               ),
  //               child: Text(
  //                 title,
  //                 // style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Container makeTimeSheetDashboardItem(
    String title,
    String users,
    IconData icon,
    int colorCode,
    int subColorCode,
  ) {
    return Container(
      height: 165,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () async {
          if (onlinemode.value) {
            // createlog("time sheet tapped", "true");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            requireurlstosync = prefs.getStringList('addtoserverurl');
            if (requireurlstosync == null) {
              requireurlstosync = [];
            }
            if (requireurlstosync.length == 0) {
              setState(() {
                isApiCallProcess = true;
              });
              timesheet.empid = DBrequestdata.receivedempid;
              await getTimeSheetdaily();
              await gettimesheetmonthly();

              /// THE BELOW ONE LINE IS COMMENTED AS ADIB SAID THAT ITS NOT REQUIRED
              // await gettimesheetleavetype();

              //await gettimesheetleavetype1();
              // leaveReportData();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContextcontext) => TimeSheetList()));
              setState(() {
                isApiCallProcess = false;
              });
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContextcontext) => TimeSheetList()));
            }
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContextcontext) => TimeSheetList()));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      color: Color(subColorCode),
                      height: 26,
                      width: 26,
                      child: Icon(
                        icon,
                        color: Color(colorCode),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 5,
                    ),
                    child: Text(
                      users,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 15,
                  right: 10,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getMTBUserCount() {
    setState(() {
      uCount = '${DBResponsedatamonthly.shedulevisits}';
    });
    return uCount;
  }

  getTodayUserCount() {
    setState(() {
      uCount = '${DBResponsedatadaily.shedulevisits}';
    });
  }

  bool isApiCallProcess = false;
  bool pressAttentionMTB = true;
  bool pressAttentionTODAY = false;
  bool uniform = false;
  bool unit = false;
  bool transport = false;
  bool posm = false;
  bool location = false;
  String uCount;
  int index;
  String workingEffectiveMTB;
  String workingEffectiveDaily;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProgressHUD(
            child: _uiSetup(context),
            inAsyncCall: isApiCallProcess,
            opacity: 0.3,
          ),
        ),
      
    );
  }

  Widget _uiSetup(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home),
      const Icon(Icons.notifications),
    ];
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () async {
            print('The working id is : $workingidnew');
            bool buttonClickedToday = await checkButtonClickedToday();

            if (buttonClickedToday) {
              // If clicked today, navigate to a particular page
              //  Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         NewJourneyPlanPage()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestJourneyPlanPage()),
              );
            } else {
              // If not clicked today, display bottom modal sheet
              // BottomModalSheet(context);
              setState(() {
                isApiCallProcess = true;
              });
              if (await checklocationenable()) {
                print(gettodayjp.checkintime);
                print(gettodayjp.checkouttime);
                print(gettodayjp.status);
                workingidnew = null;
                for (int u = 0; u < gettodayjp.status.length; u++) {
                  if (gettodayjp.status[u] == AppConstants.working) {
                    workingidnew = gettodayjp.id[u];
                    currentoutletindex = u;
                    currentoutletid = gettodayjp.outletids[u];
                    print('The working id is : $workingidnew');
                    print(gettodayjp.id[u]);
                    chekinoutlet.checkinoutletid = gettodayjp.storecodes[u];
                    chekinoutlet.checkinoutletname = gettodayjp.storenames[u];
                    chekinoutlet.checkinarea = gettodayjp.outletarea[u];
                    chekinoutlet.checkincity = gettodayjp.outletcity[u];
                    chekinoutlet.checkinstate = gettodayjp.outletcountry[u];
                    chekinoutlet.checkincountry = gettodayjp.outletcountry[u];
                  }
                }
                setState(() {
                  isApiCallProcess = false;
                });

                workingidnew == null
                    ? showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => BottomModalSheet(),
                      )
                    : showDialog(
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
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppConstants.alert,
                                            style: TextStyle(
                                                color: orange, fontSize: 20),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 0.8,
                                          ),
                                          Text(
                                            "you have unfinished outlet!",
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Note* if you recently checked out please wait 2 minutes minimum to get the updated data",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: orange, fontSize: 10),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () async {
                                                // createlog("unfinished outlet OK tapped","true");

                                                setState(() {
                                                  isApiCallProcess = true;
                                                  regularcheckout = false;
                                                });
                                                print(
                                                    "current outlet id: $currentoutletid");

                                                outletrequestdata
                                                        .outletidpressed =
                                                    currentoutletid;
                                                checkinoutdata.checkid =
                                                    workingidnew;
                                                currenttimesheetid =
                                                    workingidnew;

                                                setState(() {
                                                  isApiCallProcess = false;
                                                });
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            NewCustomerActivities()));
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: orange,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                    child: Text(AppConstants.ok,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            }));
              } else {
                setState(() {
                  isApiCallProcess = false;
                });
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          content: Builder(
                            builder: (context) {
                              // Get available height and width of the build area of this widget. Make a choice depending on the size.
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppConstants.alert,
                                    style:
                                        TextStyle(color: orange, fontSize: 20),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                  Text(
                                    "Location permissions need to be granted to proceed further.",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        bool permission =
                                            await LocationPermissions()
                                                .openAppSettings();
                                        print(permission);
                                      },
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: orange,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: Text('Open Settings',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              // Save the click status for today
              saveButtonClickedToday();
            }
          },
          child: Container(
            height: 66,
            width: 66,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFF88200), Color(0xFFE43700)]),
              // borderRadius: BorderRadius.circular(10.00),
            ),
            child: Center(
              child: Text(
                'START DAY',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: orange),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Image.asset(
                "images/NewRMSMenu.png",
                height: 25,
                width: 44,
                color: Color(0XFF505050),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 30,
                    image: AssetImage('images/rmsLogo.png'),
                  ),
                  EmpInfo()
                ],
              ),
              Flexible(
                child: Container(
                  width: 180,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pressAttentionMTB = true;
                                pressAttentionTODAY = false;
                                var workingTimeDaily =
                                    "${DBResponsedatadaily.WorkingTime}";
                                var workingTimeMonthly =
                                    "${DBResponsedatamonthly.WorkingTime}";
                                var effectiveTimeDaily =
                                    "${DBResponsedatadaily.EffectiveTime}";
                                var effectiveTimeMonthly =
                                    "${DBResponsedatamonthly.EffectiveTime}";
                                workingEffectiveMTB =
                                    "${DBResponsedatadaily.EffectiveTime}" ==
                                            '0'
                                        ? '0'
                                        : "${DBResponsedatamonthly.WorkingTime}"
                                            '/'
                                            "${DBResponsedatamonthly.EffectiveTime}";
                                // workingEffectiveMTB = workingTimeMonthly;
                                // workingEffectiveMTB = effectiveTimeMonthly;
                                workingEffectiveDaily =
                                    "${DBResponsedatadaily.EffectiveTime}" ==
                                            '0'
                                        ? '0'
                                        : "${DBResponsedatadaily.WorkingTime}"
                                            '/'
                                            "${DBResponsedatadaily.EffectiveTime}";
                                // workingEffectiveDaily = workingTimeDaily;
                                // workingEffectiveDaily = effectiveTimeDaily;

                                /// FOR CHECKING PURPOSE
                                ///
                                // print('Monthly Working Time : $workingTimeMonthly');
                                // print('Daily Working Time : $workingTimeDaily');
                                // print('Monthly Effective Time : $effectiveTimeMonthly');
                                // print('Daily Effective Time : $effectiveTimeDaily');

                                // uCount = '${DBResponsedatamonthly.shedulevisits}';
                              });
                            },
                            child: Container(
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: pressAttentionMTB == true
                                    ? const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                            Color(0xFFF88200),
                                            Color(0xFFE43700)
                                          ])
                                    : const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFFFFFFF)
                                          ]),
                              ),
                              child: Center(
                                child: Text(
                                  'MTB',
                                  style: TextStyle(
                                    color: pressAttentionMTB == true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              pressAttentionTODAY = true;
                              pressAttentionMTB = false;
                              // uCount = '${DBResponsedatadaily.shedulevisits}';
                            });
                          },
                          child: Container(
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: pressAttentionTODAY == true
                                  ? const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                          Color(0xFFF88200),
                                          Color(0xFFE43700)
                                        ])
                                  : const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                          Color(0xFFFFFFFF),
                                          Color(0xFFFFFFFF)
                                        ]),
                            ),
                            child: Center(
                              child: Text(
                                'ToDay',
                                style: TextStyle(
                                  color: pressAttentionTODAY == true
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: GestureDetector(
          onTap: () {
            // createlog("Menu tapped","true");
          },
          child: Drawer(
            child: MerchandiserDrawer(),
          ),
        ),

        /// BOTTOM NAVIGATION BAR IS COMMENTED OUT AS OF NOW, BUT HAS TO BE INCORPORATED ON A LATER STAGE AFTER THE PROPER DETAILS IS COLLECTED.
        ///
        // bottomNavigationBar: CurvedNavigationBar(
        //   animationDuration: Duration(milliseconds: 300),
        //   backgroundColor: Colors.white,
        //   items: items,
        //   index: index ?? 0,
        //   height: 60,
        //   onTap: (index) => setState(() {
        //     this.index = index;

        //     index == 1
        //         ? Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (buildContext) => NotificationsPage()))
        //         : null;
        //   }),
        // ),
        body: ValueListenableBuilder<bool>(
            valueListenable: onlinemode,
            builder: (context, value, child) {
              // checkSelectedValue();
              print('From the new interface');
              print('The selectMTB value in body : $pressAttentionMTB');
              print('The selectToday value in body : $pressAttentionTODAY');
              print('Current User Count : $uCount');
              return OfflineNotification(
                body: Stack(
                  children: [
                    BackGround(),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Performance Indicators',
                                style: TextStyle(
                                    fontSize: 17, color: Color(0XFF909090)),
                              ),
                            ),

                            SizedBox(
                              height: 12,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 21, right: 11),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: makeDashboardItem(
                                        'Scheduled Visits',
                                        pressAttentionMTB == true
                                            ? '${DBResponsedatamonthly.shedulevisits}'
                                            : '${DBResponsedatadaily.shedulevisits}',
                                        Icons.phone,
                                        0XFFF76F8D,
                                        0XFFFFC6D3),
                                  ),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Expanded(
                                    child: makeDashboardItem(
                                        'Unscheduled Visits',
                                        pressAttentionMTB == true
                                            ? '${DBResponsedatamonthly.unshedulevisits}'
                                            : '${DBResponsedatadaily.unshedulevisits}',
                                        Icons.warning,
                                        0XFF1EC2C1,
                                        0XFF77F4F4),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 21, right: 11),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: makeDashboardItem(
                                        'Scheduled Visits Done',
                                        pressAttentionMTB == true
                                            ? '${DBResponsedatamonthly.ShedulevisitssDone}'
                                            : '${DBResponsedatadaily.ShedulevisitssDone}',
                                        Icons.call_made_outlined,
                                        0XFF5589EA,
                                        0XFF5589EA),
                                  ),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Expanded(
                                    child: makeDashboardItem(
                                        'Unscheduled Visits Done',
                                        pressAttentionMTB == true
                                            ? '${DBResponsedatamonthly.UnShedulevisitsDone}'
                                            : '${DBResponsedatadaily.UnShedulevisitsDone}',
                                        Icons.call_made_outlined,
                                        0XFFF4B947,
                                        0XFFF9B636),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 11,
                              ),
                              child: Text(
                                'Time Sheet',
                                style: TextStyle(
                                    fontSize: 17, color: Color(0XFF909090)),
                              ),
                            ),

                            SizedBox(
                              height: 1,
                            ),
                            Container(
                              height: 208,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 21.0,
                                    ),
                                    child: makeTimeSheetDashboardItem(
                                        'Your Attendence',
                                        pressAttentionMTB == true
                                            ? '${DBResponsedatamonthly.Attendance}'
                                            : '${DBResponsedatadaily.Attendance}',
                                        Icons.calendar_month_rounded,
                                        0XFFE84201,
                                        0XFFFFF3EE),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 5),
                                    child: makeTimeSheetDashboardItem(
                                        'Working & Effective Time',
                                        pressAttentionMTB == true
                                            ? "${DBResponsedatamonthly.WorkingTime}"
                                                "\n"
                                                '-----'
                                                "\n"
                                                "${DBResponsedatamonthly.EffectiveTime}"
                                            : "${DBResponsedatadaily.WorkingTime}"
                                                "\n"
                                                '-----'
                                                "\n"
                                                "${DBResponsedatadaily.EffectiveTime}",
                                        // ? workingEffectiveMTB
                                        // : workingEffectiveDaily,
                                        Icons.lock_clock,
                                        0XFFE84201,
                                        0XFFFFF3EE),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 19),
                                    child: makeTimeSheetDashboardItem(
                                        'Your Travel Time',
                                        pressAttentionMTB == true
                                            ? '${DBResponsedatamonthly.TravelTime}'
                                            : '${DBResponsedatadaily.TravelTime}',
                                        Icons.nordic_walking,
                                        0XFFE84201,
                                        0XFFFFF3EE),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 12,
                                    left: 20,
                                  ),
                                  child: Text(
                                    'Travel Plan',
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0XFF909090)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 21, right: 19),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 136,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Container(
                                            height: 116,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .41,
                                            decoration: BoxDecoration(
                                              color: Color(0XFFFAFAFA),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                Text('Completion'),
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      CircularProgressIndicator(
                                                        value: pressAttentionMTB ==
                                                                true
                                                            ? (double.parse('${DBResponsedatamonthly.ShedulevisitssDone + DBResponsedatamonthly.UnShedulevisitsDone}') /
                                                                        double.parse(
                                                                            '${DBResponsedatamonthly.shedulevisits + DBResponsedatamonthly.unshedulevisits}')) <
                                                                    101
                                                                ? (double.parse(
                                                                        '${DBResponsedatamonthly.ShedulevisitssDone + DBResponsedatamonthly.UnShedulevisitsDone}')) /
                                                                    (double.parse(
                                                                        '${DBResponsedatamonthly.shedulevisits + DBResponsedatamonthly.unshedulevisits}'))
                                                                : 0.0
                                                            : (double.parse('${DBResponsedatadaily.ShedulevisitssDone + DBResponsedatadaily.UnShedulevisitsDone}') /
                                                                        double.parse(
                                                                            '${DBResponsedatadaily.shedulevisits + DBResponsedatadaily.unshedulevisits}')) <
                                                                    101
                                                                ? (double.parse(
                                                                        '${DBResponsedatadaily.ShedulevisitssDone + DBResponsedatadaily.UnShedulevisitsDone}') /
                                                                    double.parse(
                                                                        '${DBResponsedatadaily.shedulevisits + DBResponsedatadaily.unshedulevisits}'))
                                                                : 0.0,
                                                        backgroundColor:
                                                            Color(0XFFEAECF0),
                                                        color:
                                                            Color(0XFFF76F8D),
                                                        strokeWidth: 6,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          pressAttentionMTB ==
                                                                  true
                                                              ? (int.parse(
                                                                          '${DBResponsedatamonthly.ShedulevisitssDone + DBResponsedatamonthly.UnShedulevisitsDone}') /
                                                                      int.parse(
                                                                          '${DBResponsedatamonthly.shedulevisits + DBResponsedatamonthly.unshedulevisits}') *
                                                                      100)
                                                                  .toStringAsFixed(
                                                                      0)
                                                              : (int.parse(
                                                                          '${DBResponsedatadaily.ShedulevisitssDone + DBResponsedatadaily.UnShedulevisitsDone}') /
                                                                      int.parse(
                                                                          '${DBResponsedatadaily.shedulevisits + DBResponsedatadaily.unshedulevisits}') *
                                                                      100)
                                                                  .toStringAsFixed(
                                                                      0),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 10),
                                            child: Container(
                                              height: 116,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .41,
                                              decoration: BoxDecoration(
                                                color: Color(0XFFFAFAFA),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text('Process'),
                                                  SizedBox(
                                                    height: 11,
                                                  ),
                                                  Container(
                                                    height: 70,
                                                    width: 70,
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        CircularProgressIndicator(
                                                          value:
                                                              pressAttentionMTB ==
                                                                      true
                                                                  ? 0.5
                                                                  : 0.1,
                                                          color:
                                                              Color(0XFFF4B947),
                                                          backgroundColor:
                                                              Color(0XFFEAECF0),
                                                          strokeWidth: 6,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            pressAttentionMTB ==
                                                                    true
                                                                ? '50'
                                                                : '10',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12,
                                left: 20,
                              ),
                              child: Text(
                                'Activity Performance',
                                style: TextStyle(
                                    fontSize: 17, color: Color(0XFF909090)),
                              ),
                            ),
                            Container(
                              height: 208,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 21, right: 19),
                                      child: Container(
                                        height: 108,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                    ),
                                                    child: Container(
                                                      height: 8,
                                                      width: 8,
                                                      color: Color(0XFF1EC2C1),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text(
                                                      'Primary',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0XFF909090),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 19,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                    ),
                                                    child: Container(
                                                      height: 8,
                                                      width: 8,
                                                      color: Color(0XFFEAECF0),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text(
                                                      'Secondary',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0XFF909090),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 9,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 11),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Planned',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0XFF909090),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 9.0),
                                                      child: Text(
                                                        'Total',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF909090),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 12,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 11.0),
                                                      child:
                                                          // Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          //   children: [
                                                          LinearProgressIndicatorWidget(
                                                        completedPercentage:
                                                            pressAttentionMTB ==
                                                                    true
                                                                ? double.parse(
                                                                    '${DBResponsedatamonthly.shedulevisits}')
                                                                : double.parse(
                                                                    '${DBResponsedatadaily.shedulevisits}'),
                                                        incompletePercentage:
                                                            pressAttentionMTB ==
                                                                    true
                                                                ? double.parse(
                                                                    '${DBResponsedatamonthly.unshedulevisits}')
                                                                : double.parse(
                                                                    '${DBResponsedatadaily.unshedulevisits}'),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 9.0),
                                                    child: Text(
                                                      pressAttentionMTB == true
                                                          ? '${DBResponsedatamonthly.shedulevisits + DBResponsedatamonthly.unshedulevisits}'
                                                          : '${DBResponsedatadaily.shedulevisits + DBResponsedatadaily.unshedulevisits}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 11),
                                                child: Text(
                                                  'Actual',
                                                  style: TextStyle(
                                                    color: Color(0XFF909090),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 12,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 11.0),
                                                      child:
                                                          //  Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          //    children: [
                                                          LinearProgressIndicatorWidget(
                                                        completedPercentage:
                                                            pressAttentionMTB ==
                                                                    true
                                                                ? double.parse(
                                                                    '${DBResponsedatamonthly.ShedulevisitssDone}')
                                                                : double.parse(
                                                                    '${DBResponsedatadaily.ShedulevisitssDone}'),
                                                        incompletePercentage:
                                                            pressAttentionMTB ==
                                                                    true
                                                                ? double.parse(
                                                                    '${DBResponsedatamonthly.UnShedulevisitsDone}')
                                                                : double.parse(
                                                                    '${DBResponsedatadaily.UnShedulevisitsDone}'),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 9.0),
                                                    child: Text(
                                                      pressAttentionMTB == true
                                                          ? '${DBResponsedatamonthly.ShedulevisitssDone + DBResponsedatamonthly.UnShedulevisitsDone}'
                                                          : '${DBResponsedatadaily.ShedulevisitssDone + DBResponsedatadaily.UnShedulevisitsDone}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// THIS BELOW PIECE OF CODE IS REQUIRED, COMMENTED OUT TO TEST THE UI.
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            /// THE CODE IS COMMENTED OUT AS THE DETAILS ARE MOVED TO THE NEW DESIGN.
                            // Container(
                            //   height: 120,
                            //   width: MediaQuery.of(context).size.width / 1.55,
                            //   padding: EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     color: containerscolor,
                            //   ),
                            //   child: ActivityPerformance1(
                            //     pprimary: pressAttentionMTB == true
                            //         ? '${DBResponsedatamonthly.shedulevisits}'
                            //         : '${DBResponsedatadaily.shedulevisits}',
                            //     psecondary: pressAttentionMTB == true
                            //         ? '${DBResponsedatamonthly.unshedulevisits}'
                            //         : '${DBResponsedatadaily.unshedulevisits}',
                            //     ptotal: pressAttentionMTB == true
                            //         ? '${DBResponsedatamonthly.shedulevisits + DBResponsedatamonthly.unshedulevisits}'
                            //         : '${DBResponsedatadaily.shedulevisits + DBResponsedatadaily.unshedulevisits}',
                            //     aprimary: pressAttentionMTB == true
                            //         ? '${DBResponsedatamonthly.ShedulevisitssDone}'
                            //         : '${DBResponsedatadaily.ShedulevisitssDone}',
                            //     asecondary: pressAttentionMTB == true
                            //         ? '${DBResponsedatamonthly.UnShedulevisitsDone}'
                            //         : '${DBResponsedatadaily.UnShedulevisitsDone}',
                            //     atotal: pressAttentionMTB == true
                            //         ? '${DBResponsedatamonthly.ShedulevisitssDone + DBResponsedatamonthly.UnShedulevisitsDone}'
                            //         : '${DBResponsedatadaily.ShedulevisitssDone + DBResponsedatadaily.UnShedulevisitsDone}',
                            //   ),
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     setState(() {
                            //       ischatscreen = 1;
                            //       newmsgavaiable = false;
                            //       chat.receiver = fieldmanagerofcurrentmerch;
                            //     });
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (BuildContext context) =>
                            //                 ChatUsersformerch()));
                            //   },
                            //   child: Container(
                            //     height: 120,
                            //     width:
                            //         MediaQuery.of(context).size.width / 3.25,
                            //     padding: EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10.0),
                            //       color: onlinemode.value
                            //           ? containerscolor
                            //           : iconscolor,
                            //     ),
                            //     child: Stack(
                            //       children: [
                            //         Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceEvenly,
                            //           children: [
                            //             Icon(
                            //               Icons.mark_chat_unread_rounded,
                            //               size: 40,
                            //               color: onlinemode.value
                            //                   ? iconscolor
                            //                   : containerscolor,
                            //             ),
                            //             FittedBox(
                            //                 fit: BoxFit.fitWidth,
                            //                 child: Text(
                            //                   "HQ\nCommunication",
                            //                   textAlign: TextAlign.center,
                            //                   maxLines: 2,
                            //                   style: TextStyle(
                            //                       color: onlinemode.value
                            //                           ? iconscolor
                            //                           : containerscolor),
                            //                 )),
                            //           ],
                            //         ),
                            //         newmsgavaiable
                            //             ? Align(
                            //                 alignment: Alignment.topRight,
                            //                 child: Icon(
                            //                   CupertinoIcons.bell_solid,
                            //                   color: Colors.red,
                            //                   size: 20,
                            //                 ),
                            //               )
                            //             : SizedBox(),
                            //       ],
                            //     ),
                            //   ),
                            //     // ),
                            //   ],
                            // ),

                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   height: 125,
                            //   width: MediaQuery.of(context).size.width / 1.03,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     color: containerscolor,
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Spacer(
                            //         flex: 2,
                            //       ),
                            //       Icon(
                            //         CupertinoIcons.sun_max,
                            //         color: Colors.black,
                            //         size: 50,
                            //       ),
                            //       Spacer(flex: 2),
                            //       Text(
                            //         'Welcome to the new merchandiser\ninterface of RMS. '
                            //         'Hope to have a\ngreat day ahead!',
                            //         style: new TextStyle(fontSize: 15),
                            //       ),
                            //       Spacer(
                            //         flex: 2,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // NBlFloatingButton()
                  ],
                ),
              );
            }));
  }

  checkMTB() {
    setState(() {
      selectMTB = pressAttentionMTB;
    });
  }

  checkToday() {
    setState(() {
      selectToday = pressAttentionTODAY;
    });
  }

  checkSelectedValue() {
    setState(() {
      selectMTB = pressAttentionMTB;
      selectToday = pressAttentionTODAY;
      print('MTB Value : $selectMTB');
      print('Today Value : $selectToday');
    });
  }
}

class WorkingRow extends StatelessWidget {
  WorkingRow({this.icon, this.chartext, this.numtext});

  final icon;
  final chartext;
  final numtext;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: onlinemode.value ? iconscolor : containerscolor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                chartext,
                style: TextStyle(
                    color: onlinemode.value ? iconscolor : containerscolor),
              ),
              Container(
                height: 1,
                width: 95,
                color: onlinemode.value ? iconscolor : containerscolor,
              ),
              Text(
                numtext,
                style: TextStyle(
                    color: onlinemode.value ? iconscolor : containerscolor),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class JourneryPlan extends StatelessWidget {
//   JourneryPlan({this.color, this.percent, this.textpercent, this.title});

//   final color;
//   final percent;
//   final textpercent;
//   final title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           CircularPercentIndicator(
//             radius: 35,

//             percent: percent,
//             lineWidth: 2.0,
//             //resizeToAvoidBottomInset: false, // set it to false
//             backgroundColor: Colors.grey[350],
//             progressColor: color,
//             center: Text(textpercent == null ? "" : textpercent),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           AutoSizeText(
//             title,
//             maxLines: 3,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

class BottomModalSheet extends StatefulWidget {
  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  bool isUniformChecked = false;
  bool isChargerChecked = false;
  bool isTransportationChecked = false;
  bool isPOSMChecked = false;
  bool isLocationChecked = false;
  bool isAllChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .66,
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
                    left: 19,
                    top: 18,
                  ),
                  child: Text(
                    'Roll Call',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    top: 20,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        print('Close Button Tapped');
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 12,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0XFFE84201),
                    value: isUniformChecked,
                    onChanged: (value) {
                      setState(() {
                        isUniformChecked = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Uniform & Hygiene'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0XFFE84201),
                    value: isChargerChecked,
                    onChanged: (value) {
                      setState(() {
                        isChargerChecked = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Hand held unit charge'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0XFFE84201),
                    value: isTransportationChecked,
                    onChanged: (value) {
                      setState(() {
                        isTransportationChecked = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Transportation'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0XFFE84201),
                    value: isPOSMChecked,
                    onChanged: (value) {
                      setState(() {
                        isPOSMChecked = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('POSM'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0XFFE84201),
                    value: isLocationChecked,
                    onChanged: (value) {
                      setState(() {
                        isLocationChecked = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Location'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 36,
                bottom: 27,
              ),
              child: Text(
                  'Note: If you are trying to checkout any unfinished outlet, please synchronize & try again'),
            ),
            SizedBox(
              height: 17,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  isAllChecked
                      ? print('All Checked')
                      : print('All parameters are not checked');
                },
                child: GestureDetector(
                  onTap: () {
                    if (isUniformChecked &&
                        isChargerChecked &&
                        isTransportationChecked &&
                        isPOSMChecked) {
                          //  Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         NewJourneyPlanPage()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TestJourneyPlanPage()));
                      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => JourneyPlanPage()));
                    }
                  },
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: isUniformChecked
                            ? [Color(0xFFF88200), Color(0xFFE43700)]
                            : isChargerChecked
                                ? [Color(0xFFF88200), Color(0xFFE43700)]
                                : isTransportationChecked
                                    ? [Color(0xFFF88200), Color(0xFFE43700)]
                                    : isPOSMChecked
                                        ? [Color(0xFFF88200), Color(0xFFE43700)]
                                        : isLocationChecked
                                            ? [
                                                Color(0xFFF88200),
                                                Color(0xFFE43700)
                                              ]
                                            : [
                                                Color(0xFFC4C4C4),
                                                Color(0xFF9F9F9F),
                                              ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: isUniformChecked
                              ? Colors.white
                              : isChargerChecked
                                  ? Colors.white
                                  : isTransportationChecked
                                      ? Colors.white
                                      : isPOSMChecked
                                          ? Colors.white
                                          : isLocationChecked
                                              ? Colors.white
                                              : Colors.black,
                        ),
                      ),
                    ),
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

class ActivityPerformance1 extends StatelessWidget {
  ActivityPerformance1({
    this.aprimary,
    this.asecondary,
    this.atotal,
    this.pprimary,
    this.psecondary,
    this.ptotal,
  });

  final ptotal;
  final atotal;
  final pprimary;
  final psecondary;
  final aprimary;
  final asecondary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      // child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Activity Performance"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey),
              ),
              columnWidths: {
                0: FractionColumnWidth(.23),
                1: FractionColumnWidth(.235),
                2: FractionColumnWidth(.242),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                        top: 8.0,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Planned",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            ptotal,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "  Total  ",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            pprimary,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              " Primary ",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            psecondary,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Secondary",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 14.0,
                          right: 8.0,
                        ),
                        child: Text(
                          "Actual ",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Column(
                        children: [
                          Text(
                            atotal,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "  Total  ",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Column(
                        children: [
                          Text(
                            aprimary,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              " Primary ",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Column(
                        children: [
                          Text(
                            asecondary,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Secondary",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}

//dropdown button

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

int _value = 1;
List<ListItem> _dropdownItems = [
  ListItem(1, "Annual Leave"),
  ListItem(2, "Sick Leave"),
  ListItem(3, "Comp Off"),
  ListItem(4, "Week Off")
];
