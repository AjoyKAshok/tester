import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/offlinedata/syncreferenceapi.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/offlinedata/syncsendapi.dart';
import 'package:getwidget/getwidget.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:path/path.dart';
import 'package:merchandising/utils/background.dart';

class SyncScreen extends StatefulWidget {
  @override
  _SyncScreenState createState() => _SyncScreenState();
}

int currentstep = 50;
bool isApiCallProcess = false;
ValueNotifier<bool> dispose = new ValueNotifier(false);

class _SyncScreenState extends State<SyncScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: onlinemode,
        builder: (context, value, child) {
          return ProgressHUD(
            opacity: 0.3,
            inAsyncCall: isApiCallProcess,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: pink,
                  iconTheme: IconThemeData(color: orange),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Synchronize",
                            style: TextStyle(color: orange),
                          ),
                          EmpInfo()
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     syncnow(context);
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.all(10.0),
                      //     decoration: BoxDecoration(
                      //       color: onlinemode.value ? orange : iconscolor,
                      //       borderRadius: BorderRadius.circular(10.00),
                      //     ),
                      //     child: Text(
                      //       'Sync Now',
                      //       style: TextStyle(color: Colors.white, fontSize: 15),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                drawer: Drawer(
                  child: Menu(),
                ),
                body: OfflineNotification(
                  body: Stack(
                    children: [
                      BackGround(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.fromLTRB(5.0, 10, 5.0, 10.0),
                              padding: EdgeInsets.fromLTRB(5.0, 10, 5.0, 10.0),
                              child: Text(
                                "Activities ready for Synchronize",
                                style: TextStyle(fontSize: 12),
                              )),
                          Expanded(
                            child: message.length > 0
                                ? ListView.builder(
                                    //shrinkWrap: true,
                                    //physics: NeverScrollableScrollPhysics(),
                                    itemCount: message.length,
                                    //reverse: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40.0, right: 40.0),
                                              child: Divider(
                                                  thickness: 0.5, color: pink),
                                            ),
                                            Text(
                                              "${message.reversed.toList()[index]}",
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Spacer(),
                                            //     Text("${logtime[index]}"),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      );
                                    })
                                : Center(child: Text("No activities to sync")),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}

syncnow(context) async {
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
                                    'Synchronizing',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
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
                                'Please don\'t turn off your data, or close the app',
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
    //print('fat1');

    //progress.value = 50;
    currentlysyncing = true;
    await syncingreferencedata();
    progress.value = 100;
    currentlysyncing = false;
    dispose.value = true;
    if (progress.value == 100) Navigator.of(context, rootNavigator: true).pop();
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
                              Text(
                                'Success',
                                style: TextStyle(color: orange, fontSize: 18),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 0.8,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Synchronization done sucessfully",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DashBoard()));
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  decoration: BoxDecoration(
                                    color: orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "DashBoard",
                                        style: TextStyle(
                                            color: pink, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  });
            }));
  } else {
    Flushbar(
      message: "Make sure you had an active internet",
      duration: Duration(seconds: 3),
    );
  }
}
