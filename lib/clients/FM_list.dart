import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Fieldmanager/merchandiserslist.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/timesheetapi.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Time Sheet.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/timesheetmonthly.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/timesheetmonthly.dart';
import 'package:merchandising/utils/background.dart';

int position;

class FieldManagersList extends StatefulWidget {
  @override
  _FieldManagersListState createState() => _FieldManagersListState();
}

class _FieldManagersListState extends State<FieldManagersList> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          iconTheme: IconThemeData(color: orange),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Field Manager's List",
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
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),

                      shrinkWrap: true,
                      itemCount: employees.feildmanagers.length,
                      itemBuilder: (BuildContext context, int index) {
                        position = index;
                        return GestureDetector(
                          onTap: () async {
                            //position=index;
                            //DBrequestdata.receivedempid=employees.FMTSempid[index];
                            CLFM.empid = employees.FMTSempid[index];
                            print(CLFM.empid);

                            setState(() {
                              isApiCallProcess = true;
                            });

                            await getmerchnamelist();

                            setState(() {
                              isApiCallProcess = false;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // ignore: non_constant_identifier_names
                                    builder: (BuildContextcontext) =>
                                        MerchandisersList()));
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                            'Field Manager : ${employees.feildmanagers[index]}',
                                            style: TextStyle(
                                                fontSize: 16.0, color: orange)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Emp ID : ${employees.FMTSempid[index]}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      )),
                                ],
                              )),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CLFM {
  static var empid;
}
