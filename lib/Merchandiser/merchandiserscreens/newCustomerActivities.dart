import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Promotion%20Check.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/checkin.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/checklist.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/refill_details.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/FMapi/nbl_detailsapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/model/database.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/offlinedata/syncsendapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:provider/provider.dart';

import '../../ConstantMethods.dart';
import '../../model/Location_service.dart';
import '../../network/NetworkStatusService.dart';
import 'CompetitionCheckOne.dart';
import 'NewJourneyPlan.dart';
import 'Visibility.dart';
import 'availabitiy.dart';
import 'expiry_report.dart';
import 'merchdash.dart';
import 'outletdetailes.dart';
import 'planogram1.dart';
import 'shareofshelf.dart';

List<bool> CheckList = [];
String newfrom;
List<String> CheckListItems = task.list;

FocusNode focusNode = FocusNode();
String hintText = 'Search by Product Name / ZREP code';
List<String> InputList = defaulflist;

//Visibility values
List<TextEditingController> _filtergareatextfeild = [];
List<TextEditingController> _filtermainaisletextfeild = [];
List<TextEditingController> _filterpoistextfeild = [];

//Share of shelf
GlobalKey<FormState> soskey = GlobalKey<FormState>();
List<String> productlist = ShareData.categoryname;
String clientName = DBrequestdata.client;
List<String> target = ShareData.target;
List<String> productdata;

bool isApicallProcess = false;
//loadPlanogramValues
List<String> planolist = PlanoDetails.categoryname;
var _searchview = new TextEditingController();
bool _firstSearch = true;
String _query = "";
List<String> _filterList;
List<int> _filterindex;
bool connection = false;
// loadPromotionValues
List<String> productname = [];
bool isSwitched = false;
var selectedproduct;

class NewCustomerActivities extends StatefulWidget {
  @override
  _NewCustomerActivitiesState createState() => _NewCustomerActivitiesState();
}

