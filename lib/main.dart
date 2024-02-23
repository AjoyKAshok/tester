// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Customers%20Activities.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchdash.dart';
import 'package:merchandising/login_screen.dart';
import 'package:merchandising/offlinedata/syncreferenceapi.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Journeyplan.dart';
import 'package:merchandising/model/rememberme.dart';
import 'package:merchandising/utils/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'Merchandiser/merchandiserscreens/NewJourneyPlan.dart';
import 'Merchandiser/merchandiserscreens/newCustomerActivities.dart';
import 'model/Location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/api/empdetailsapi.dart';
import 'api/FMapi/outlet brand mappingapi.dart';
import 'login_page.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/CompetitionCheckOne.dart';
import 'dart:async';
import 'model/rememberme.dart';
import 'api/FMapi/relieverdet_api.dart';
import 'api/api_service.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'api/HRapi/hrdashboardapi.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'api/FMapi/fmdbapi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:merchandising/api/FMapi/fmdbapi.dart';
import 'network/NetworkStatusService.dart';
import 'offlinedata/syncsendapi.dart';
import 'package:merchandising/api/FMapi/storedetailsapi.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import 'package:merchandising/api/FMapi/week_off_detailsapi.dart';
import 'package:merchandising/api/FMapi/brand_detailsapi.dart';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/api/FMapi/add_brandapi.dart';
import 'package:merchandising/api/FMapi/product_detailsapi.dart';
import 'package:merchandising/api/clientapi/outletreport.dart';
import 'clients/client_dashboard.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';
import 'package:merchandising/api/cde api/cdedashboard.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/api/FMapi/nbl_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'api/api_service2.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  //To interact with Flutter engine & Initialize the Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*opening the app without login screen.
  trying to check if any email or password has been stored in the local storage.*/
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('useremail');
  var password = prefs.getString('userpassword');
  remembereddata.email = email;
  remembereddata.password = password;
  // var email = null;
  // var password = null;
  print("Remember me : $email, $password");

  //if email and password are stored, then it will go through this loop
  if (email != null && password != null) {
    fromloginscreen = true;

    /*make sure we receive token and empid before calling other api's
    so await for login api.*/
    int userroleid = await loginapi();

    /*login api will return a role id.
    based on the role id we will navigate to that role id dashboard*/
    currentuser.roleid = userroleid;
    print("User Role ID-- $userroleid");

    // HR role id is 3
    if (userroleid == 3) {
      print("HR ROLE");
      await HRdb();
      await getempdetails();
      runApp(
        UpgradeAlert(
          upgrader: Upgrader(
            showIgnore: false,
            showLater: false,
            showReleaseNotes: false,
            canDismissDialog: false,
          ),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<NetworkStatusService>(
                  create: (_) => NetworkStatusService())
            ],
            child: MaterialApp(
              title: AppConstants.title,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                primaryColor: Colors.white,
                accentColor: orange,
              ),
              home: HRdashboard(),
              routes: {
                LoginScreen.routeName: (ctx) => LoginScreen(),
              },
            ),
          ),
        ),
      );
    }

    // field manager role id-5 && CDE's role id-2.
    // requesting all the data that is required for fm.
    else if (userroleid == 5 || userroleid == 2) {
      print("2-CDE 5-FieldManager");
      getempdetails();
      getWeekoffdetails();
      getBrandDetails();
      getemployeestoaddbrand();
      getCategoryDetails();
      getProductDetails();
      //getmyattandance();
      getStoreDetails();
      getmappedoutlets();
      getallempdetails();
      getRelieverDetails();
      OutletsForClient();
      // getNotificationDetails();
      await getFMoutletdetails();

      if (userroleid == 2) {
        await merchnamelistunderCDE();
        await getCDEdb();
      } else {
        await getmerchnamelist();
        await getFMdb();
      }

      runApp(
        UpgradeAlert(
          upgrader: Upgrader(
            showIgnore: false,
            showLater: false,
            showReleaseNotes: false,
            canDismissDialog: false,
          ),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<NetworkStatusService>(
                  create: (_) => NetworkStatusService())
            ],
            child: MaterialApp(
              title: AppConstants.title,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                primaryColor: Colors.white,
                accentColor: orange,
              ),
              home: FieldManagerDashBoard(),
              routes: {
                LoginScreen.routeName: (ctx) => LoginScreen(),
              },
            ),
          ),
        ),
      );
    }
    //merchandiser's role id is 6
    else if (userroleid == 6) {
      print("Merchandiser");
      /*BackgroundFetch.configure(config, onFetch)
      
      print("background fetch detail's : ${prefs.getString('fetch_events')}");*/
      // first we are trying to get any unsynced data that was in the local storage.
      message = prefs.getStringList('addtoservermessage');
      requireurlstosync = prefs.getStringList('addtoserverurl');
      requirebodytosync = prefs.getStringList('addtoserverbody');

      currentlysyncing = false;
      print("going to get reference");
      await syncingreferencedata();
      print("going to send");
      if (onlinemode.value) {
        print("come to send");
        print(requireurlstosync);
        print(requirebodytosync);
        syncingsenddata();
      }

      /*  //once app is up and running for every 20 minutes we are trying to get reference data.
      
      Timer.periodic(period, (Timer t) => syncingsenddata());*/

      var currentpage = prefs.getString('pageiddata');
      print("current page : $currentpage");
      if (currentpage == "2") {
        currentoutletid = int.parse(prefs.getString('outletiddata'));
        currenttimesheetid = prefs.getString('timesheetiddata');
        currentoutletindex =
            int.parse(prefs.getString('currentoutletindexdata'));
        company.text = prefs.getString("companydata");
        category.text = prefs.getString("categorydata");
        itemname.text = prefs.getString("itemdata");
        promotiontype.text = prefs.getString("promotypedata");
        promodscrptn.text = prefs.getString("promodescdata");
        mrp.text = prefs.getString("regpricedata");
        sellingprice.text = prefs.getString("sellpricedata");

        print("getString == ${company.text}");
        // print("img == $savedcopmimg");
      }
      if (currentpage == "1") {
        await getLocation();
        await callfrequentlytocheck();
        fromloginscreen = false;
        runApp(
          UpgradeAlert(
            upgrader: Upgrader(
              showIgnore: false,
              showLater: false,
              showReleaseNotes: false,
              canDismissDialog: false,
            ),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<NetworkStatusService>(
                    create: (_) => NetworkStatusService())
              ],
              child: MaterialApp(
                key: navigatorKey,
                title: AppConstants.title,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Poppins',
                  primaryColor: Colors.white,
                  accentColor: orange,
                ),
                home: NewJourneyPlanPage(),
                routes: {
                  LoginScreen.routeName: (ctx) => LoginScreen(),
                },
              ),
            ),
          ),
        );
      } else if (currentpage == "2") {
        await getLocation();
        await outletwhencheckin();
         /// TEMPORARILY DISABLED - HAS TO UNCOMMENT IN LATER STAGES AS PER REQUIREMENTS.
        // getTaskList();
        // getVisibility();
        // getPlanogramDetails();
        // getPromotionDetails();

        // Addedstockdataformerch();

         /// TEMPORARILY DISABLED - HAS TO UNCOMMENT IN LATER STAGES AS PER REQUIREMENTS.
        // await getNBLdetails();
        // getShareofshelf();
        // NBLdetailsoffline();

        print("KPI current page timesheet id");
        print(currenttimesheetid);
        fromloginscreen = false;
        runApp(
          UpgradeAlert(
            upgrader: Upgrader(
              showIgnore: false,
              showLater: false,
              showReleaseNotes: false,
              canDismissDialog: false,
            ),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<NetworkStatusService>(
                    create: (_) => NetworkStatusService())
              ],
              child: MaterialApp(
                key: navigatorKey,
                title: AppConstants.title,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Poppins',
                  primaryColor: Colors.white,
                  accentColor: orange,
                ),
                home: NewCustomerActivities(),
                routes: {
                  LoginScreen.routeName: (ctx) => LoginScreen(),
                },
              ),
            ),
          ),
        );
      } else {
        runApp(
          UpgradeAlert(
            upgrader: Upgrader(
              showIgnore: false,
              showLater: false,
              showReleaseNotes: false,
              canDismissDialog: false,
            ),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<NetworkStatusService>(
                    create: (_) => NetworkStatusService())
              ],
              child: MaterialApp(
                key: navigatorKey,
                title: AppConstants.title,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Poppins',
                  primaryColor: Colors.white,
                  accentColor: orange,
                ),
                home: MerchDash(),
                routes: {
                  LoginScreen.routeName: (ctx) => LoginScreen(),
                },
              ),
            ),
          ),
        );
      }
    }

    // client role id is 7
    // else if (userroleid == 7) {
    //   await OutletsForClient();
    //   await getallempdetails();
    //   await getmerchnamelist();
    //   runApp(
    //     UpgradeAlert(
    //       upgrader: Upgrader(
    //         showIgnore: false,
    //         showLater: false,
    //         showReleaseNotes: false,
    //         canDismissDialog: false,
    //       ),
    //       child: MultiProvider(
    //         providers: [
    //           ChangeNotifierProvider<NetworkStatusService>(
    //               create: (_) => NetworkStatusService())
    //         ],
    //         child: MaterialApp(
    //           title: AppConstants.title,
    //           debugShowCheckedModeBanner: false,
    //           theme: ThemeData(
    //             fontFamily: 'Poppins',
    //             primaryColor: Colors.white,
    //             accentColor: orange,
    //           ),
    //           home: ClientDB(),
    //           routes: {
    //             LoginPage.routeName: (ctx) => LoginPage(),
    //           },
    //         ),
    //       ),
    //     ),
    //   );
    // } 
    else {
      runApp(
        UpgradeAlert(
          upgrader: Upgrader(
            showIgnore: false,
            showLater: false,
            showReleaseNotes: false,
            canDismissDialog: false,
          ),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<NetworkStatusService>(
                  create: (_) => NetworkStatusService())
            ],
            child: MaterialApp(
              title: AppConstants.title,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                primaryColor: Colors.white,
                accentColor: orange,
              ),
              home: SplashScreen(),
              routes: {
                LoginScreen.routeName: (ctx) => LoginScreen(),
              },
            ),
          ),
        ),
      );
    }
  } else {
    //if no email or password found it will open login page.
    runApp(
      UpgradeAlert(
        upgrader: Upgrader(
          showIgnore: false,
          showLater: false,
          showReleaseNotes: false,
          canDismissDialog: false,
        ),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<NetworkStatusService>(
                create: (_) => NetworkStatusService())
          ],
          child: MaterialApp(
            title: AppConstants.title,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              primaryColor: Colors.white,
              accentColor: orange,
            ),
            home: SplashScreen(),
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
            },
          ),
        ),
      ),
    );
  }
}

class currentuser {
  static int roleid;
  static String client;
}

class remaining {
  static var leaves;
}
