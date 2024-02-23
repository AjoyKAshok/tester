import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Customers%20Activities.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/outletdetailes.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import '../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/utils/background.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Maps_Veiw.dart';

import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/jpskiped.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/jpvisited.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/weeklyjpwidgets/weeklyjp.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/weeklyjpwidgets/weeklyskipjp.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/weeklyjpwidgets/weeklyvisitjp.dart';
import 'package:merchandising/offlinedata/syncdata.dart';
import '../api/api_service2.dart';
import 'package:merchandising/offlinedata/syncreferenceapi.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:merchandising/model/distanceinmeters.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/competition_details.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/FMapi/nbl_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/jpskippedapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/JPvisitedapi.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpskipped.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpvisited.dart';
import 'package:merchandising/api/empdetailsapi.dart';
import 'package:merchandising/model/database.dart';
import 'package:merchandising/api/HRapi/empdetailsforreportapi.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';



class OverAllJourneyPlanPage extends StatefulWidget {
  @override
  _OverAllJourneyPlanPageState createState() => _OverAllJourneyPlanPageState();
}

class _OverAllJourneyPlanPageState extends State<OverAllJourneyPlanPage> {
  bool isApiCallProcess = false;
  int index;
  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";
  FocusNode focusNode = FocusNode();
  List<dynamic> _filterList;
  List<dynamic> InputList;
  DateTime Startdate = DateTime.now();
  DateTime tomoroww = DateTime.now();
  @override
  void initState() {
    super.initState();

    loadValues();

  }
  @override
  void dispose() {
    _searchview.dispose();
    super.dispose();
  }

