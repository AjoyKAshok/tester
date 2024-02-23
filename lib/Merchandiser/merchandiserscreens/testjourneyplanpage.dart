import 'dart:async';
import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/jpskiped.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/jpvisited.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/testoutlet.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ConstantMethods.dart';
import 'merchdash.dart';
import 'newCustomerActivities.dart';
// import 'newOutletDetails.dart';

List<String> breakspl = [];
bool jptimecal = false;

class TestJourneyPlanPage extends StatefulWidget {
  const TestJourneyPlanPage({ Key key }) : super(key: key);

  @override
  State<TestJourneyPlanPage> createState() => _TestJourneyPlanPageState();
}

class _TestJourneyPlanPageState extends State<TestJourneyPlanPage> {
  Future<bool> checkLoadedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastLoadedDate = prefs.getString('lastLoadedDate') ?? '';

    DateTime today = DateTime.now();
    String todayDate = '${today.year}-${today.month}-${today.day}';

    return lastLoadedDate == todayDate;
  }

  Future<void> saveLoadedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime today = DateTime.now();
    String todayDate = '${today.year}-${today.month}-${today.day}';

    prefs.setString('lastLoadedDate', todayDate);
  }

  @override
  void initState() {
    super.initState();

    loadValues();
  }

  loadValues() async {
    print('Working Id before process: $workingidnew');

  
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
    await distinmeters();
    bool valueLoadedToday = await checkLoadedDate();
    if (!valueLoadedToday) {
      await getalljpoutletsdata();

      // await Expectedchartvisits();
      saveLoadedDate();
    }

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
                    builder: (BuildContext context) => MerchDash())),
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
                                    MerchDash()));
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Color(0XFF909090),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Test Journey Plan',
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
                          width: 80,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                 
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (_) => StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                              backgroundColor: alertboxcolor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              content: Builder(
                                                builder: (context) {
                                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Alert',
                                                        style: TextStyle(
                                                            color: orange,
                                                            fontSize: 20),
                                                      ),
                                                      Divider(
                                                        color: Colors.black,
                                                        thickness: 0.8,
                                                      ),
                                                      Text(
                                                        "We found some activites that are need to sync please sync it and try again",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                           
                                                            Navigator.pop(
                                                                context);
                                                            syncnowjourneyplan(
                                                                context);
                                                           
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: orange,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                                    'Synchronize',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }));
                                },
                                icon: Icon(
                                  Icons.refresh_sharp,
                                  color: Color(0XFF909090),
                                ),
                              ),
                             
                            ],
                          )),
                    ],
                  ),
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

  Future splitShiftMarker(
      dynamic empid, dynamic outletidforsplitshift, dynamic index) async {
    var responseDecoded;
    var errorMsg;

    Map splitShiftBody = {
      "emp_id": empid,
      "outlet_id": outletidforsplitshift,
    };
    print('Outlet Id is : $outletidforsplitshift');
    print('Split Shift Body: $splitShiftBody');
    print(
        'The Time Sheet Id for the Outlet before Split Shift: ${gettodayjp.id[index]}');
    try {
      http.Response Response = await http.post(splitShiftMarkerUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
          },
          body: jsonEncode(splitShiftBody));
      print('Split Shift Response: ${Response.statusCode}');
      if (Response.statusCode == 200) {
        print('Split Shift Marked Successfully...');
        responseDecoded = jsonDecode(Response.body);
        print(
            'Time Sheet Id for the Outlet after Split Shift: ${responseDecoded['data']}');
        currenttimesheetid = responseDecoded['data'];
        print("check445 - Button");

        createlog("Split Shift checked in tapped", "true");

        // if(onlinemode.value){
        jptimecal = true;
        currentoutletid = gettodayjp.outletids[index];

       

        currenttimesheetid = gettodayjp.id[index];
        var currenttime = DateTime.now();
        print("TIMEE...$currenttime");
        // splitbreak.type ="Split Shift";
        splitbreak.citime = DateFormat('HH:mm:ss').format(currenttime);
        splitbreak.cotime = "";
        splitbreak.jtimeid = "";
        // splitbreak
        //         .splitOutlet =
        //     false;
        outletrequestdata.outletidpressed = currentoutletid;
        setState(() {
          isApiCallProcess = true;
        });

        await merchbreak();

        outletselectedfordetails = index;
        await outletwhencheckin();

        setState(() {
          isApiCallProcess = false;
        });

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) => NewOutLet()));
            Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => TestOutletPage()));
      } else {
        responseDecoded = jsonDecode(Response.body);
        print(
            'Error while trying for split shift - Error Code: ${Response.statusCode}');
        errorMsg = responseDecoded['message'];
        // print('Displaying the error message : $errorMsg');
        Fluttertoast.showToast(
            msg: "$errorMsg...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.orange[500],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print('Error in Fetching Version : $e');
    }
  }


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
              print(
                  'The status of outlet at index : $index - ${gettodayjp.status[index]} ');
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    newfrom = "journey";
                    print("schecduled");
                    print('The index of the outlet from JP is : $index');
                    print(gettodayjp.isscheduled[index]);
                    // createlog("Outlet from JP tapped", "true"); IT IS CALLED AGAIN IN PENDING
                    print("planned click...${gettodayjp.status[index]}");
                    currentoutletindex = index;
                    print(
                        'The currentoutletindex from JP is : $currentoutletindex');
                    print(
                        'The status of JP Outlet at index $index : ${gettodayjp.status[index]} ');

                    if (gettodayjp.status[index] == 'done') {
                      //  if (gettodayjp.status[index] == 'pending') {
                      print('go1');
                      var data = await outletwhencheckin();
                      print("dataaaa....$data");

                      splitShiftMarker(DBrequestdata.receivedempid,
                          gettodayjp.outletids[index], index);

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
                      setState(() {
                        callfrequentlytocheck();
                      });

                      /// TRYING TO AVOID THE SQL DATABASE CREATION AND COMPARISION
                      var data = await outletwhencheckin();

                      print("check21....Data : $data");
                      if (data == false) {
                        print("check31");
                      }
                      setState(() {
                        isApiCallProcess = false;
                      });

// print('Split Shift Value : ${gettodayjp.splitOutlet[index]}');
                      /// COMMENTED OUT THE BELOW CODE PORTION TO AVOID THE SYNC MESSAGE ERROR.
                      // if (data != null && data != false) {
                      // await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         // ignore: non_constant_identifier_names
                      //         builder: (BuildContextcontext) => NewOutLet()));
                               await Navigator.push(
                          context,
                          MaterialPageRoute(
                              // ignore: non_constant_identifier_names
                              builder: (BuildContextcontext) => TestOutletPage()));
                     
                      setState(() {
                        isApiCallProcess = false;
                      });
                      // }
                      //  await Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           // ignore: non_constant_identifier_names
                      //           builder: (BuildContextcontext) => NewOutLet()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                //  gettodayjp.splitOutlet[index] == true && gettodayjp.status[index] == 'done' ? Align(
                                // alignment: Alignment.bottomRight,
                                // child: Icon(
                                //   Icons.check_circle_outline_sharp,
                                //   color: Colors.red,
                                //   size: 20,
                                // )) : SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        gettodayjp.status[index] == 'done'
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    height: 20,
                                    width: 70,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          (Color(0XFFE84201)),
                                        ),
                                      ),
                                      onPressed: () async {
                                        splitShiftMarker(
                                            DBrequestdata.receivedempid,
                                            gettodayjp.outletids[index],
                                            index);
                                        // print("check445 - Button");

                                        // createlog("Split Shift checked in tapped",
                                        //     "true");

                                        // // if(onlinemode.value){
                                        // jptimecal = true;
                                        // currentoutletid =
                                        //     gettodayjp.outletids[index];

                                        // /// ADDED AS PART OF SPLIT SHIFT - TO DISPLAY AN ICON TO INDICATE SPLIT SHIT - NEEDS MORE MODIFICATIONS
                                        // // gettodayjp.status[
                                        // //             index] ==
                                        // //         'done'
                                        // //     ? gettodayjp
                                        // //         .splitOutlet
                                        // //         .add(true)
                                        // //     : gettodayjp
                                        // //         .splitOutlet
                                        // //         .add(false);
                                        // // print(
                                        // //     'Split Shit is opted : ${gettodayjp.splitOutlet}');

                                        // // currenttimesheetid = gettodayjp.id[index];
                                        // var currenttime = DateTime.now();
                                        // print("TIMEE...$currenttime");
                                        // // splitbreak.type ="Split Shift";
                                        // splitbreak.citime = DateFormat('HH:mm:ss')
                                        //     .format(currenttime);
                                        // splitbreak.cotime = "";
                                        // splitbreak.jtimeid = "";
                                        // // splitbreak
                                        // //         .splitOutlet =
                                        // //     false;
                                        // outletrequestdata.outletidpressed =
                                        //     currentoutletid;
                                        // setState(() {
                                        //   isApiCallProcess = true;
                                        // });

                                        // await merchbreak();

                                        // outletselectedfordetails = index;
                                        // await outletwhencheckin();

                                        // setState(() {
                                        //   isApiCallProcess = false;
                                        // });
                                        // // Navigator.push(
                                        // //     context,
                                        // //     MaterialPageRoute(
                                        // //         builder: (BuildContext context) =>
                                        // //             NewCustomerActivities()));
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext context) =>
                                        //             NewOutLet()));
                                      },
                                      child: Text(
                                        'Split Shift',
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                    )))
                            : SizedBox(),
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
        barrierDismissible: progress.value == 100 ? true : false,
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
                                    progress.value == 100
                                        ? 'Sychronizing Done'
                                        : 'Synchronizing',
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
                              SizedBox(
                                height: 20,
                              ),
                              progress.value == 100
                                  ? ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          (Color(0XFFE84201)),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        TestJourneyPlanPage()));
                                        // Navigator.pop(context);
                                      },
                                      child: Text('OK'))
                                  : SizedBox(),
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
    // Navigator.pop(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => NewJourneyPlanPage()));
    // Navigator.pop(context);
    // await Navigator.pop(
    //     context,
    //     MaterialPageRoute(
    //         // ignore: non_constant_identifier_names
    //         builder: (BuildContextcontext) => NewJourneyPlanPage()));
    // Flushbar(
    //   message: 'Synchronized...',
    //   duration: Duration(seconds: 3),
    // )..show(context);
    // Navigator.pop(context);
  } else {
    Flushbar(
      message: AppConstants.make_sure_internet,
      duration: Duration(seconds: 3),
    );
  }
}