class _NewCustomerActivitiesState extends State<NewCustomerActivities>
    with WidgetsBindingObserver {
  // 15 seconds

  // void startInactivityTimer() {
  //   _inactivityTimer = Timer(Duration(seconds: inactivityDuration), reRoute);
  // }

  // void resetInactivityTimer() {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Flushbar(
  //       message: 'Refreshed the Customer Activities Page...',
  //       duration: Duration(seconds: 5),
  //     )..show(context);
  //     checkoutrequested = false;
  //     checkoutdatasubmitted = false;
  //   });
  //   _inactivityTimer?.cancel();
  //   // startInactivityTimer();
  // }

  // void reRoute() {
  //   // print('Working Id from reRoute : $workingid');
  //   // for (int u = 0; u < gettodayjp.status.length; u++) {
  //   //   if (gettodayjp.status[u] == AppConstants.working) {
  //   //     workingid = await gettodayjp.id[u];
  //   //   }
  //   // }
  //   // print('Working Id fetched: $workingid');
  //   // print("current outlet id - UNFINISHED OUTLET: $currentoutletid");
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => NewCustomerActivities()));
  // }
  showAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text("Please Note"),
        content: const Text(
          "The Check Out Feature will be available only within a 300 Meter radius of the store...\n \n Please Check Out only after completing all activities in the store...",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(14),
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This function will be called after the first frame is rendered
     showAlert();
    });

      loadValue();
    loadAvailabilityValues();
    loadVisibilityValues();
    // loadShareOfShelfValues();
    // loadPlanogramValues();
    // loadPromotionValues();
    // loadCompetitionValue();
    loadExpiryReportValues();
    // loadUploadLivePhotoValues();
    loadRefillData();

    // print(
    //     'The Status of Current Outlet${gettodayjp.status[currentoutletindex]}');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// COMMENTED OUT TO RESOLVE THE ISSUE OF NAVIGATING TO LAST CHECKED IN OUTLET.
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       _inactivityTimer =
  //           Timer(Duration(seconds: inactivityDuration), reRoute);
  //       break;
  //     case AppLifecycleState.resumed:
  //       resetInactivityTimer();
  //       break;
  //     case AppLifecycleState.inactive:
  //       print('App Incactive');
  //       break;
  //     case AppLifecycleState.detached:
  //       break;
  //   }
  // }

  loadRefillData() async {
    await getRefillDetails();
  }

  loadValue() async {
    CreateLog("Navigated to Activities pages", "true");
    await currentpagestatus('2', '${currentoutletid}', '${currenttimesheetid}',
        '${currentoutletindex}');
    print('Details Printed: $checkinrequested  - $checkindatasubmitted');
    gettodayjp.status[currentoutletindex] = 'working';
    if (checkinrequested && checkindatasubmitted) {
      Future.delayed(const Duration(seconds: 1), () {
        Flushbar(
          message: "Checkin Updated",
          duration: Duration(seconds: 5),
        )..show(context);
        checkinrequested = false;
        checkindatasubmitted = false;
      });
       
    } else if (checkinrequested && !checkindatasubmitted) {
      Future.delayed(const Duration(seconds: 2), () {
        Flushbar(
          message: "Error While Updating Checkin Please Try again.",
          duration: Duration(seconds: 5),
        )..show(context);
      });
      checkinrequested = false;
      checkindatasubmitted = false;
    }
    setState(() {
      isApiCallProcess = true;
    });
    await getNBLdetails();

    setState(() {
      isApiCallProcess = false;
    });
  }

  loadAvailabilityValues() async {
    print("seleccted cat..$Selectedcategory");
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          hintText = '';
        });
      } else {
        setState(() {
          hintText = 'Search by Product Name / ZREP code';
        });
      }
    });

    setState(() {
      ontapavailrefresh = true;
      isApiCallProcess = true;
    });

    await getAvaiablitity();
    setState(() {
      defaulflist = Avaiablity.fullname;
      InputList = defaulflist;
      print("defaulflist lenght...${defaulflist.length}");
      print("InputList lenght...${InputList.length}");
      print("checkValue lenght...${Avaiablity.checkvalue.length}");

      Selectedcategory = null;
      Selectedbrand = null;
      isApiCallProcess = false;
    });
  }

  loadVisibilityValues() async {
    _filtergareatextfeild = [];
    _filtermainaisletextfeild = [];
    _filterpoistextfeild = [];

    gareatextfeild = [];
    mainaisletextfeild = [];
    poistextfeild = [];
    setState(() {
      isApiCallProcess = true;
    });
    await getVisibility();
    checkvaluevisibility = [];
    visibilityreasons = [];
    dropdownreasons = [];
    imagereasons = [];
    for (int i = 0; i < VisibilityData.productname.length; i++) {
      images.add(File('dummy.txt'));
      visibilityreasons.add('');
      dropdownreasons.add('');
      imagereasons.add('');
      checkvaluevisibility.add(1);
    }
    print(images.length);
    setState(() {
      listitems = VisibilityData.categoryname;
    });
    // listitems.sort();
    setState(() {
      isApiCallProcess = false;
    });
  }

  loadShareOfShelfValues() async {
    setState(() {
      isApicallProcess = true;
    });
    actualpercent = [];
    totalshare = [];

    await getShareofshelf();

    setState(() {
      target = ShareData.target;
      productlist = ShareData.categoryname;
      productdata = productlist;
      // productdata.sort();
      isApicallProcess = false;
    });
  }

  loadPlanogramValues() async {
    setState(() {
      isApicallProcess = true;
    });
    await getPlanogramDetails();

    setState(() {
      planolist = PlanoDetails.categoryname;
      productdata = planolist;
      // productdata.sort();
      isApicallProcess = false;
    });
    beforeimages = [];
    afterimages = [];
    beforeimagesencode = [];
    afterimagesencode = [];
    for (int i = 0; i < PlanoDetails.brandname.length; i++) {
      beforeimages.add(File('dummy.txt'));
      afterimages.add(File('dummy.txt'));
      beforeimagesencode.add('dummy.txt');
      afterimagesencode.add('dummy.txt');
    }
    print(
        "before image length..${beforeimages.length}...${PlanoDetails.categoryname.length}");
  }

  loadPromotionValues() async {
    setState(() {
      isApiCallProcess = true;
    });
    isSwitched = false;
    capturedimagepromotion = File('dummy.txt');
    selectedproduct = null;
    if (productname.isNotEmpty) {
      print("its not empty");
      productname.clear();
    }
    print("capturedimagepromotion....$capturedimagepromotion");
    await getPromotionDetails();

    setState(() {
      productname = PromoData.productname.toSet().toList();
      isApiCallProcess = false;
    });
    print("PRODUCT NAME...$productname");
  }

  loadCompetitionValue() async {
    itemname.clear();
    promtdescp.clear();
    mrp.clear();
    sellingprice.clear();
    company.clear();
    category.clear();
    promotiontype.clear();
    promodscrptn.clear();
    capturedimage = File('dummy.txt');
    compcheck = false;
    imagesbytes = null;
    imagesbytes = null;
    await SaveCompetitionData();
  }

  loadExpiryReportValues() {
    UOMValue = "PIECE";
    catName = null;
    var productname = "Select from the above";
    packtype = 'Regular';
    selectedproduct = null;
    showDrop = false;
    ENDdate = tomoroww;
    remarks.clear();
    categoryController.clear();
    productcontroller.clear();
  }

  loadUploadLivePhotoValues() async {
    setState(() {
      CheckList = [];
      // imagescl=[];
      // encodeimagecl=[];
    });

    setState(() {
      isApicallProcess = true;
    });
    await getTaskList();
    print("tasklist lenfth...${task.list.length}");
    imagescl = [];
    encodeimagecl = [];
    for (int i = 0; i < task.list.length; i++) {
      CheckList.add(false);
      print("length....${CheckList[i]}..${CheckList.length}");
      imagescl.add(File('dummy.txt'));
      encodeimagecl.add('dummy.txt');
    }
    setState(() {
      isApicallProcess = false;
    });
  }

  Offset count = Offset(20.0, 20.0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: onlinemode,
        builder: (context, value, child) {
          return WillPopScope(
            onWillPop: () async => false,
            child: ProgressHUD(
              opacity: 0.3,
              color: orange,
              inAsyncCall: isApiCallProcess,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 50,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  // iconTheme: IconThemeData(color: orange),
                  // leading: IconButton(
                  //   onPressed: () {
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 JourneyPlanPage()));
                  //   },
                  //   icon: const Icon(Icons.arrow_back),
                  //   color: Color(0XFF909090),
                  // ),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Activities',
                            style: TextStyle(color: orange),
                          ),
                          EmpInfo()
                        ],
                      ),
                      Spacer(),
                      checkoutbutton(),
                    ],
                  ),
                ),
                // drawer: Drawer(
                //   child: Menu(),
                // ),
                body: OfflineNotification(
                  body: Stack(
                    children: [
                      BackGround(),
                      // showAlert(),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: onlinemode.value ? 0 : 25,
                            ),
                            OutletDetails(),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(5.00),
                              decoration: BoxDecoration(
                                  // color: pink,
                                  color: orange,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10)),
                              child: Text(
                                'Check Out Feature will not be available beyond 300 Meter Radius from the Store... \n\n Ensure All Activities in the store are completed before Check Out...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(18.0),
                            //   child: Container(
                            //     height: 60,
                            //     width: MediaQuery.of(context).size.width,
                            //     child: Text(
                            //         'Check Out Option will be available only within a 300 Meter Radius of the Store...'),
                            //   ),
                            // ),

                            /// COMMENTED OUT THE BELOW CODE TO REMOVE THE TILES AS THEY ARE NOT REQUIRED AT THIS POINT OF TIME. HAS TO  ADD THEM BACK ONCE ALL THE FUNCTIONALITIES ARE PROPERLY CHECKED.
                            ///
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Activities(
                                      /* completedicon: CupertinoIcons.check_mark_circled_solid,
                                    iconcolor: avaliabilitycheck ? Colors.green : pink,*/
                                      icon: CupertinoIcons.chart_bar_alt_fill,
                                      chartext: 'Availability',
                                      tap: () async {
                                        print(
                                            'The Status of Current Outlet : ${gettodayjp.status[currentoutletindex]}');
                                        /*print("online mode:${onlinemode.value}");
                                      if(onlinemode.value){
                                      print(Avaiablity.productname);
                                        reasons = [];
                                        outofStockitems = [];
                                      for (int i = 0;
                                          i < Avaiablity.productname.length;
                                          i++) {
                                        reasons.add('');
                                        outofStockitems.add(1);
                                      }*/

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return AvailabilityScreen();
                                            },
                                          ),
                                          //  (Route<dynamic> route) => false,
                                        );
                                        /*}
                                      else {
                                        Flushbar(
                                          message: "Make sure you had an active internet\nto access Availability",
                                          duration: Duration(seconds: 3),
                                        );
                                      }*/
                                      }),
                                ),
                                // DBrequestdata.client == 'COCA' ? SizedBox() : Activities(
                                //   /*completedicon:
                                //       CupertinoIcons.check_mark_circled_solid,
                                //   iconcolor:
                                //       visibilitycheck ? Colors.green : pink,*/
                                //   icon: CupertinoIcons.eye_solid,
                                //   chartext: 'Visibility',
                                //   tap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) {
                                //           return VisibilityOne("customer");
                                //         },
                                //       ),
                                //       // (Route<dynamic> route) => false,
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                            // DBrequestdata.client == 'COCA' ? SizedBox() : Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     // Activities(
                            //     //   /*completedicon:
                            //     //       CupertinoIcons.check_mark_circled_solid,
                            //     //   iconcolor:
                            //     //       shareofshelfcheck ? Colors.green : pink,*/
                            //     //   icon: Icons.table_chart_sharp,
                            //     //   chartext: 'Share of Shelf',
                            //     //   tap: () {
                            //     //     Navigator.of(context).push(
                            //     //       MaterialPageRoute(
                            //     //         builder: (context) {
                            //     //           return ShareShelf();
                            //     //         },
                            //     //       ),
                            //     //       // (Route<dynamic> route) => false,
                            //     //     );
                            //     //   },
                            //     // ),
                            //     Activities(
                            //       /*completedicon:
                            //           CupertinoIcons.check_mark_circled_solid,
                            //       iconcolor: expirycheck ? Colors.green : pink,*/
                            //       icon: CupertinoIcons.calendar_badge_minus,
                            //       chartext: 'Products Expiry Info',
                            //       tap: () {
                            //         // addedproductname.clear();
                            //         // addedexpirydate.clear();
                            //         // addedpriceperitem.clear();
                            //         // addeditemscount.clear();
                            //         // addedexposurequnatity.clear();
                            //         // addedproductid.clear();
                            //         // addedremarks.clear();
                            //         // addedproductlocation.clear();
                            //         // addedcustomerstore.clear();
                            //         // addeduom.clear();
                            //         // addedproductlocation = [];
                            //         // addedcustomerstore = [];
                            //         // addeduom = [];
                            //         // addcatname = [];
                            //         getAvaiablitity();
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (context) {
                            //               return ExpiryReport();
                            //             },
                            //           ),
                            //           //(Route<dynamic> route) => false,
                            //         );
                            //       },
                            //     ),
                            //     Activities(
                            //       /* completedicon:
                            //           CupertinoIcons.check_mark_circled_solid,
                            //       iconcolor: planocheck ? Colors.green : pink,*/
                            //       icon: CupertinoIcons.doc_checkmark_fill,
                            //       chartext: 'Planogram',
                            //       tap: () {
                            //         /*beforeimages = [];
                            //           afterimages = [];
                            //           beforeimagesencode = [];
                            //           afterimagesencode = [];*/

                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (context) {
                            //               return Planogram1("customer");
                            //             },
                            //           ),
                            //           // (Route<dynamic> route) => false,
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
                            // DBrequestdata.client == 'COCA' ? SizedBox() : Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Activities(
                            //       /*completedicon:
                            //           CupertinoIcons.check_mark_circled_solid,
                            //       iconcolor:
                            //           shareofshelfcheck ? Colors.green : pink,*/
                            //       icon: Icons.table_chart_sharp,
                            //       chartext: 'Share of Shelf',
                            //       tap: () {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (context) {
                            //               return ShareShelf();
                            //             },
                            //           ),
                            //           // (Route<dynamic> route) => false,
                            //         );
                            //       },
                            //     ),
                            //     Activities(
                            //       /* completedicon:
                            //           CupertinoIcons.check_mark_circled_solid,
                            //       iconcolor: checklist ? Colors.green : pink,*/
                            //       icon: CupertinoIcons.text_badge_checkmark,
                            //       chartext: 'CheckList',
                            //       tap: () {
                            //         print(task.list.length);
                            //         // if (0 == 0) {
                            //         setState(() {
                            //           changecheckoutcolor = false;
                            //         });
                            //         /*CheckList = [];
                            //           imagescl = [];
                            //           encodeimagecl = [];*/

                            //         // for (int i = 0; i < task.list.length; i++) {
                            //         //   print("length....$i");
                            //         //   CheckList.add(false);
                            //         //   imagescl.add(File('dummy.txt'));
                            //         //   encodeimagecl.add('dummy.txt');
                            //         // }
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (BuildContext context) =>
                            //                     UploadLivePhoto("customer")));
                            //         // }
                            //       },
                            //     ),
                            //   ],
                            // ),
                            // DBrequestdata.client == 'COCA' ? SizedBox() : Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Activities(
                            //       /*completedicon:CupertinoIcons.check_mark_circled_solid,
                            //       iconcolor: promocheck ? Colors.green : pink,*/
                            //       icon: CupertinoIcons.checkmark_seal_fill,
                            //       chartext: 'Promotion Check',
                            //       tap: () {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (context) {
                            //               return PromotionCheck("customer");
                            //             },
                            //           ),
                            //           //(Route<dynamic> route) => false,
                            //         );
                            //       },
                            //     ),
                            //     Activities(
                            //       /* completedicon:
                            //           CupertinoIcons.check_mark_circled_solid,
                            //       iconcolor: compcheck ? Colors.green : pink,*/
                            //       chartext: 'Compitetor info Capture',
                            //       icon: CupertinoIcons.info_circle_fill,
                            //       tap: () {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (context) {
                            //               return CompetitionCheckOne(
                            //                   "customer");
                            //             },
                            //           ),
                            //           //  (Route<dynamic> route) => false,
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     // Activities(
                            //     //   /*completedicon:
                            //     //       CupertinoIcons.check_mark_circled_solid,
                            //     //   iconcolor: expirycheck ? Colors.green : pink,*/
                            //     //   icon: CupertinoIcons.calendar_badge_minus,
                            //     //   chartext: 'Products Expiry Info',
                            //     //   tap: () {
                            //     //     // addedproductname.clear();
                            //     //     // addedexpirydate.clear();
                            //     //     // addedpriceperitem.clear();
                            //     //     // addeditemscount.clear();
                            //     //     // addedexposurequnatity.clear();
                            //     //     // addedproductid.clear();
                            //     //     // addedremarks.clear();
                            //     //     // addedproductlocation.clear();
                            //     //     // addedcustomerstore.clear();
                            //     //     // addeduom.clear();
                            //     //     // addedproductlocation = [];
                            //     //     // addedcustomerstore = [];
                            //     //     // addeduom = [];
                            //     //     // addcatname = [];
                            //     //     getAvaiablitity();
                            //     //     Navigator.of(context).push(
                            //     //       MaterialPageRoute(
                            //     //         builder: (context) {
                            //     //           return ExpiryReport();
                            //     //         },
                            //     //       ),
                            //     //       //(Route<dynamic> route) => false,
                            //     //     );
                            //     //   },
                            //     // ),
                            //     // Activities(
                            //     //   /* completedicon:
                            //     //       CupertinoIcons.check_mark_circled_solid,
                            //     //   iconcolor: checklist ? Colors.green : pink,*/
                            //     //   icon: CupertinoIcons.text_badge_checkmark,
                            //     //   chartext: 'CheckList',
                            //     //   tap: () {
                            //     //     print(task.list.length);
                            //     //     // if (0 == 0) {
                            //     //     setState(() {
                            //     //       changecheckoutcolor = false;
                            //     //     });
                            //     //     /*CheckList = [];
                            //     //       imagescl = [];
                            //     //       encodeimagecl = [];*/

                            //     //     // for (int i = 0; i < task.list.length; i++) {
                            //     //     //   print("length....$i");
                            //     //     //   CheckList.add(false);
                            //     //     //   imagescl.add(File('dummy.txt'));
                            //     //     //   encodeimagecl.add('dummy.txt');
                            //     //     // }
                            //     //     Navigator.push(
                            //     //         context,
                            //     //         MaterialPageRoute(
                            //     //             builder: (BuildContext context) =>
                            //     //                 UploadLivePhoto("customer")));
                            //     //     // }
                            //     //   },
                            //     // ),
                            //   ],
                            // ),

                            /// THE CODE FOR ADDING REFILL DETAILS TILE. FOR THE TIME BEING WE ARE COMMENTING OUT THE REFILL DETAILS PART SO AS TO MEET REQUIREMENTS SENT OUT BY RISHI ON 24/OCT/2023
                            // DBrequestdata.client == 'COCA'
                            // ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Activities(
                                    /*completedicon:
                                        CupertinoIcons.check_mark_circled_solid,
                                    iconcolor: expirycheck ? Colors.green : pink,*/
                                    icon: CupertinoIcons.bag_badge_plus,
                                    chartext: 'Stock Check Details',
                                    tap: () {
                                      print(
                                          'The Status of All Outlets : ${gettodayjp.status}');
                                      getAvaiablitity();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return RefillDetails();
                                          },
                                        ),
                                        //(Route<dynamic> route) => false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                            //     : SizedBox(),
                          ],
                        ),
                      ),
                      // NBlFloatingButton(),
                      /*SafeArea(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: ()async{
                              checkin();
                              var breakends = DateTime.now();
                              print(breakends);
                              splitbreak.citime=checkinoutdata.checkintime;
                              splitbreak.cotime=DateFormat('HH:mm:ss').format(breakends);
                              splitbreak.type="Break";
                              splitbreak.jtimeid="";
                              // splitbreak.jtimeid=jtimeidco;
                              setState(() {
                                isApiCallProcess=true;
                              });
                              await merchbreak();
                              setState(() {
                                isApiCallProcess=false;
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BreakTime(
                                          )));
                            },
                            child: Container(
                                decoration: BoxDecoration(color: pink,
                                    borderRadius: BorderRadius.circular(10.0)),
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.all(10.0),
                                child: Text("BREAK",style: TextStyle(color: Colors.black),)),
                          ),
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

bool iseverythingchecked = false;
bool changecheckoutcolor = false;

class Activities extends StatelessWidget {
  Activities(
      {this.icon, this.chartext, this.tap, this.completedicon, this.iconcolor});

  final icon;
  final chartext;
  final tap;
  final completedicon;
  final iconcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.15,
        margin: EdgeInsets.only(left: 5, bottom: 10, right: 5),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(completedicon, color: iconcolor, size: 20.0),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(icon, size: 50.0, color: Color(0xff424B4D)),
                    Text(
                      chartext,
                      style: TextStyle(fontSize: 13),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

bool isApiCallProcess = false;

bool Availability = false;

bool Visibility = false;

bool ShareofShelf = false;

bool Planogram = false;

bool compitetorcheck = false;
bool promotion = false;
bool expiryinfo = false;
bool checklist = false;

class checkoutbutton extends StatefulWidget {
  @override
  _checkoutbuttonState createState() => _checkoutbuttonState();
}

class _checkoutbuttonState extends State<checkoutbutton> {
  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<NetworkStatusService>(context);

    if (networkStatus.online == true) {
      setState(() {
        connection = true;
      });
    } else {
      connection = false;
    }

    return GestureDetector(
      onTap: () async {
        if (connection) {
          print("App online");
          print("checkout Button clicked");
          print("printed");
          print("currentouletid:");
          print("${currentoutletindex}");
          print(
              'Check In Location from Checkout Button: ${checkinoutdata.checkinlocation}');
          getLocation();
          address();
          SubmitCheckout();
          outletwhencheckout();
          print(
              'Check out Location from Checkout Button: ${checkinoutdata.checkoutlocation}');
          print(
              'The Current Distance from the store location is : ${chekinoutlet.currentdistance}');
          // setState(() {
          //   Availability = false;
          //   Visibility = false;
          //   ShareofShelf = false;
          //   Planogram = false;
          //   promotion = false;
          //   compitetorcheck = false;
          //   expiryinfo = false;
          // });

          /// ENFORCING CHECK OUT WITHIN 400 METER RADIUS OF THE STORE
          // if (chekinoutlet.currentdistance > 400) {
          //   showDialog(
          //       context: context,
          //       builder: (_) =>
          //           StatefulBuilder(builder: (dialogContext, setState) {
          //             return ProgressHUD(
          //                 inAsyncCall: isApiCallProcess,
          //                 opacity: 0.3,
          //                 child: AlertDialog(
          //                   backgroundColor: alertboxcolor,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(10.0))),
          //                   content: Builder(
          //                     builder: (context) {
          //                       // Get available height and width of the build area of this widget. Make a choice depending on the size.
          //                       return Container(
          //                         child: SizedBox(
          //                           child: Column(
          //                             mainAxisSize: MainAxisSize.min,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                 "Wrong Location !!!",
          //                                 style: TextStyle(
          //                                     fontSize: 16,
          //                                     fontWeight: FontWeight.bold),
          //                               ),
          //                               Text(
          //                                   "\n \nIt seems that you are not at the store location.\nPlease try again when you are in the store...\n \n Please Check Out only after completing all activities in the store...",
          //                                   style: TextStyle(fontSize: 13.6)),
          //                               SizedBox(
          //                                 height: 10.00,
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.center,
          //                                 children: [
          //                                   GestureDetector(
          //                                     onTap: () {
          //                                       Navigator.pop(
          //                                           context,
          //                                           MaterialPageRoute(
          //                                               builder: (BuildContext
          //                                                       context) =>
          //                                                   NewCustomerActivities()));
          //                                     },
          //                                     child: Container(
          //                                       height: 40,
          //                                       width: 70,
          //                                       decoration: BoxDecoration(
          //                                         color: Color(0xffAEB7B5),
          //                                         borderRadius:
          //                                             BorderRadius.circular(5),
          //                                       ),
          //                                       margin: EdgeInsets.only(
          //                                           right: 10.00),
          //                                       child:
          //                                           Center(child: Text("OK")),
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 ));
          //           }));
          // } else {
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
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Checking Out',
                                    style:
                                        TextStyle(color: orange, fontSize: 20),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       Availability == false
                                  //           ? Availability = true
                                  //           : Availability = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(
                                  //             AppConstants.availability,
                                  //             style: TextStyle(fontSize: 16),
                                  //           ),
                                  //           Spacer(),
                                  //           Icon(
                                  //             Availability == true
                                  //                 ? CupertinoIcons
                                  //                     .check_mark_circled_solid
                                  //                 : CupertinoIcons
                                  //                     .xmark_circle_fill,
                                  //             color: Availability == true
                                  //                 ? orange
                                  //                 : Colors.grey,
                                  //             size: 30,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       Visibility == false
                                  //           ? Visibility = true
                                  //           : Visibility = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(AppConstants.visibility,
                                  //               style: TextStyle(fontSize: 16)),
                                  //           Spacer(),
                                  //           Icon(
                                  //               Visibility == true
                                  //                   ? CupertinoIcons
                                  //                       .check_mark_circled_solid
                                  //                   : CupertinoIcons
                                  //                       .xmark_circle_fill,
                                  //               color: Visibility == true
                                  //                   ? orange
                                  //                   : Colors.grey,
                                  //               size: 30),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       ShareofShelf == false
                                  //           ? ShareofShelf = true
                                  //           : ShareofShelf = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(AppConstants.share_of_shelf,
                                  //               style: TextStyle(fontSize: 16)),
                                  //           Spacer(),
                                  //           Icon(
                                  //               ShareofShelf == true
                                  //                   ? CupertinoIcons
                                  //                       .check_mark_circled_solid
                                  //                   : CupertinoIcons
                                  //                       .xmark_circle_fill,
                                  //               color: ShareofShelf == true
                                  //                   ? orange
                                  //                   : Colors.grey,
                                  //               size: 30),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       Planogram == false
                                  //           ? Planogram = true
                                  //           : Planogram = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(AppConstants.planogram,
                                  //               style: TextStyle(fontSize: 16)),
                                  //           Spacer(),
                                  //           Icon(
                                  //               Planogram == true
                                  //                   ? CupertinoIcons
                                  //                       .check_mark_circled_solid
                                  //                   : CupertinoIcons
                                  //                       .xmark_circle_fill,
                                  //               color: Planogram == true
                                  //                   ? orange
                                  //                   : Colors.grey,
                                  //               size: 30),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       promotion == false
                                  //           ? promotion = true
                                  //           : promotion = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(AppConstants.promotion_check,
                                  //               style: TextStyle(fontSize: 16)),
                                  //           Spacer(),
                                  //           Icon(
                                  //               promotion == true
                                  //                   ? CupertinoIcons
                                  //                       .check_mark_circled_solid
                                  //                   : CupertinoIcons
                                  //                       .xmark_circle_fill,
                                  //               color: promotion == true
                                  //                   ? orange
                                  //                   : Colors.grey,
                                  //               size: 30),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       compitetorcheck == false
                                  //           ? compitetorcheck = true
                                  //           : compitetorcheck = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(
                                  //               AppConstants
                                  //                   .compitetor_info_capture,
                                  //               style: TextStyle(fontSize: 16)),
                                  //           Spacer(),
                                  //           Icon(
                                  //               compitetorcheck == true
                                  //                   ? CupertinoIcons
                                  //                       .check_mark_circled_solid
                                  //                   : CupertinoIcons
                                  //                       .xmark_circle_fill,
                                  //               color: compitetorcheck == true
                                  //                   ? orange
                                  //                   : Colors.grey,
                                  //               size: 30),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       expiryinfo == false
                                  //           ? expiryinfo = true
                                  //           : expiryinfo = false;
                                  //     });
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(AppConstants.expiry_info,
                                  //               style: TextStyle(fontSize: 16)),
                                  //           Spacer(),
                                  //           Icon(
                                  //               expiryinfo == true
                                  //                   ? CupertinoIcons
                                  //                       .check_mark_circled_solid
                                  //                   : CupertinoIcons
                                  //                       .xmark_circle_fill,
                                  //               color: expiryinfo == true
                                  //                   ? orange
                                  //                   : Colors.grey,
                                  //               size: 30),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isApiCallProcess = true;
                                          });
                                          print(gettodayjp.status);
                                          print("check1");

                                          // // THE BELOW ONE LINE OF CODE IS WRITTEN SO THAT THE OUTLET SURVEY BOX IS CLOSED AS SOON AS OK IS CLICKED. THIS IS JUST FOR TESTING....
                                          // Navigator.of(context).pop();
                                          // Availability == true
                                          //     ? OutletSurveySubmit.availability =
                                          //         1
                                          //     : OutletSurveySubmit.availability =
                                          //         0;
                                          // Visibility == true
                                          //     ? OutletSurveySubmit.visibility = 1
                                          //     : OutletSurveySubmit.visibility = 0;
                                          // ShareofShelf == true
                                          //     ? OutletSurveySubmit.sos = 1
                                          //     : OutletSurveySubmit.sos = 0;
                                          // Planogram == true
                                          //     ? OutletSurveySubmit.planogram = 1
                                          //     : OutletSurveySubmit.planogram = 0;
                                          // compitetorcheck == true
                                          //     ? OutletSurveySubmit.competitor = 1
                                          //     : OutletSurveySubmit.competitor = 0;
                                          // promotion == true
                                          //     ? OutletSurveySubmit
                                          //         .promotioncheck = 1
                                          //     : OutletSurveySubmit
                                          //         .promotioncheck = 0;
                                          // expiryinfo == true
                                          //     ? OutletSurveySubmit.stockexpiry = 1
                                          //     : OutletSurveySubmit.stockexpiry =
                                          //         0;
                                          print("check2");

                                          print("currentoutletindex");
                                          print(currentoutletindex);
                                          if (newfrom == "overall"
                                              ? getoveralljp.status[
                                                      currentoutletindex] ==
                                                  "done"
                                              : gettodayjp.status[
                                                      currentoutletindex] ==
                                                  "done") {
                                            print("if from checkout");
                                            // if(onlinemode.value){

                                            //  THE FUNCTION OUTLETSURVEY IS NOT REQUIRED AS ITS JUST SAVING IF WE HAVE SELECTED THE OPTION ON CHECKOUT

                                            // outletsurvey();
                                            print("check3");
                                            // await getTotalJnyTime();
                                            var timeofsci = DateTime.now();
                                            splitbreak.type = "Split Shift";
                                            // splitbreak.citime = "";
                                            splitbreak.cotime =
                                                DateFormat('HH:mm:ss')
                                                    .format(timeofsci);
                                            // splitbreak.jtimeid = "";
                                            await merchbreak();
                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                            regularcheckout = true;
                                            createlog(
                                                "Split Shift checked out tapped",
                                                "true");
                                            avaliabilitycheck = false;
                                            visibilitycheck = false;
                                            shareofshelfcheck = false;
                                            planocheck = false;
                                            await newCheckout();
                                            await RemoveCompetitionData();

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        NewJourneyPlanPage()));
                                            /*}else{
                                        Flushbar(
                                          message:
                                          "Active internet is required",
                                          duration: Duration(
                                              seconds: 3),
                                        )..show(context);
                                      }*/
                                          } else {
                                            print("else from checkout");
                                            // await  outletsurvey();
                                            print(
                                                'The Working id while checking out: $workingidnew');
                                            workingidnew != null
                                                ? workingidnew = null
                                                : workingidnew = workingidnew;
                                            // print(
                                            //     'Place to show alertbox with option to navigate to Journey Plan Page');
                                            // _showConfirmationDialog();

                                            // THE BELOW CODE IS COMMENTED OUT SO AS TO CHECK THE WORKING OF THE  ALERT DIALOG BOX. HAS TO UNCOMMENT ONCE THE FUNCTIONING IS VERIFIED.
                                            await newCheckout();
                                            // COMMENTED OUT TO CHECK IF THE FEATURE IS REQUIRED OR NOT. 18 FEB 2024
                                            // if (onlinemode.value) {
                                            //   print(
                                            //       "smtpExampleCheckinCheckout...online");
                                            //   ////testing 08/11/2022
                                            //   await smtpExampleCheckinCheckout(
                                            //       'Check Out details for empid ${DBrequestdata.receivedempid}');
                                            // }
                                            newfrom == "overall"
                                                ? getoveralljp.status[
                                                    currentoutletindex] = 'done'
                                                : gettodayjp.status[
                                                        currentoutletindex] =
                                                    'done';
                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                            checkedoutlet.checkoutlet = true;

                                            NBLDetData.fileurl = [];
                                            avaliabilitycheck = false;
                                            visibilitycheck = false;
                                            shareofshelfcheck = false;
                                            planocheck = false;
                                            await RemoveCompetitionData();

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        NewJourneyPlanPage()));

                                            /*print("check10");
                                        todayskipjplist.outletids.removeAt(skippedoutletindex);
                                        todayskipjplist.storenames.removeAt(skippedoutletindex);
                                        todayskipjplist.storecodes.removeAt(skippedoutletindex);
                                        todayskipjplist.outletids.removeAt(skippedoutletindex);
                                        todayskipjplist.outletlat.removeAt(skippedoutletindex);
                                        todayskipjplist.outletlong.removeAt(skippedoutletindex);
                                        todayskipjplist.outletarea.removeAt(skippedoutletindex);
                                        todayskipjplist.outletcity.removeAt(skippedoutletindex);
                                        todayskipjplist.outletcountry.removeAt(skippedoutletindex);
                                        todayskipjplist.id.removeAt(skippedoutletindex);
                                        todayskipjplist.contactnumbers.removeAt(skippedoutletindex);*/

                                          }
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
                                                      color: Colors.white))),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(
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
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                              child: Text(AppConstants.Cancel,
                                                  style: TextStyle(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }));
          // }
        } else {
          Flushbar(
            message: "Internet Connection Required to Checkout",
            duration: Duration(seconds: 10),
          )..show(context);
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.00),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xffFFDBC1),
          borderRadius: BorderRadius.circular(10.00),
        ),
        child: Text(
          AppConstants.Check_out,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  newCheckout() async {
    createlog("Check Out tapped", "true");
    if (onlinemode.value) {
      try {
        await getLocation();
        await address();
        var now = DateTime.now();
        checkinoutdata.checkouttime = DateFormat('HH:mm:ss').format(now);
        checkinoutdata.checkoutlocation =
            "${getaddress.currentaddress}($lat,$long)";
        await checkout();
      } catch (e) {
        createlog("address issue at online mode : ", "false");
        var now = DateTime.now();
        checkinoutdata.checkouttime = DateFormat('HH:mm:ss').format(now);
        checkinoutdata.checkoutlocation =
            "unable to get address in online mode";
        await checkout();
      }
    } else {
      var now = DateTime.now();
      checkinoutdata.checkouttime = DateFormat('HH:mm:ss').format(now);
      checkinoutdata.checkoutlocation = "offline unable to get location";
      await checkout();
    }
  }

  Future<void> checkout1() async {
    http.Client client = http.Client();
    http.Response cicoresponse;
    checkoutrequested = true;
    var checkid = currenttimesheetid;
    var checkouttime = checkinoutdata.checkouttime;
    // THE VALUE IS CHANGED TO CHECK IF HARDCODING THE LOCATION CAN SOLVE THE DELAY IN CHECK OUT...
    // var checkoutlocation = checkinoutdata.checkoutlocation;
    var checkoutlocation =
        "Sector, Dubai, United Arab Emirates(25.171166,55.4246143)";
    Map checkinoutresponse = {
      "id": "$checkid",
      "checkout_time": "$checkouttime",
      "checkout_location": "$checkoutlocation",
    };

    print("checkout...$checkinoutresponse");
    print(
        'Checking the Check in time while checking out : ${checkinoutdata.checkintime}');
    print(
        'Checking the Check out time while checking out : ${checkinoutdata.checkouttime}');

    try {
      // http.Response cicoresponse = await http.post(
      //   CICOurl,
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Accept': 'application/json',
      //     'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      //   },
      //   body: jsonEncode(checkinoutresponse),
      // );

      // CONVERTED THE ABOVE CODE TO STREAM RESPONSE IN ORDER TO CANCEL THE API CALL IN BETWEEN. - BUT STILL NOT ABLE TO CANCEL THE API CALL...

      final request = http.Request('POST', CheckOutUrl);
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      });
      request.body = jsonEncode(checkinoutresponse);

      final streamedResponse = await client.send(request);

      cicoresponse = await http.Response.fromStream(streamedResponse);

      /// REMOVE TILL HERE IN CASE TO REVERT BACK TO ORIGINAL VERSION...

      if (cicoresponse.statusCode == 200) {
        print("online...checkout");
        print(cicoresponse.body);
        checkoutdatasubmitted = true;
        DBRequestdaily();
        DBRequestmonthly();
      } else {
        print(cicoresponse.body);
        checkoutdatasubmitted = false;
      }

      //  TEST CODE - TRYING IF WE CAN IMPLEMENT API CANCEL ON CANCEL BUTTON
      // THE DIALOG TO MOVE TO ANOTHER PAGE IS COMMENTED OUT...
      // await Future.delayed(Duration(seconds: 1));
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Checkout Timeout !!!'),
      //       content: Text(
      //           'The checkout operation is taking too long. Do you want to continue waiting or cancel and move to another page?'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             // Navigator.of(context).pop(); // Close the dialog
      //             Navigator.of(context).pushReplacement(
      //               MaterialPageRoute(
      //                   builder: (context) => CustomerActivities()),
      //             );
      //           },
      //           child: Text('Wait'),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             // print('The status code is ${cicoresponse.statusCode}');

      //             Navigator.of(context).pop();

      //             // Close the dialog
      //             // Navigate to a particular page when checkout is canceled
      //             Navigator.of(context).pushReplacement(
      //               MaterialPageRoute(builder: (context) => JourneyPlanPage()),
      //             );

      //             client.close();
      //           },
      //           child: Text('Move to Journey Plans'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } on SocketException catch (_) {
      print("offline checkout");
      adddataforsync(
          "https://rms2.rhapsody.ae/api/check-out",
          jsonEncode(checkinoutresponse),
          "Checkout at $checkouttime for the timesheet $checkid at $checkoutlocation");
      CreateLog(
          "checked out $checkouttime for the timesheet $checkid at $checkoutlocation",
          "true");
      gettodayjp.isscheduled[currentoutletindex] == 1
          ? DBResponsedatadaily.ShedulevisitssDone++
          : DBResponsedatadaily.UnShedulevisitsDone++;
      gettodayjp.isscheduled[currentoutletindex] == 1
          ? DBResponsedatamonthly.ShedulevisitssDone++
          : DBResponsedatamonthly.UnShedulevisitsDone++;
      checkoutdatasubmitted = true;
    } finally {
      client.close();
    }

    // .timeout(Duration(seconds: 0));
    // Timer(Duration(seconds: 0), () {
    //   // cicoresponse.abort();
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Checkout Timeout !!!'),
    //         content: Text(
    //             'The checkout operation is taking too long. Do you want to continue waiting or cancel and move to another page?'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               // Navigator.of(context).pop(); // Close the dialog
    //               Navigator.of(context).pushReplacement(
    //                 MaterialPageRoute(
    //                     builder: (context) => CustomerActivities()),
    //               );
    //             },
    //             child: Text('Wait'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               print('The status code is ${cicoresponse.statusCode}');

    //               Navigator.of(context).pop();
    //               // Close the dialog
    //               // Navigate to a particular page when checkout is canceled
    //               Navigator.of(context).pushReplacement(
    //                 MaterialPageRoute(
    //                     builder: (context) => JourneyPlanPage()),
    //               );
    //             },
    //             child: Text('Move to Journey Plans'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // });

    // on TimeoutException catch (_) {
    //   // Handle timeout: Show an alert box to the user
    //   print('Time Out Exception Called...');
    //   // BuildContext context;
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Checkout Timeout !!!'),
    //         content: Text(
    //             'The checkout operation is taking too long. Do you want to continue waiting or cancel and move to another page?'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //             },
    //             child: Text('Wait'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //               // Navigate to a particular page when checkout is canceled
    //               Navigator.of(context).pushReplacement(
    //                 MaterialPageRoute(builder: (context) => DashBoard()),
    //               );
    //             },
    //             child: Text('Cancel and Move'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  Future<void> checkoutOption() async {
    checkoutrequested = true;
    var checkid = currenttimesheetid;
    var checkouttime = checkinoutdata.checkouttime;
    var checkoutlocation = checkinoutdata.checkoutlocation;
    Map checkinoutresponse = {
      "id": "$checkid",
      "checkout_time": "$checkouttime",
      "checkout_location": "$checkoutlocation",
    };

    print("checkout...$checkinoutresponse");
    print(
        'Checking the Check in time while checking out : ${checkinoutdata.checkintime}');
    print(
        'Checking the Check out time while checking out : ${checkinoutdata.checkouttime}');
    try {
      http.Response cicoresponse = await http.post(
        CheckOutUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(checkinoutresponse),
      );

      if (cicoresponse.statusCode == 200) {
        print("online...checkout");
        print(cicoresponse.body);
        checkoutdatasubmitted = true;
        DBRequestdaily();
        DBRequestmonthly();
      } else {
        print(cicoresponse.body);
        checkoutdatasubmitted = false;
      }
    } on SocketException catch (_) {
      print("offline checkout");
      adddataforsync(
          "https://rms2.rhapsody.ae/api/check_in_out",
          jsonEncode(checkinoutresponse),
          "Checkout at $checkouttime for the timesheet $checkid at $checkoutlocation");
      CreateLog(
          "checked out $checkouttime for the timesheet $checkid at $checkoutlocation",
          "true");
      gettodayjp.isscheduled[currentoutletindex] == 1
          ? DBResponsedatadaily.ShedulevisitssDone++
          : DBResponsedatadaily.UnShedulevisitsDone++;
      gettodayjp.isscheduled[currentoutletindex] == 1
          ? DBResponsedatamonthly.ShedulevisitssDone++
          : DBResponsedatamonthly.UnShedulevisitsDone++;
      checkoutdatasubmitted = true;
    } finally {
      // After the checkout attempt, navigate to the desired page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NewJourneyPlanPage()),
      );
    }
  }

  Future<void> checkoutTest() async {
    try {
      checkoutrequested = true;
      var checkid = currenttimesheetid;
      var checkouttime = checkinoutdata.checkouttime;
      var checkoutlocation = checkinoutdata.checkoutlocation;
      Map checkinoutresponse = {
        "id": "$checkid",
        "checkout_time": "$checkouttime",
        "checkout_location": "$checkoutlocation",
      };

      print("checkout...$checkinoutresponse");
      print(
          'Checking the Check in time while checking out : ${checkinoutdata.checkintime}');
      print(
          'Checking the Check out time while checking out : ${checkinoutdata.checkouttime}');

      var request = http.MultipartRequest(
        'POST',
        CheckOutUrl,
      );

      // Set headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      });

      // Add the JSON body to the request
      request.fields.addAll(checkinoutresponse);

      // Send the request and get a StreamedResponse
      http.StreamedResponse cicoresponse = await request.send();
      Timer(Duration(seconds: 1), () {
        cicoresponse.stream.timeout(Duration(seconds: 1));
        print('Check Out Cancelled');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NewJourneyPlanPage()),
        );
      });

      // Read the response as a string
      String responseBody = await cicoresponse.stream.bytesToString();

      if (cicoresponse.statusCode == 200) {
        print("online...checkout");
        print(responseBody);
        checkoutdatasubmitted = true;
        DBRequestdaily();
        DBRequestmonthly();
      } else {
        print(responseBody);
        checkoutdatasubmitted = false;
      }
    } on SocketException catch (_) {
      print("offline checkout");
      // adddataforsync(
      //     "https://rms2.rhapsody.ae/api/check_in_out",
      //     jsonEncode(checkinoutresponse),
      //     "Checkout at $checkouttime for the timesheet $checkid at $checkoutlocation");
      // CreateLog(
      //     "checked out $checkouttime for the timesheet $checkid at $checkoutlocation",
      //     "true");
      gettodayjp.isscheduled[currentoutletindex] == 1
          ? DBResponsedatadaily.ShedulevisitssDone++
          : DBResponsedatadaily.UnShedulevisitsDone++;
      gettodayjp.isscheduled[currentoutletindex] == 1
          ? DBResponsedatamonthly.ShedulevisitssDone++
          : DBResponsedatamonthly.UnShedulevisitsDone++;
      checkoutdatasubmitted = true;
    }
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to checkout?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Proceed'),
              onPressed: () async {
                // Perform the API call for checkout here
                // Call the necessary methods or functions
                // Close the dialog
                // Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => NewJourneyPlanPage()),
                );
                await newCheckout();
              },
            ),
          ],
        );
      },
    );
  }
}
