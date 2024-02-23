import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/Merchandiser/OverAllJourneyPlanPage.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Customers%20Activities.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Maps_Veiw.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/jpskiped.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/jpvisited.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/weeklyjpwidgets/weeklyjp.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/weeklyjpwidgets/weeklyskipjp.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/weeklyjpwidgets/weeklyvisitjp.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/JPvisitedapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/jpskippedapi.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpskipped.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpvisited.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/model/distanceinmeters.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/offlinedata/syncdata.dart';
import 'package:merchandising/offlinedata/syncreferenceapi.dart';
import 'package:merchandising/utils/background.dart';

import '../../ConstantMethods.dart';
import 'Customers Activities.dart';
import 'outletdetailes.dart';

List<String> breakspl = [];
bool jptimecal = false;

class JourneyPlanPage extends StatefulWidget {
  @override
  _JourneyPlanPageState createState() => _JourneyPlanPageState();
}

class _JourneyPlanPageState extends State<JourneyPlanPage> {
  @override
  void initState() {
    super.initState();

    loadValues();
  }

  loadValues() async {
    print('Working Id before process: $workingid');
    print('${gettodayjp.status.length}');
    for (int u = 0; u < gettodayjp.status.length; u++) {
      if (gettodayjp.status[u] == AppConstants.working) {
        workingid = await gettodayjp.id[u];
        currentoutletindex = u;
        currentoutletid = gettodayjp.outletids[u];
        print('The working id is : $workingid');
        print(gettodayjp.id[u]);
        chekinoutlet.checkinoutletid = gettodayjp.storecodes[u];
        chekinoutlet.checkinoutletname = gettodayjp.storenames[u];
        chekinoutlet.checkinarea = gettodayjp.outletarea[u];
        chekinoutlet.checkincity = gettodayjp.outletcity[u];
        chekinoutlet.checkinstate = gettodayjp.outletcountry[u];
        chekinoutlet.checkincountry = gettodayjp.outletcountry[u];
      }
    }

    workingid != null
        ? showDialog(
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
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppConstants.alert,
                                style: TextStyle(color: orange, fontSize: 20),
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
                                style: TextStyle(color: orange, fontSize: 10),
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

                                    outletrequestdata.outletidpressed =
                                        currentoutletid;
                                    checkinoutdata.checkid = workingid;
                                    currenttimesheetid = workingid;

                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CustomerActivities()));
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: orange,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: Text(AppConstants.ok,
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
                }))
        : null;

    /// THE ABOVE CODE IS PART OF A TEST. HAS TO VERIFY AGAIN...
    ///
    createlog("Navigated to Journey plan Page", "true");
    await currentpagestatus('1', '1', '1', '1');

    if (checkoutrequested && checkoutdatasubmitted) {
      Future.delayed(const Duration(seconds: 2), () {
        Flushbar(
          message: AppConstants.checkout_updated,
          duration: Duration(seconds: 5),
        )..show(context);
        checkoutrequested = false;
        checkoutdatasubmitted = false;
      });
    } else if (checkoutrequested && !checkoutdatasubmitted) {
      Future.delayed(const Duration(seconds: 2), () {
        Flushbar(
          message: AppConstants.checkout_error,
          duration: Duration(seconds: 5),
        )..show(context);
        checkoutrequested = false;
        checkoutdatasubmitted = false;
      });
    }

    print("loadValues journeyPlan start");
    setState(() {
      isApiCallProcess = true;
    });
    currentlysyncing = true;
    await getJourneyPlan();
    await getskippedJourneyPlan();
    await getvisitedJourneyPlan();

    await getalljpoutletsdata();

    await distinmeters();
    await Expectedchartvisits();

    setState(() {
      isApiCallProcess = false;
    });

    print("loadValues journeyPlan finish");
  }

  bool isApiCallProcess = false;
  int index;
  bool pressWeek = false;
  bool pressTODAY = true;
  bool pressCustomers = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: onlinemode,
        builder: (context, value, child) {
          return WillPopScope(
            onWillPop: () async => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DashBoard())),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: ProgressHUD(
                inAsyncCall: isApiCallProcess,
                opacity: 0.3,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    toolbarHeight: 50,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DashBoard()));
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Color(0XFF909090),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Journey Plan',
                          style: TextStyle(
                            color: Color(0XFF909090),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        EmpInfo(),
                      ],
                    ),
                    actions: [
                      Container(
                          width: 120,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  if (onlinemode.value) {
                                    nearestoutletindex = null;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MapVeiw()));
                                  }
                                },
                                icon: Icon(
                                  Icons.location_on,
                                  color: Color(0XFF909090),
                                ),
                              ),
                              //
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 19,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OverAllJourneyPlanPage()));
                                  },
                                  child: Text(
                                    'Over All',
                                    style: TextStyle(
                                      color: Color(0XFFE84201),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),

                  /// THE BELOW CODE IS OF OLD DESIGN APP BAR WHICH IS REPLACED WITH THE ABOVE NEW DESIGN CODE.
                  //   appBar: AppBar(
                  //     centerTitle: false,
                  //     backgroundColor: containerscolor,                                                                                    //     /* automaticallyImplyLeading: false,
                  // leading: GestureDetector(
                  //     onTap: () {
                  //       Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (BuildContext context) => DashBoard()));
                  //     },
                  //     child: Icon(
                  //       CupertinoIcons.back,
                  //       size: 30,
                  //     )),*/
                  //     iconTheme: IconThemeData(color: orange),
                  //     title: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 AppConstants.journey_plan,
                  //                 style: TextStyle(color: orange),
                  //               ),
                  //               EmpInfo()
                  //             ],
                  //           ),
                  //           // SizedBox(width: 5,),

                  //           IconButton(
                  //               onPressed: () async {
                  //                 createlog("map view tapped", "true");
                  //                 if (onlinemode.value) {
                  //                   nearestoutletindex = null;
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                           builder: (BuildContext context) =>
                  //                               MapVeiw()));
                  //                   // Navigator.push(
                  //                   //     context,
                  //                   //     MaterialPageRoute(
                  //                   //         builder: (BuildContext context) =>
                  //                   //             OrderTrackingPage()));
                  //                 }
                  //               },
                  //               icon: Icon(CupertinoIcons.location_solid,
                  //                   color: orange, size: 25)),
                  //           // GestureDetector(
                  //           //   onTap: () {
                  //           //     createlog("map view tapped", "true");
                  //           //     if (onlinemode.value) {
                  //           //       nearestoutletindex = null;
                  //           //       Navigator.push(
                  //           //           context,
                  //           //           MaterialPageRoute(
                  //           //               builder: (BuildContext context) =>
                  //           //                   MapVeiw()));
                  //           //     }
                  //           //   },
                  //           //   child: Container(
                  //           //     margin: EdgeInsets.only(right: 10.00),
                  //           //     padding: EdgeInsets.all(10.0),
                  //           //     decoration: BoxDecoration(
                  //           //       color: onlinemode.value ? orange : iconscolor,
                  //           //       borderRadius: BorderRadius.circular(10.00),
                  //           //     ),
                  //           //     child: Row(
                  //           //       children: [
                  //           //         Icon(
                  //           //           CupertinoIcons.location_solid,
                  //           //           size: 15,
                  //           //           color: Colors.white,
                  //           //         ),
                  //           //         SizedBox(
                  //           //           width: 5,
                  //           //         ),
                  //           //         Text(
                  //           //           AppConstants.map,
                  //           //           style:
                  //           //           TextStyle(fontSize: 15, color: Colors.white),
                  //           //         ),
                  //           //       ],
                  //           //     ),
                  //           //   ),
                  //           // ),
                  //           GestureDetector(
                  //             onTap: () async {
                  //               // await saveDataIntoDB("haii", todayjp_table);
                  //               // showMyDialog();
                  //               // showUploadDDialog= true;
                  //               Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (BuildContext context) =>
                  //                           OverAllJourneyPlanPage()));
                  //             },
                  //             child: Container(
                  //               margin: EdgeInsets.only(right: 0.00),
                  //               padding: EdgeInsets.all(10.0),
                  //               decoration: BoxDecoration(
                  //                 color: onlinemode.value ? orange : iconscolor,
                  //                 borderRadius: BorderRadius.circular(10.00),
                  //               ),
                  //               child: Row(
                  //                 children: [
                  //                   Text(
                  //                     "Over All",
                  //                     style: TextStyle(
                  //                         fontSize: 15, color: Colors.white),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),

                  //   ),
                  // drawer: GestureDetector(
                  //   onTap: () {
                  //     // createlog("Menu tapped","true");
                  //   },
                  //   child: Drawer(
                  //     child: MerchandiserDrawer(),
                  //   ),
                  // ),
                  // drawer: Drawer(
                  //   child: Menu(),
                  // ),
                  body: Stack(
                    children: [
                      BackGround(),
                      OfflineNotification(
                        body: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: onlinemode.value ? 0 : 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    createlog(
                                        "Today's Journey Plan tapped", "true");
                                    setState(() {
                                      pressTODAY = true;
                                      pressCustomers = false;
                                      pressWeek = false;
                                    });
                                  },
                                  child: JourneyPlanHeader(
                                    icon: Icons.calendar_today,
                                    chartext: "Today's\nJourney Plan",
                                    textcolor: pressTODAY == true
                                        ? Colors.white
                                        : Color(0XFF909090),
                                    containercolor: pressTODAY == true
                                        ? Color(0XFFE84201)
                                        : Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    createlog(
                                        "Week's Journey Plan tapped", "true");
                                    setState(() {
                                      pressTODAY = false;
                                      pressCustomers = false;
                                      pressWeek = true;
                                      isApiCallProcess = true;
                                    });
                                    await getJourneyPlanweekly();
                                    await getSkipJourneyPlanweekly();
                                    await getVisitJourneyPlanweekly();
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                  },
                                  child: JourneyPlanHeader(
                                    icon: Icons.calendar_today_outlined,
                                    chartext: "Week's\nJounery Plan",
                                    textcolor: pressWeek == true
                                        ? Colors.white
                                        : Color(0XFF909090),
                                    containercolor: pressWeek == true
                                        ? Color(0XFFE84201)
                                        : Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    createlog("My Customers tapped", "true");
                                    setState(() {
                                      pressTODAY = false;
                                      pressCustomers = true;
                                      pressWeek = false;
                                    });
                                  },
                                  child: JourneyPlanHeader(
                                    icon: Icons.group,
                                    chartext: "My\nCustomers",
                                    textcolor: pressCustomers == true
                                        ? Colors.white
                                        : Color(0XFF909090),
                                    containercolor: pressCustomers == true
                                        ? Color(0XFFE84201)
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            /*SizedBox(height: 10.0),
                        Text("Checkin is only available for Today Planned Journey Plan only",style: TextStyle(fontSize: 10,color:iconscolor),),*/
                            Expanded(
                              child: DefaultTabController(
                                length: 3, // length of tabs
                                initialIndex: 0,
                                child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  appBar: PreferredSize(
                                    preferredSize:
                                        Size.fromHeight(kToolbarHeight),
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white,
                                      ),
                                      child: TabBar(
                                        labelColor: Color(0XFFE84201),
                                        unselectedLabelColor: Color(0XFF909090),
                                        indicatorColor: Color(0XFFE84201),
                                        labelPadding: EdgeInsets.zero,
                                        tabs: [
                                          Tab(text: AppConstants.PLANNED),
                                          Tab(text: AppConstants.YET_TO_VISIT),
                                          Tab(text: AppConstants.VISITED),
                                        ],
                                      ),
                                    ),
                                  ),
                                  body: TabBarView(children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            child: pressTODAY == true
                                                ? JourneyListBuilder()
                                                : pressWeek == true
                                                    ? WeeklyJourneyListBuilder()
                                                    : Center(
                                                        child: Text(
                                                        AppConstants
                                                            .today_monthly_plan,
                                                      )))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            child: pressTODAY == true
                                                ? SkipedJourneyListBuilder()
                                                : pressWeek == true
                                                    ? WeeklySkipJourneyListBuilder()
                                                    : Center(
                                                        child: Text(
                                                        AppConstants.today_plan,
                                                      )))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            child: pressTODAY == true
                                                ? visitedJourneyListBuilder()
                                                : pressWeek == true
                                                    ? WeeklyVisitJourneyListBuilder()
                                                    : Center(
                                                        child: Text(
                                                        AppConstants.today_plan,
                                                      )))
                                      ],
                                    ),
                                  ]),
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
          );
        });
  }
}

