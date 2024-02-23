import 'package:flutter/material.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/myprofile.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/profilescreen.dart';
import 'package:merchandising/login_page.dart';
import 'package:merchandising/offlinedata/syncdata.dart';

import 'package:merchandising/utils/headerdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/clients/client_dashboard.dart';
import 'package:merchandising/login_page.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/offlinedata/syncsendapi.dart';
import 'package:merchandising/utils/DatabaseHelper.dart';
import '../../ConstantMethods.dart';
// import 'merchandiserdashboard.dart';
// import 'myprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/model/rememberme.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/offlinedata/syncdata.dart';
import 'package:merchandising/model/version deailes.dart';
import 'package:merchandising/api/noti_detapi.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/logs.dart';

import '../api/api_service2.dart';
import '../login_screen.dart';

class MerchandiserDrawer extends StatefulWidget {
  MerchandiserDrawer();

  @override
  State<MerchandiserDrawer> createState() => _MerchandiserDrawerState();
}

class _MerchandiserDrawerState extends State<MerchandiserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderDrawer(),
              DrawerTiles(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DrawerTiles() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                 currentpagestatus('0', '0', '0', '0');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage()));
          
                // Navigator.of(context).pushNamed(ProfilePage.routeName);
                // Navigator.of(context).pushReplacementNamed('/');
                // Navigator.of(context)
                //     .pushReplacementNamed(WelcomeScreen.routeName);
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.date_range_sharp),
              title: Text('Logs'),
              onTap: () async {
                 currentpagestatus('0', '0', '0', '0');
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  logreport = prefs.getStringList('logdata');
                  print("start");
                  if (logreport != null) {
                    logtime = prefs.getStringList('logtime');
                    logreportstatus = prefs.getStringList('status');
                    print(logreportstatus.length);
                  } else {
                    logreport = [];
                    logtime = [];
                    logreportstatus = [];
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => VLogs()));
                // Navigator.of(context).pushReplacementNamed('/');
                // Navigator.of(context)
                //     .pushReplacementNamed(WelcomeScreen.routeName);
              },
            ),
            
         const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.add_moderator_outlined),
              title: const Text('RMS Version'),
              onTap: () {
                 currentpagestatus('0', '0', '0', '0');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AppVersion()));
                // Navigator.of(context).pushReplacementNamed('/');
                // Navigator.of(context)
                //     .pushReplacementNamed(WelcomeScreen.routeName);
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text('Log Out'),
              onTap: () async {
                if (currentuser.roleid == 6) {
                // createlog("Logout from Menu tapped", "true");
                currentpagestatus('0', '0', '0', '0');
                SharedPreferences prefs = await SharedPreferences.getInstance();
                requireurlstosync = prefs.getStringList('addtoserverurl');
                print(requireurlstosync);
                if (requireurlstosync != null) {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          StatefulBuilder(builder: (context, setState) {
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
                                      Text(
                                        'Alert',
                                        style: TextStyle(
                                            color: orange, fontSize: 20),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                      Text(
                                        "We found some activites that should be synced, please sync it and try again",
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        SyncScreen()));
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: orange,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Text('Go to Synchronize',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }));
                } else {
                  print(logoutmessage);
                  showDialog(
                      context: context,
                      builder: (_) =>
                          StatefulBuilder(builder: (context, setState) {
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
                                      Text(
                                        'Note',
                                        style: TextStyle(
                                            color: orange, fontSize: 20),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                      Text(
                                        logoutmessage == null
                                            ? "App Don't track you, it will only track when user had active check in."
                                            : logoutmessage,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            removeValues();
                                            logout();
                                            chackdata();
                                            deleteAllTable_();
                                            loggedin.email = null;
                                            loggedin.password = null;
                                            currentuser.roleid = null;
                                            remembereddata.email = null;
                                            remembereddata.password = null;
                                            DBrequestdata.empname = null;
                                            DBrequestdata.emailid = null;
                                            currentuser.roleid = null;
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.clear();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        LoginScreen()));
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: orange,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Text('Proceed to Logout',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }));
                }
              } else {
                loggedin.email = null;
                loggedin.password = null;
                currentuser.roleid = null;
                remembereddata.email = null;
                remembereddata.password = null;
                DBrequestdata.empname = null;
                DBrequestdata.emailid = null;
                currentuser.roleid = null;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              }
                // Navigator.of(context).pushReplacementNamed('/');
                // Navigator.of(context)
                //     .pushReplacementNamed(WelcomeScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
