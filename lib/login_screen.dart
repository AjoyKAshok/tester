import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchdash.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/model/rememberme.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/utils/background.dart';
import 'api/HRapi/hrdashboardapi.dart';
import 'package:merchandising/api/FMapi/fmdbapi.dart';
import 'api/FMapi/relieverdet_api.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/api/empdetailsapi.dart';
import 'api/HRapi/empdetailsforreportapi.dart';
import 'dart:async';
import 'model/database.dart';
import 'package:merchandising/api/FMapi/storedetailsapi.dart';
import 'offlinedata/syncreferenceapi.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import 'package:merchandising/api/FMapi/week_off_detailsapi.dart';
import 'package:merchandising/api/FMapi/brand_detailsapi.dart';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/api/FMapi/add_brandapi.dart';
import 'package:merchandising/api/FMapi/product_detailsapi.dart';
import 'package:merchandising/api/FMapi/outlet brand mappingapi.dart';
import 'package:merchandising/clients/client_dashboard.dart';
import 'api/clientapi/outletreport.dart';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/jpskippedapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/JPvisitedapi.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpskipped.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpvisited.dart';
import 'package:merchandising/api/cde api/cdedashboard.dart';
import 'api/api_service2.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailinputcontroller = TextEditingController();
  static TextEditingController passwordinputcontroller =
      TextEditingController();
  bool isEmailFocused = false;
  bool isPasswordFocused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailinputcontroller.clear();
    passwordinputcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    /// ProgressHUD is a custom widget created to show loading screen.
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// the below code is because text field will triggered automatically.
        /// with the help of the below line keyboard will show only if textfield got tapped.
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: Theme.of(context).accentColor,
        body: OfflineNotification(
          body: Stack(
            children: [
              BackGround(),
              SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 72),
                        child: Hero(
                          tag: 'logo',
                          child: Image(
                            height: 67,
                            image: AssetImage('images/rmsLogo.png'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 100,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hello!',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF505050),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Welcome Back - New Interface',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF505050),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      margin:
                          EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: transparentwhite,
                      ),
                      child: Form(
                        key: globalFormKey,
                        child: Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              child: Text(
                                'Log into Your Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: emailinputcontroller,
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => !input.contains('@')
                                  ? AppConstants.valid_email_error
                                  : null,
                              cursorColor: grey,
                              onTap: () {
                                setState(() {
                                  isEmailFocused = true;
                                  isPasswordFocused = false;
                                });
                              },
                              decoration: new InputDecoration(
                                prefixIconColor: isEmailFocused
                                    ? Color(0XFFE84201)
                                    : Colors.grey,
                                focusColor: grey,
                                fillColor: Colors.white,
                                filled: true,
                                labelText: AppConstants.email_address,
                                labelStyle: TextStyle(
                                  color: Color(0XFFE84201),
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Color(0XFFE84201),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: isEmailFocused
                                      ? Color(0XFFE84201)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordinputcontroller,
                              validator: (input) => input.length < 6
                                  ? AppConstants.valid_password_error
                                  : null,
                              obscureText: hidePassword,
                              onTap: () {
                                setState(() {
                                  isEmailFocused = false;
                                  isPasswordFocused = true;
                                });
                              },
                              decoration: new InputDecoration(
                                focusColor: grey,
                                fillColor: Colors.white,
                                filled: true,
                                labelText: AppConstants.password,
                                labelStyle: TextStyle(
                                  color: Color(0XFFE84201),
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Color(0XFFE84201),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: isPasswordFocused
                                      ? Color(0XFFE84201)
                                      : Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.4),
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                /// validate and save function will return a bool
                                /// it will for the validation conditions given for the text field.
                                if (onlinemode.value) {
                                  if (validateAndSave()) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });

                                    /// it will tell login api to consider
                                    /// email and password typed in the login page
                                    /// if not login api will try get locally stored email and password.
                                    loginfromloginpage = true;
                                    loginrequestdata.inputemail =
                                        emailinputcontroller.text;
                                    loginrequestdata.inputpassword =
                                        passwordinputcontroller.text;
                                    if (loginrequestdata.inputemail != null &&
                                        loginrequestdata.inputpassword !=
                                            null) {
                                      fromloginscreen = true;
                                      var date = DateTime.now();
                                      var starttime = DateTime.now();

                                      ///this below will make sure to get latest data from online instead
                                      /// of accessing data from local.
                                      currentlysyncing = true;
                                      int userroleid = await loginapi();
                                      currentuser.roleid = userroleid;
                                      print(userroleid);
                                      if (userroleid != null)  {
                                        print("logindetails added");

                                        /// this function will store email and password of the user in local
                                        await addLogindetails();
                                      }
                                      if (userroleid == 6) {
                                        var dBMresult = DBRequestmonthly();
                                        await getJourneyPlan();
                                        // chartvisits();
                                        // Expectedchartvisits();
                                        /// COMMENTED OUT TEMPORARILY. NEED TO ACTIVATE AS PER THE FUNCTIONS REQUIRED.
                                        // getempdetails();
                                        // getallempdetails();                                        
                                        // getempdetailsforreport();
                                        // getskippedJourneyPlan();
                                        // getvisitedJourneyPlan();
                                        // getSkipJourneyPlanweekly();
                                        // getJourneyPlanweekly();
                                        // getVisitJourneyPlanweekly();

                                        // getLocation();
                                        await callfrequentlytocheck();
                                        var dBDresult = await DBRequestdaily();

                                        ///once app is up and running for every 20 minutes we are trying to get reference data.
                                        // const time = const Duration(minutes: 20);
                                        // Timer.periodic(time, (Timer t) => syncingreferencedata());
                                        ///once app is up and running for every 15 minutes we are trying to send sync data.
                                        // const period = const Duration(minutes: 15);
                                        // Timer.periodic(period, (Timer t) => syncingsenddata());
                                        const hat =
                                            const Duration(seconds: 120);

                                        ///once app is up and running for every 2 minutes we are trying to get location and distance.
                                        Timer.periodic(
                                            hat,
                                            (Timer t) =>
                                                callfrequentlytocheck());
                                        var endtime = DateTime.now();
                                        await lastsynced(
                                            date, starttime, endtime);
                                        if (dBMresult != null &&
                                            dBDresult != null) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (buildContext) =>
                                                  MerchDash(),
                                            ),
                                          );
                                        }
                                      }

                                      /// HR role id is 3.
                                      // else if (userroleid == 3) {
                                      //   await getempdetails();
                                      //   int result = await HRdb();
                                      //   if (result != null) {
                                      //     Navigator.pushReplacement(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder:
                                      //                 // ignore: non_constant_identifier_names
                                      //                 (buildContext) =>
                                      //                     HRdashboard()));
                                      //   }
                                      // }

                                      /// field manager role id is 5.
                                      /// CDE's role id is 2.
                                      /// requesting all the data that is required for fm.
                                      else if (userroleid == 5 ||
                                          userroleid == 2) {
                                        getempdetails();
                                        getWeekoffdetails();
                                        getBrandDetails();
                                        getemployeestoaddbrand();
                                        getCategoryDetails();
                                        getmappedoutlets();
                                        getProductDetails();
                                        //getmyattandance();
                                        getallempdetails();
                                        getStoreDetails();
                                        OutletsForClient();
                                        getRelieverDetails();
                                        await getFMoutletdetails();
                                        if (userroleid == 2) {
                                          await merchnamelistunderCDE();
                                          await getCDEdb();
                                        } else {
                                          await getmerchnamelist();
                                          await getFMdb();
                                        }

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (buildContext) =>
                                                    FieldManagerDashBoard()));
                                      }

                                      /// Client role id is 7.
                                      // else if (userroleid == 7) {
                                      //   await OutletsForClient();
                                      //   await getallempdetails();
                                      //   await getmerchnamelist();

                                      //   Navigator.pushReplacement(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (buildContext) =>
                                      //               ClientDB()));
                                      // }

                                      ///if login was not sucessfull.
                                      else {
                                        setState(() {
                                          isApiCallProcess = false;
                                        });

                                        /// snack bar pop's out with the message coming from login api.
                                        final snackBar = SnackBar(
                                            elevation: 20.00,
                                            duration: Duration(seconds: 2),
                                            content: Text(
                                              DBrequestdata.message
                                                          .toString() ==
                                                      "Password mismatch"
                                                  ? "The password is incorrect"
                                                  : DBrequestdata.message
                                                      .toString(),
                                            ));
                                        // scaffoldKey.currentState
                                        //     .showSnackBar(snackBar);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  }
                                } else {
                                  Flushbar(
                                    message: "Internet is required to login",
                                    duration: Duration(seconds: 5),
                                  )..show(context);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                padding: EdgeInsets.all(15.0),
                                width: MediaQuery.of(context).size.width / 1.25,
                                // color: orange,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFF88200),
                                        Color(0xFFE43700)
                                      ]),
                                ),
                                child: Center(
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
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
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
