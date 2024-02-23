import 'package:merchandising/ProgressHUD.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/main.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/api/api_service.dart';
import 'merchandiserdashboard.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:merchandising/api/leavestakenapi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'dart:convert';
import 'dart:io';
import 'package:merchandising/utils/background.dart';
import '../../api/api_service2.dart';

// ignore: camel_case_types
class leavelogic {
  // ignore: non_constant_identifier_names
  static DateTime StratDate;
}

// ignore: camel_case_types
class leavestatusPage extends StatefulWidget {
  @override
  _leavestatusPageState createState() => _leavestatusPageState();
}

// ignore: camel_case_types
class _leavestatusPageState extends State<leavestatusPage> {
  String accepted = "2";
  String rejected = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          // iconTheme: IconThemeData(color: orange),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DashBoard()));
            },
            icon: const Icon(Icons.arrow_back),
            color: Color(0XFF909090),
          ),
          title: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leave status',
                style: TextStyle(color: Color(0XFF909090)),
              ),
              EmpInfo()
            ],
          ),
        ),
        // drawer: Drawer(
        //   child: Menu(),
        // ),
        body: Stack(children: [
          BackGround(),
          ListView.builder(
              itemCount: leavedataResponse.reasons.length,
              // itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // height: 150,
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Reason :',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF909090),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: AutoSizeText(
                              '${leavedataResponse.reasons[index]}',
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 12,
                            color: Color(0XFFE84201),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${leavedataResponse.Startdates[index]}',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0XFF909090),
                              )),
                          SizedBox(width: 6),
                          Text(
                            'To',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('${leavedataResponse.enddates[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0XFF909090),
                              )),
                        ],
                      ),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Leave Type:',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0XFF909090),
                                  )),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              Text('${leavedataResponse.leavetypes[index]}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  )),
                            ],
                          ),
                          Spacer(),
                          Column(
                        children: [
                          Text('Status :',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0XFF909090),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              leavedataResponse.isleaveaccepted[index] ==
                                      accepted
                                  ? 'Accepted'
                                  : leavedataResponse.isleaverejected[index] ==
                                          rejected
                                      ? 'Rejected'
                                      : 'Pending',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: leavedataResponse.isleaveaccepted[index] ==
                                      accepted ? Color(0XFF00984F) : leavedataResponse.isleaverejected[index] ==
                                          rejected ? Color(0XFFE43700) : Color(0XFFFFB017),
                              ),),
                          
                        ],
                      ),
                          
                        ],
                      ),
                      
                      SizedBox(height: 5),
                      
                    ],
                  ),
                );
              }),
          if (leavedataResponse.reasons.length <= 0) _noRecordsFoundView(),
          Padding(
            padding: const EdgeInsets.only(
              right: 25.0,
              bottom: 25,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF88200), Color(0xFFE43700)],
                  ),
                ),
                margin: EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    print("remaining leaves: ${remaining.leaves}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LeaveRequest()));
                  },
                  // backgroundColor: Colors.transparent,
                  // elevation: 8.0,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  Widget _noRecordsFoundView() {
    return Container(
        child: Center(
      child: Text(
        "No Records Found",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    ));
  }
}

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  int dropDownValue = 0;
  DateTime tomoroww = DateTime.now().add(Duration(days: 1));

  // ignore: non_constant_identifier_names
  DateTime StratDate = DateTime.now().add(Duration(days: 1));

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: StratDate,
      firstDate: tomoroww,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: orange,
              onPrimary: Colors.white,
              surface: orange,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != StratDate)
      setState(() {
        StratDate = picked;
        leavelogic.StratDate = picked;
      });
    leave.startdate = DateFormat('yyyy-MM-dd').format(StratDate);
  }

  bool valuefirst = false;
  TextEditingController reasoninputcontroller = TextEditingController();
  FilePickerResult _file;

  Future getFile() async {
    FilePickerResult file = await FilePicker.platform.pickFiles();
    setState(() {
      _file = file;
      pickedfile.name = file.names.toString();
    });
    return _file;
  }

  bool isApiCallProcess = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leave.type = "Loss_of_Pay";
    leave.startdate = null;
    leave.enddate = null;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: false,
          backgroundColor: Colors.white,
          // iconTheme: IconThemeData(color: orange),
           leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => leavestatusPage()));
            },
            icon: const Icon(Icons.arrow_back),
            color: Color(0XFF909090),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leave Request',
                style: TextStyle(color: Color(0XFF909090)),
              ),
              // EmpInfo()
            ],
          ),
        ),
        // drawer: Drawer(
        //   child: Menu(),
        // ),
        body: Stack(
          children: [
            BackGround(),
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                //padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0XFFcacaca),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "${StratDate.toLocal()}".split(' ')[0],
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(CupertinoIcons.calendar),
                                onPressed: () => _selectDate(context),
                              ),
                            ],
                          ),
                          Container(
                            child: EndDate(),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Leave Type",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              DropdownButton(
                                dropdownColor: Colors.white,
                                value: dropDownValue,
                                onChanged: (int newVal) {
                                  setState(() {
                                    dropDownValue = newVal;
                                    istypesick.issick = dropDownValue;
                                    print(dropDownValue);
                                    if (dropDownValue == 0) {
                                      leave.type = "Loss_of_Pay";
                                    }
                                    if (dropDownValue == 1) {
                                      leave.type = "Sick_Leave";
                                      setState(() {
                                        istypesick.issick = dropDownValue;
                                      });
                                    }
                                    if (dropDownValue == 2) {
                                      leave.type = "Annual_Leave";
                                    }
                                  });
                                },
                                items: remaining.leaves == 0
                                    ? [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text('Loss of Pay'),
                                        ),
                                      ]
                                    : [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text('Loss of Pay'),
                                        ),
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('Sick Leave'),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text('Annual Leave'),
                                        ),
                                      ],
                              ),
                            ],
                          ),
                          istypesick.issick == 1
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Upload the Required Documents",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            FilePickerResult picked =
                                                await getFile();
                                            if (picked != null) {
                                              File file = File(
                                                  picked.files.single.path);
                                              var imagebytes =
                                                  file.readAsBytesSync();
                                              leave.image =
                                                  base64Encode(imagebytes);
                                              print(leave.image);
                                            }
                                          },
                                          child: Icon(
                                              CupertinoIcons.folder_badge_plus),
                                        )
                                      ],
                                    ),
                                    _file != null
                                        ? Text(pickedfile.name)
                                        : SizedBox()
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reason",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            maxLines: 2,
                            controller: reasoninputcontroller,
                            cursorColor: grey,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusColor: grey,
                              hintText: "Type your Reason here",
                              hintStyle: TextStyle(
                                color: grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.deepOrange,
                                value: this.valuefirst,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.valuefirst = value;
                                  });
                                },
                              ),
                            ),
                            Text(
                              "I accept the terms and conditions",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (valuefirst == true &&
                              reasoninputcontroller.text != "" &&
                              leave.startdate != null &&
                              leave.enddate != null &&
                              leave.type != null) {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            leave.reason = reasoninputcontroller.text;
                            await leaverequest();
                            leavedataResponse.isleaverejected = [];
                            leavedataResponse.isleaveaccepted = [];
                            leavedataResponse.enddates = [];
                            leavedataResponse.Startdates = [];
                            leavedataResponse.leavetypes = [];
                            leavedataResponse.reasons = [];
                            if (currentuser.roleid == 6) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DashBoard()));
                              setState(() {
                                isApiCallProcess = false;
                              });
                            }
                            if (currentuser.roleid == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HRdashboard()));
                              setState(() {
                                isApiCallProcess = false;
                              });
                            }
                            if (currentuser.roleid == 5) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FieldManagerDashBoard()));
                              setState(() {
                                isApiCallProcess = false;
                              });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      backgroundColor: alertboxcolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
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
                                                  Text(
                                                    "Alert",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10.00,
                                                  ),
                                                  Text(
                                                      leave.startdate == null
                                                          ? "Please select Start date"
                                                          : leave.enddate ==
                                                                  null
                                                              ? "Please select End date"
                                                              : leave.type ==
                                                                      null
                                                                  ? "Please select the leave type"
                                                                  : reasoninputcontroller
                                                                              .text ==
                                                                          ""
                                                                      ? "Reason can not be empty"
                                                                      : valuefirst ==
                                                                              false
                                                                          ? "Please accept the terms and conditions"
                                                                          : null,
                                                      style: TextStyle(
                                                          fontSize: 13.6)),
                                                  SizedBox(
                                                    height: 10.00,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      LeaveRequest()));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: orange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10.00),
                                                          child: Center(
                                                              child: Text(
                                                            "ok",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ));
                          }
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                               gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFF88200), Color(0xFFE43700)]),
                              borderRadius: BorderRadius.circular(10.00),
                            ),
                            child: Text(
                              'Request Leave',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class istypesick {
  static int issick;
}

class EndDate extends StatefulWidget {
  @override
  _EndDateState createState() => _EndDateState();
}

class _EndDateState extends State<EndDate> {
  DateTime tomoroww = DateTime.now().add(Duration(days: 1));
  DateTime ENDdate = DateTime.now().add(Duration(days: 1));

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: leavelogic.StratDate,
      firstDate: leavelogic.StratDate,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: orange,
              onPrimary: Colors.white,
              surface: orange,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != EndDate)
      setState(() {
        ENDdate = picked;
      });
    leave.enddate = DateFormat('yyyy-MM-dd').format(ENDdate);
    print(leave.enddate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            "End Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${ENDdate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}

class pickedfile {
  static var name;
  static var bytes;
}
