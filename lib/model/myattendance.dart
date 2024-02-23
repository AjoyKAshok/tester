import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/myattendanceapi.dart';
import 'package:intl/intl.dart';
import 'package:merchandising/utils/background.dart';

class MyAttendance extends StatefulWidget {
  @override
  _MyAttendanceState createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Attendance",
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
          Container(
            child: Column(
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: TabBar(
                            labelColor: orange,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: orange,
                            tabs: [
                              Tab(text: 'PRESENT'),
                              Tab(text: 'ABSENT'),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                              ),
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Text(
                                        "Date",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                      Center(
                                          child: Text(
                                        "Check-in",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                      Center(
                                          child: Text(
                                        "Check-Out",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            PresentList(),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                ),
                                child: Table(
                                  children: [
                                    TableRow(children: [
                                      Center(
                                          child: Text(
                                        "Date",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                      Center(
                                          child: Text("Approved By",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                    ]),
                                  ],
                                )),
                            AbsentList(),
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
    );
  }
}

class PresentList extends StatefulWidget {
  @override
  _PresentListState createState() => _PresentListState();
}

class _PresentListState extends State<PresentList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)),
        color: pink,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: presentlist.date.length,
          itemBuilder: (BuildContext context, int index) {
            return Table(
              children: [
                TableRow(children: [
                  Center(
                      child: SizedBox(
                          height: 25,
                          child: Text(
                              '${DateFormat('MMMEd').format(DateTime.parse(presentlist.date[index]))}',
                              style: TextStyle(fontSize: 15)))),
                  Center(
                      child: Text('${(presentlist.checkin[index])}',
                          style: TextStyle(fontSize: 15))),
                  Center(
                      child: Text('${presentlist.checkout[index]}',
                          style: TextStyle(fontSize: 15))),
                ])
              ],
            );
          }),
    );
  }
}

class AbsentList extends StatefulWidget {
  @override
  _AbsentListState createState() => _AbsentListState();
}

class _AbsentListState extends State<AbsentList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)),
        color: pink,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: absentlist.date.length,
          itemBuilder: (BuildContext context, int index) {
            return Table(
              children: [
                TableRow(children: [
                  Center(
                      child: SizedBox(
                          height: 25,
                          child: Text(
                              '${DateFormat('MMMEd').format(DateTime.parse(absentlist.date[index]))}',
                              style: TextStyle(fontSize: 15)))),
                  Center(
                      child: Text('${absentlist.approvedby[index]}',
                          style: TextStyle(fontSize: 15))),
                ])
              ],
            );
          }),
    );
  }
}