class JourneyPlanHeader extends StatelessWidget {
  JourneyPlanHeader(
      {this.chartext, this.icon, this.textcolor, this.containercolor});

  final chartext;
  final icon;
  final textcolor;
  final containercolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 3.5,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: containercolor),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textcolor,
              size: icon == Icons.group ? 21 : 18,
            ),
            SizedBox(
              width: icon == Icons.group ? 6 : 5,
            ),
            Text(
              chartext,
              // textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 12,
                color: textcolor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//List<String>journeydone=[];

class JourneyListBuilder extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<JourneyListBuilder> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return gettodayjp.storenames.length == 0
        ? Center(
            child: Text(
            AppConstants.no_active_plan,
            textAlign: TextAlign.center,
          ))
        : ListView.builder(
            itemCount: gettodayjp.storenames.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  from = "journey";
                  print("schecduled");
                  print('The index of the outlet from JP is : $index');
                  print(gettodayjp.isscheduled[index]);
                  createlog("Outlet from JP tapped", "true");
                  print("planned click...${gettodayjp.status[index]}");
                  currentoutletindex = index;
                  print(
                      'The currentoutletindex from JP is : $currentoutletindex');
                  if (gettodayjp.status[index] == 'done') {
                    print('go1');
                    var data = await outletwhencheckin();
                    print("dataaaa....$data");

                    if (data == false || data == null) {
                      print('go2');
                      if (onlinemode.value) {
                        print('go3');
                        //  Navigator.of(context).pop(false);
                        // print("check44");
                        Flushbar(
                          message: AppConstants.sync_msg,
                          duration: Duration(seconds: 3),
                        )..show(context);
                        // return false;
                      }
                    } else {
                      print('go4');
                      print("entered if");
                      print("JP Check in:${gettodayjp.checkintime[index]}");
                      print("JP Check out:${gettodayjp.checkouttime[index]}");
                      // showDialog(
                      //     context: context,
                      //     builder: (_) =>
                      //         StatefulBuilder(builder: (context, setState) {
                      //           return ProgressHUD(
                      //               inAsyncCall: isApiCallProcess,
                      //               opacity: 0.3,
                      //               child: AlertDialog(
                      //                 backgroundColor: alertboxcolor,
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.all(
                      //                         Radius.circular(10.0))),
                      //                 content: Builder(
                      //                   builder: (context) {
                      //                     // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      //                     return Container(
                      //                       child: SizedBox(
                      //                         child: Column(
                      //                           mainAxisSize: MainAxisSize.min,
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           children: [
                      //                             Text(
                      //                               AppConstants.alert,
                      //                               style: TextStyle(
                      //                                   fontSize: 16,
                      //                                   fontWeight:
                      //                                       FontWeight.bold),
                      //                             ),
                      //                             Text(AppConstants.split_shift,
                      //                                 style: TextStyle(
                      //                                     fontSize: 13.6)),
                      //                             SizedBox(
                      //                               height: 10.00,
                      //                             ),
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .center,
                      //                               children: [
                      //                                 GestureDetector(
                      //                                   onTap: () async {
                      //                                     print("check445");

                      //                                     createlog(
                      //                                         "Split Shift checked in tapped",
                      //                                         "true");

                      //                                     // if(onlinemode.value){
                      //                                     jptimecal = true;
                      //                                     currentoutletid =
                      //                                         gettodayjp
                      //                                                 .outletids[
                      //                                             index];
                      //                                     currenttimesheetid =
                      //                                         gettodayjp
                      //                                             .id[index];
                      //                                     var currenttime =
                      //                                         DateTime.now();
                      //                                     print(
                      //                                         "TIMEE...$currenttime");
                      //                                     // splitbreak.type ="Split Shift";
                      //                                     splitbreak
                      //                                         .citime = DateFormat(
                      //                                             'HH:mm:ss')
                      //                                         .format(
                      //                                             currenttime);
                      //                                     splitbreak.cotime =
                      //                                         "";
                      //                                     splitbreak.jtimeid =
                      //                                         "";
                      //                                     outletrequestdata
                      //                                             .outletidpressed =
                      //                                         currentoutletid;
                      //                                     setState(() {
                      //                                       isApiCallProcess =
                      //                                           true;
                      //                                     });

                      //                                     await merchbreak();

                      //                                     outletselectedfordetails =
                      //                                         index;
                      //                                     await outletwhencheckin();

                      //                                     setState(() {
                      //                                       isApiCallProcess =
                      //                                           false;
                      //                                     });
                      //                                     Navigator.push(
                      //                                         context,
                      //                                         MaterialPageRoute(
                      //                                             builder: (BuildContext
                      //                                                     context) =>
                      //                                                 CustomerActivities()));
                      //                                   },
                      //                                   child: Container(
                      //                                     height: 40,
                      //                                     width: 70,
                      //                                     decoration:
                      //                                         BoxDecoration(
                      //                                       color: orange,
                      //                                       borderRadius:
                      //                                           BorderRadius
                      //                                               .circular(
                      //                                                   5),
                      //                                     ),
                      //                                     margin:
                      //                                         EdgeInsets.only(
                      //                                             right: 10.00),
                      //                                     child: Center(
                      //                                         child: Text(
                      //                                             AppConstants
                      //                                                 .YES)),
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //               ));
                      //         }));
                      // THE ABOVE CODE IS TEMPORARILY COMMENTED OUT SO AS TO DISABLE SPLIT SHIFT MESSAGE AND FUNCTIONALITY
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CustomerActivities()));
                    }
                  } else {
                    // navigateToOutletDetails(index);
                    print("entered pending");
                    createlog("Outlet from JP tapped", "true");

                    setState(() {
                      isApiCallProcess = true;
                    });
                    outletrequestdata.outletidpressed =
                        gettodayjp.outletids[index];
                    checkinoutdata.checkid = gettodayjp.id[index];
                    currenttimesheetid = gettodayjp.id[index];
                    currentoutletid = gettodayjp.outletids[index];
                    print("check1");
                    var data = await outletwhencheckin();
                    print("check21....$data");
                    if (data == false) {
                      print("check31");
                    }
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (data != null && data != false) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              // ignore: non_constant_identifier_names
                              builder: (BuildContextcontext) => OutLet()));
                    } else {
                      if (onlinemode.value) {
                        print("check41");
                        Flushbar(
                          message: AppConstants.sync_msg,
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                      setState(() {
                        isApiCallProcess = false;
                      });
                    }
                    print(checkinoutdata.checkid);
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '[${gettodayjp.storecodes[index]}] ${gettodayjp.storenames[index]}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                gettodayjp.isscheduled[index] == 0
                                    ? Text(
                                        AppConstants.unscheduled,
                                        style: TextStyle(
                                            fontSize: 13.0, color: orange),
                                      )
                                    : SizedBox(),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //     right: 8.0,
                                //   ),
                                //   child: IconButton(
                                //     icon: Icon(Icons.chevron_right_sharp),
                                //     onPressed: () async {
                                //       await Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               // ignore: non_constant_identifier_names
                                //               builder:
                                //                   (BuildContextcontext) =>
                                //                       OutLet()));
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text('${gettodayjp.outletarea[index]}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0XFF909090),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('${gettodayjp.outletcity[index]}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0XFF909090),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('${gettodayjp.outletcountry[index]}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0XFF909090),
                                    )),
                              ],
                            ),
                          ),
                          Spacer(),
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
                                    color: Color(0XFF1EC2C1),
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
                                  '${gettodayjp.contactnumbers[index]}',
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
                                    color: Color(0XFF5589EA),
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
                                  '${gettodayjp.distanceinmeters.length > index ? gettodayjp.distanceinmeters[index].toStringAsFixed(2) : 0.0}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF909090),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 1.0),
                      //   child: IconButton(
                      //       onPressed: () async {
                      //         // print($index);
                      //         await Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 // ignore: non_constant_identifier_names
                      //                 builder: (BuildContextcontext) =>
                      //                     OutLet()));
                      // print("entered pending");
                      // createlog("Outlet from JP tapped", "true");

                      // setState(() {
                      //   isApiCallProcess = true;
                      // });
                      // outletrequestdata.outletidpressed =
                      //     gettodayjp.outletids[index];
                      // checkinoutdata.checkid = gettodayjp.id[index];
                      // currenttimesheetid = gettodayjp.id[index];
                      // currentoutletid = gettodayjp.outletids[index];
                      // print("check1");
                      // var data = await outletwhencheckin();
                      // print("check21....$data");
                      // if (data == false) {
                      //   print("check31");
                      // }
                      // setState(() {
                      //   isApiCallProcess = false;
                      // });
                      // if (data != null && data != false) {
                      //   await Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           // ignore: non_constant_identifier_names
                      //           builder: (BuildContextcontext) =>
                      //               OutLet()));
                      // }
                      // },
                      // icon: Icon(Icons.chevron_right_sharp)),
                      // Icon(Icons.chevron_right_sharp),

                      //   ),
                      //   ],
                      // ),
                      gettodayjp.status[index] == AppConstants.done
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.check_circle_outline_sharp,
                                color: Colors.green,
                                size: 20,
                              ))
                          : SizedBox(),
                    ],
                  ),
                ),
              );
            });
  }
}

syncnowjourneyplan(context) async {
  if (onlinemode.value) {
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
                                    AppConstants.refreshing,
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

    progress.value = 30;
    currentlysyncing = true;
    await syncingreferencedata();
    progress.value = 100;
    currentlysyncing = false;
    dispose.value = true;
    await distinmeters();
    Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => JourneyPlanPage()));
  } else {
    Flushbar(
      message: AppConstants.make_sure_internet,
      duration: Duration(seconds: 3),
    );
  }
}
