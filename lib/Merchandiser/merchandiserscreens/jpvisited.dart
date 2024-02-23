import 'package:flutter/material.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/JPvisitedapi.dart';
import 'package:merchandising/ProgressHUD.dart';

class visitedJourneyListBuilder extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<visitedJourneyListBuilder> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.1,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return todayvisjplist.id.length == 0
        ? Center(
            child: Text(
            "you haven't finished any outlet\n start your journey from planned journey Plan",
            textAlign: TextAlign.center,
          ))
        : ListView.builder(
            itemCount: todayvisjplist.id.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            '[${todayvisjplist.storecodes[index]}]',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${todayvisjplist.storenames[index]}',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text('${todayvisjplist.outletarea[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${todayvisjplist.outletcity[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${todayvisjplist.outletcountry[index]}',
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
                          Text('Contact Number',
                              style: TextStyle(
                                fontSize: 13.0,
                              )),
                          Text(":"),
                          Text('${todayvisjplist.contactnumbers[index]}',
                              style: TextStyle(color: orange)),
                        ]),
                      ],
                    ),
                  ],
                ),
              );
            });
  }
}
