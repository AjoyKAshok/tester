import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import '../ConstantMethods.dart';
import '../Merchandiser/merchandiserscreens/Time Sheet.dart';
import '../ProgressHUD.dart';
import '../api/api_service.dart';
import '../api/leavestakenapi.dart';
import '../api/timesheetapi.dart';
import '../api/timesheetmonthly.dart';
import '../utils/background.dart';
import 'package:merchandising/main.dart';

class ListOfMerchandisers extends StatefulWidget {
  ListOfMerchandisers(
    List<Map<String, dynamic>> this.resultList,
    List<Map<String, dynamic>> this.resultListSkipped,
  );

  final List<Map<String, dynamic>> resultList;
  final List<Map<String, dynamic>> resultListSkipped;

  @override
  State<ListOfMerchandisers> createState() => _ListOfMerchandisersState();
}

class _ListOfMerchandisersState extends State<ListOfMerchandisers> {
  List<Map<String, dynamic>> passedList = [];
  List<Map<String, dynamic>> passedListSkipped = [];
  bool isApiCallProcess = false;
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<dynamic> inputlist;
  List<int> _filterList = [];
  Future<List<Map<String, dynamic>>> employees;
  Future<List<Map<String, dynamic>>> employeesList;
  var JPvisiteddata;
  int storeCount;
  List<String> employeeIds = [];

  // Future<List<Map<String, dynamic>>> fetchStoreDataForEmployee(
  //     List<String> empIds) async {
  //   List<Map<String, dynamic>> resultList = [];

  //   final DateTime now = DateTime.now();
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String todaydate = formatter.format(now);
  //   for (String employeeId in empIds) {
  //     Map timesheetfm = {
  //       'emp_id': employeeId,
  //       'date': '$todaydate',
  //     };

  //     final response = await http.post(
  //       TSurl,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
  //       },
  //       body: jsonEncode(timesheetfm),
  //     );

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> employeeData = json.decode(response.body);
  //       List<Map<String, dynamic>> data =
  //           (employeeData['data'] as List).cast<Map<String, dynamic>>();

  //       List<dynamic> storeNames =
  //           data.map((entry) => entry['store_name']).toList();

  //       Map<String, dynamic> result = {
  //         'employee_id': employeeId,
  //         'store_names': storeNames,
  //       };

  //       resultList.add(result);
  //       //  yield [result];

  //       print(
  //           'For Visit Count from Fetching Data : $employeeId - ${storeNames.length}');
  //     } else {
  //       throw Exception('Failed to load store data for employee $employeeId');
  //     }
  //   }
  //   print('From Fetching Store Data for Employees : $resultList');
  //   return resultList;
  // }

  // Future<void> fetchEmployeeList() async {
  //   employeeIds = merchnamelist.employeeid;

  //   final List<Map<String, dynamic>> storeData =
  //       await fetchStoreDataForEmployee(employeeIds);
  // }

  // void fetchEmployeeList() {
  // employeeIds = merchnamelist.employeeid;

  // fetchStoreDataForEmployee(employeeIds).listen((List<Map<String, dynamic>> storeData) {
  //   // Add the store data to the stream
  //   storeDataController.sink.add(storeData);
  // });
// }

  // loadData() async {
  //   passedList = await widget.resultList;
  //   passedListSkipped = await widget.resultListSkipped;
  // }