  loadValues()
  async {

    setState(() {
      isApiCallProcess = true;
    });
    await  getOverAllJourneyPlan();
    setState(() {
      InputList=getoveralljp.date;
    });
    setState(() {
      _firstSearch = false;
      _query = "${"${Startdate.toLocal()}".split(' ')[0]}";
    });
    setState(() {
      isApiCallProcess = false;
    });
  }



  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: tomoroww,
      firstDate: DateTime(2015, 8),
      lastDate: tomoroww,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: orange,
              onPrimary: Colors.white,
              surface: orange,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null )
      {
        setState(() {
          Startdate = picked;
          print("Startdate....${"${Startdate.toLocal()}".split(' ')[0]}");
        });
        setState(() {
          _firstSearch = false;
          _query = "${"${Startdate.toLocal()}".split(' ')[0]}";
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return
      ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child:  Scaffold(
          appBar: PreferredSize(
            
            preferredSize: Size(MediaQuery.of(context).size.width , 40+height),
            // centerTitle: false,
            // backgroundColor: containerscolor,
            /* automaticallyImplyLeading: false,
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => DashBoard()));
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      size: 30,
                    )),*/
            // iconTheme: IconThemeData(color: orange),
            // title:
            // Transform.translate(
            //   offset: Offset(-30.0, 0.0),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child:
            //
            //   ),
            // ),
            child:    Container(
              color: containerscolor,
              margin: EdgeInsets.only(top: height),
              alignment: AlignmentDirectional.center,
              child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      size: 30,
                      color: orange,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppConstants.over_all_journey_plan,

                        style: TextStyle(color: orange,fontSize: 15),
                      ),
                      EmpInfo()
                    ],
                  ),
                  Spacer(),
                  // SizedBox(width: 10,),
                  // IconButton(
                  //     onPressed: () async {
                  //       if (onlinemode.value) {
                  //         print(onlinemode.value);
                  //         syncnowjourneyplan(context);
                  //       } else if (onlinemode.value == false) {
                  //         print(onlinemode.value);
                  //         Flushbar(
                  //           message: AppConstants.internet_to_refresh,
                  //           duration: Duration(seconds: 3),
                  //         )..show(context);
                  //       }
                  //     },
                  //     icon: Icon(CupertinoIcons.refresh_circled_solid,
                  //         color: orange, size: 30)),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 0.00),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: onlinemode.value ? orange : iconscolor,
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.calendar_today,
                            size: 15,
                            color: Colors.white,
                          ),

                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${Startdate.toLocal()}".split(' ')[0],
                            style:
                            TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
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

                    /*SizedBox(height: 10.0),
                        Text("Checkin is only available for Today Planned Journey Plan only",style: TextStyle(fontSize: 10,color:iconscolor),),*/
                    Expanded(
                      child:
                      Scaffold(
                        backgroundColor: Colors.transparent,

                        body:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // _createSearchView(),
                            Expanded(child:_firstSearch ? _uiSetup(context):_performSearch())
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _createSearchView() {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10,top: 0,bottom: 15,right: 10),
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            // width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Row(

              children: [
                Expanded(
                  child: new TextField(
                    style: TextStyle(color: orange),
                    controller: _searchview,
                    cursorColor: orange,
                    onChanged: (value){
                      if (value.trim().isEmpty) {
                        setState(() {
                          _firstSearch = true;
                          _query = "";

                        });

                        print("empty");
                      } else {
                        setState(() {
                          _firstSearch = false;
                          _query = _searchview.text;
                        });

                      }
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      focusColor: orange,
                      hintText: 'Search by Store Name',
                      hintStyle: TextStyle(color: orange),
                      border: InputBorder.none,
                      icon: Icon(
                        CupertinoIcons.search,
                        color: orange,
                      ),

                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      _searchview.clear();

                      Future.delayed(Duration(seconds: 4), () {
                        setState(() {
                          _firstSearch = true;
                          _query = "";
                        });
                      });
                      Future.delayed(Duration(seconds: 7), (){
                        setState(() {
                          isApiCallProcess = false;
                        });
                      });
                    },
                    child: Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: orange,
                    )),

              ],
            ),
          ),
        ),
        // IconButton(
        //   iconSize: 30,
        //   icon: Icon(Icons.calendar_today_outlined),
        //   onPressed: () {},
        // ),
      ],
    )
   ;
  }

  Widget _performSearch() {
    _filterList = [];
    for (int i = 0; i < getoveralljp.id.length; i++) {
      var item = InputList[i];
      if (item.trim().contains(_query.toString().trim())) {
        _filterList.add(getoveralljp.id[i]);
      }
    }
    return _createFilteredListView();
  }
  Widget  _createFilteredListView() {
    return _filterList.length == 0
        ? Center(
        child: Text(
          AppConstants.no_active_plan,
          textAlign: TextAlign.center,
        ))
        : ListView.builder(
        itemCount: _filterList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {

              from = "overall";


              print("planned click...${getoveralljp.status[getoveralljp.id.indexOf(
                  _filterList[index])] }");
              currentoutletindex = index;
              if (getoveralljp.status[getoveralljp.id.indexOf(
                  _filterList[index])] == 'done') {
                print('go1');
                var data = await outletOverAllJpWhencheckin(getoveralljp.outletids[getoveralljp.id.indexOf(
                    _filterList[index])].toString());
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
                }
                else {
                  print('go4');
                  print("entered if");
                  // print("JP Check in:${getoveralljp.checkintime[index]}");
                  // print("JP Check out:${getoveralljp.checkouttime[index]}");
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
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppConstants.alert,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(AppConstants.split_shift,
                                                  style: TextStyle(
                                                      fontSize: 13.6)),
                                              SizedBox(
                                                height: 10.00,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      print("check445");
                                                      // var data = await outletwhencheckin();
                                                      //  Navigator.of(context, rootNavigator: true).pop();
                                                      //if(Text(data!=null?data:'default value'){

                                                      createlog(
                                                          "Split Shift checked in tapped",
                                                          "true");

                                                      // if(onlinemode.value){
                                                      // jptimecal = true;
                                                      currentoutletid =
                                                          getoveralljp.outletids[getoveralljp.id.indexOf(
                                                              _filterList[index])];
                                                      currenttimesheetid =
                                                      _filterList[index];
                                                      var currenttime =
                                                      DateTime.now();
                                                      // splitbreak.type ="Split Shift";
                                                      splitbreak
                                                          .citime = DateFormat(
                                                          'HH:mm:ss')
                                                          .format(
                                                          currenttime);
                                                      splitbreak.cotime =
                                                      "";
                                                      splitbreak.jtimeid =
                                                      "";
                                                      outletrequestdata
                                                          .outletidpressed =
                                                          currentoutletid;
                                                      setState(() {
                                                        isApiCallProcess =
                                                        true;
                                                      });

                                                      //  await NBLdetailsoffline();
                                                      // await  PromoDetailsoffline();
                                                      // await  CheckListDetailsoffline();
                                                      // await VisibilityDetailsoffline();
                                                      // await  PlanoDetailsoffline();
                                                      // await SOSDetailsoffline();
                                                      //  await availabilityDetailsoffline();

//testing
                                                      //getTaskList();
                                                      // getVisibility();
                                                      //getPlanogram();
                                                      //getPromotionDetails();

                                                      // getShareofshelf();

                                                      //getNBLdetails();

                                                      await merchbreak();
                                                      // await getTotalJnyTime();
                                                      outletselectedfordetails =
                                                          index;
                                                      await outletOverAllJpWhencheckin(getoveralljp.outletids[getoveralljp.id.indexOf(
                                                          _filterList[index])].toString());
                                                      ///testing
//                                                           await NBLdetailsoffline();
//                                                           await  PromoDetailsoffline();
//                                                           await  CheckListDetailsoffline();
                                                      setState(() {
                                                        isApiCallProcess =
                                                        false;
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                              context) =>
                                                                  CustomerActivities()));
                                                      /* }else{
                                                              Flushbar(
                                                                message:
                                                                "Active internet required",
                                                                duration: Duration(
                                                                    seconds: 3),
                                                              )..show(context);
                                                            }*/
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
                                                          right: 10.00),
                                                      child: Center(
                                                          child: Text(
                                                              AppConstants
                                                                  .YES)),
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
              }
              else {
                print("entered else");
                createlog("Outlet from JP tapped", "true");

                setState(() {
                  isApiCallProcess = true;
                });
                outletrequestdata.outletidpressed =
                getoveralljp.outletids[getoveralljp.id.indexOf(
                    _filterList[index])];
                checkinoutdata.checkid = getoveralljp.id[getoveralljp.id.indexOf(
                    _filterList[index])];
                currenttimesheetid = getoveralljp.id[getoveralljp.id.indexOf(
                    _filterList[index])];
                currentoutletid = getoveralljp.outletids[getoveralljp.id.indexOf(
                    _filterList[index])];
                print("check1");
                var data = await outletOverAllJpWhencheckin(getoveralljp.outletids[getoveralljp.id.indexOf(
                    _filterList[index])].toString());
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
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              '[${getoveralljp.storecodes[
                              getoveralljp.id.indexOf(
                                  _filterList[index])]??""}] ${getoveralljp.storenames[
                              getoveralljp.id.indexOf(
                                  _filterList[index])]??""}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            // getoveralljp.isscheduled[index] == 0
                            //     ? Text(
                            //   AppConstants.unscheduled,
                            //   style: TextStyle(
                            //       fontSize: 13.0, color: orange),
                            // )
                            //     : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('${getoveralljp.outletarea[
                            getoveralljp.id.indexOf(
                                _filterList[index])]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${getoveralljp.outletcity[
                            getoveralljp.id.indexOf(
                                _filterList[index])]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${getoveralljp.outletcountry[
                            getoveralljp.id.indexOf(
                                _filterList[index])]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ),
                      Spacer(),
                      Table(
                        children: [
                          TableRow(children: [
                            Text(AppConstants.contact_number,
                                style: TextStyle(
                                  fontSize: 13.0,
                                )),
                            Text('${getoveralljp.contactnumbers[
                            getoveralljp.id.indexOf(
                                _filterList[index])]??"0"}',
                                style: TextStyle(color: orange)),
                          ]),
                          // TableRow(children: [
                          //   Text(AppConstants.distance,
                          //       style: TextStyle(
                          //         fontSize: 13.0,
                          //       )),
                          //   // Row(
                          //   //   children: [
                          //   //     Text(
                          //   //         '${getoveralljp.distanceinmeters.length>index?getoveralljp.distanceinmeters[index].toStringAsFixed(2):0.0}',
                          //   //         style: TextStyle(color: orange)),
                          //   //     Text(AppConstants.KM,
                          //   //         style: TextStyle(color: orange))
                          //   //   ],
                          //   // ),
                          // ]),
                        ],
                      ),
                    ],
                  ),
                  getoveralljp.status[getoveralljp.id.indexOf(
                      _filterList[index])] == AppConstants.done
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

  Widget _uiSetup(BuildContext context) {
    return getoveralljp.storenames.length == 0
        ? Center(
        child: Text(
          AppConstants.no_active_plan,
          textAlign: TextAlign.center,
        ))
        : ListView.builder(
        itemCount: getoveralljp.storenames.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {


            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              '[${getoveralljp.storecodes[index]??""}] ${getoveralljp.storenames[index]??""}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            // getoveralljp.isscheduled[index] == 0
                            //     ? Text(
                            //   AppConstants.unscheduled,
                            //   style: TextStyle(
                            //       fontSize: 13.0, color: orange),
                            // )
                            //     : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('${getoveralljp.outletarea[index]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${getoveralljp.outletcity[index]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${getoveralljp.outletcountry[index]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ),
                      Spacer(),
                      Table(
                        children: [
                          TableRow(children: [
                            Text(AppConstants.contact_number,
                                style: TextStyle(
                                  fontSize: 13.0,
                                )),
                            Text('${getoveralljp.contactnumbers[index]??"0"}',
                                style: TextStyle(color: orange)),
                          ]),
                          // TableRow(children: [
                          //   Text(AppConstants.distance,
                          //       style: TextStyle(
                          //         fontSize: 13.0,
                          //       )),
                          //   // Row(
                          //   //   children: [
                          //   //     Text(
                          //   //         '${getoveralljp.distanceinmeters.length>index?getoveralljp.distanceinmeters[index].toStringAsFixed(2):0.0}',
                          //   //         style: TextStyle(color: orange)),
                          //   //     Text(AppConstants.KM,
                          //   //         style: TextStyle(color: orange))
                          //   //   ],
                          //   // ),
                          // ]),
                        ],
                      ),
                    ],
                  ),
                  getoveralljp.status[index] == AppConstants.done
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
            Icon(icon, color: textcolor,size: icon==Icons.group?21:18,),
            SizedBox(
              width: icon==Icons.group?6:5,
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




