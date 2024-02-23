import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';
import 'addjp.dart';
import 'package:merchandising/api/FMapi/week_off_detailsapi.dart';
import 'package:merchandising/utils/background.dart';

class JourneyplansMapVeiw extends StatefulWidget {
  @override
  _JourneyplansMapVeiwState createState() => _JourneyplansMapVeiwState();
}

class _JourneyplansMapVeiwState extends State<JourneyplansMapVeiw> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        iconTheme: IconThemeData(color: orange),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Journey Plans",
              style: TextStyle(color: orange),
            ),
            EmpInfo()
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: Menu(),
      // ),
      body: Stack(
        children: [
          BackGround(),
          ProgressHUD(
            opacity: 0.3,
            inAsyncCall: isApiCallProcess,
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: merchnamelist.firstname.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          // setState(() {
                          //   chat.receiver = merchnamelist.employeeid[index];
                          // });
                          // print(merchnamelist.employeeid[index]);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       // ignore: non_constant_identifier_names
                          //         builder: (BuildContextcontext) => ChatScreen()));
                          print(merchnamelist.employeeid[index]);
                          jpempid = merchnamelist.employeeid[index];
                          currentid = merchnamelist.employeeid[index];
                          currentname = merchnamelist.name[index];
                          for (int i = 0; i < Weekoff.empid.length; i++) {
                            print(Weekoff.empid[i]);
                            if (Weekoff.empid[i] == currentid) {
                              if (DateFormat("y").format(DateTime.now()) ==
                                  Weekoff.year[i]) {
                                if (Weekoff.month[i] ==
                                    DateFormat.MMMM().format(DateTime.now())) {
                                  weekoffon = Weekoff.day[i];
                                }
                              }
                            }
                          }
                          setState(() {
                            isApiCallProcess = true;
                          });
                          await getJourneyPlanweekly();
                          setState(() {
                            isApiCallProcess = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // ignore: non_constant_identifier_names
                                  builder: (BuildContextcontext) =>
                                      journeyplanDetails()));
                        },
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Merchandiser : ${merchnamelist.name[index]}',
                                    style: TextStyle(
                                        fontSize: 16.0, color: orange)),
                                SizedBox(height: 5),
                                Text(
                                    'Emp ID : ${merchnamelist.employeeid[index]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    )),
                              ],
                            )),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