  @override
  void initState() {
    super.initState();
    passedList = widget.resultList;
    passedListSkipped = widget.resultListSkipped;

    // Fetch the list of employees.
    // fetchEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          centerTitle: true,
          iconTheme: IconThemeData(color: orange),
          title: Column(
            children: [
              Text(
                "Time Sheet",
                style: TextStyle(color: orange),
              ),
              EmpInfo()
            ],
          ),
        ),
        body: Stack(
          children: [
            BackGround(),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10, 10, 0),
              child: new Column(
                children: <Widget>[
                  _createSearchView(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _firstSearch ? _createListView() : _performSearch(),
                ],
              ),
            ),
            if (currentuser.roleid == 2 && MerchUnderCDE.firstname.length <= 0)
              _noRecordsFoundView(),
            if (currentuser.roleid != 2 && merchnamelist.firstname.length <= 0)
              _noRecordsFoundView(),
            if (_filterList.length <= 0 && !_firstSearch) _noRecordsFoundView(),
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(left: 20.0),
      width: double.infinity,
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(25.0)),
      child: new TextField(
        style: TextStyle(color: orange),
        controller: _searchview,
        cursorColor: orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          focusColor: orange,
          hintText: 'Search by name or EmpID',
          hintStyle: TextStyle(color: orange),
          border: InputBorder.none,
          icon: Icon(
            CupertinoIcons.search,
            color: orange,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _searchview.clear();
            },
            icon: Icon(
              CupertinoIcons.clear_circled_solid,
              color: orange,
            ),
          ),
          // isCollapsed: true,
        ),
      ),
    );
  }

  Widget _noRecordsFoundView() {
    return Align(
      alignment: Alignment.center,
      child: Center(
        child: Text(
          "No Records Found",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          itemCount: currentuser.roleid == 2
              ? MerchUnderCDE.firstname.length
              : merchnamelist.firstname.length,
          itemBuilder: (BuildContext ctx, int index) {
            // String employeeId = employeeIds[index];
            String employeeId = merchnamelist.employeeid[index];

            // Find the corresponding store data for this employee.

            Map<String, dynamic> storeData = passedList.firstWhere(
                (data) => data['employee_id'] == employeeId,
                orElse: () => null);

            Map<String, dynamic> storeDataSkipped = passedListSkipped
                .firstWhere((data) => data['employee_id'] == employeeId,
                    orElse: () => null);

            int storeCount = storeData != null
                ? storeData['store_names'].length
                : 0; // Default to 0 if not found.

            int storeCountSkipped = storeDataSkipped != null
                ? storeDataSkipped['store_names'].length
                : 0; // Default to 0 if not found.

            return Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    // alldateselected=false;
                    // print(merchnamelist.name[index]);
                    timesheet.empid = currentuser.roleid == 2
                        ? MerchUnderCDE.employeeid[index]
                        : merchnamelist.employeeid[index];
                    timesheet.empname = currentuser.roleid == 2
                        ? MerchUnderCDE.name[index]
                        : merchnamelist.name[index];

                    setState(() {
                      isApiCallProcess = true;
                    });
                    await getTimeSheetdaily();
                    await gettimesheetmonthly();
                    await gettimesheetleavetype();
                    // await gettimesheetleavetype1();
                    //await leaveReportData();
                    setState(() {
                      isApiCallProcess = false;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            // ignore: non_constant_identifier_names
                            builder: (ctxt) => TimeSheetList()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(top: 10),
                    // margin: index == 0 ? EdgeInsets.fromLTRB(10.0,10,10,10):EdgeInsets.fromLTRB(10.0,0,10,10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                currentuser.roleid == 2
                                    ? '${MerchUnderCDE.firstname[index]} ${MerchUnderCDE.surname[index]}'
                                    : '${merchnamelist.name[index]} ${merchnamelist.surname[index]}',
                                style:
                                    TextStyle(fontSize: 16.0, color: orange)),
                            SizedBox(height: 5),
                            Text(
                                currentuser.roleid == 2
                                    ? 'Emp ID:${MerchUnderCDE.employeeid[index]}'
                                    : 'Emp ID : ${merchnamelist.employeeid[index]}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                )),
                          ],
                        ),
                        // loadWidget(merchnamelist.employeeid[index]),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 250,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    height: 60,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
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
                                                        return Container(
                                                          child: SizedBox(
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                              children: [
                                                                Center(
                                                                  child: Text(
                                                                    "Visited Outlets",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                    "${passedList[index]['store_names']}",
                                                                    style: TextStyle(fontSize: 13.6)),
                                                                SizedBox(
                                                                  height: 10.00,
                                                                ),
                                                                
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ));
                                            }));
                                
                            },
                            child: Text('Visited: ${storeCount}'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
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
                                                        return Container(
                                                          child: SizedBox(
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                              children: [
                                                                Center(
                                                                  child: Text(
                                                                    "Pending Outlets",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                    "${passedListSkipped[index]['store_names']}",
                                                                    style: TextStyle(fontSize: 13.6)),
                                                                SizedBox(
                                                                  height: 10.00,
                                                                ),
                                                                
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ));
                                            }));
                            },
                            child: Text('Pending: $storeCountSkipped',
                                style: TextStyle(color: orange)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
  //     },
  //   );
  // }

  int searchedindex;

  Widget _performSearch() {
    _filterList = [];
    List<String> currentlist = currentuser.roleid == 5
        ? merchnamelist.firstname
        : MerchUnderCDE.firstname;
    for (int i = 0; i < currentlist.length; i++) {
      var item = currentuser.roleid == 5
          ? merchnamelist.firstname[i]
          : MerchUnderCDE.firstname[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        int searchedindex = currentuser.roleid == 5
            ? merchnamelist.firstname.indexOf(item)
            : MerchUnderCDE.firstname.indexOf(item);
        _filterList.add(searchedindex);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                //print(merchnamelist.name[index]);
                timesheet.empid = currentuser.roleid == 2
                    ? MerchUnderCDE.employeeid[_filterList[index]]
                    : merchnamelist.employeeid[_filterList[index]];
                timesheet.empname = currentuser.roleid == 2
                    ? MerchUnderCDE.name[_filterList[index]]
                    : merchnamelist.name[_filterList[index]];
                print("filtered list");
                print(timesheet.empname);
                setState(() {
                  isApiCallProcess = true;
                });
                await getTimeSheetdaily();
                await gettimesheetmonthly();
                await gettimesheetleavetype();
                setState(() {
                  isApiCallProcess = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ignore: non_constant_identifier_names
                        builder: (BuildContextcontext) => TimeSheetList()));
              },
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(top: 10),
                  // margin: index == 0 ? EdgeInsets.fromLTRB(10.0,10,10,10):EdgeInsets.fromLTRB(10.0,0,10,10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          currentuser.roleid == 2
                              ? '${MerchUnderCDE.firstname[_filterList[index]]}'
                              : '${merchnamelist.name[_filterList[index]]}',
                          style: TextStyle(fontSize: 16.0, color: orange)),
                      SizedBox(height: 5),
                      Text(
                          currentuser.roleid == 2
                              ? 'Emp ID:${MerchUnderCDE.employeeid[_filterList[index]]}'
                              : 'Emp ID : ${merchnamelist.employeeid[_filterList[index]]}',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ],
                  )),
            );
          }),
    );
  }
}
