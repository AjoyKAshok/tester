import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_picker/country_picker.dart';
import 'Addempdetailsphase2.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';
import 'package:merchandising/api/HRapi/addemployeeapi.dart';
import 'package:merchandising/utils/background.dart';

class EmployeeDetailes extends StatefulWidget {
  @override
  _EmployeeDetailesState createState() => _EmployeeDetailesState();
}

class _EmployeeDetailesState extends State<EmployeeDetailes> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<dynamic> inputlist;
  List<String> _filterList;
  List<String> _filterdesignationList;

  @override
  void initState() {
    super.initState();
    inputlist = employees.fullname;
    inputlist.sort();
  }

  _EmployeeDetailesState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: containerscolor,
            iconTheme: IconThemeData(color: orange),
            title: Row(
              children: [
                Text(
                  'Employees',
                  style: TextStyle(color: orange),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Menu(),
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
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      updatedata.employee = false;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddEmployee()));
                    },
                    backgroundColor: pink,
                    elevation: 8.0,
                    child: Icon(
                      Icons.add,
                      color: orange,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(25.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: new TextField(
              style: TextStyle(color: orange),
              controller: _searchview,
              cursorColor: orange,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                focusColor: orange,
                hintText: 'Search by Emp name or Emp ID',
                hintStyle: TextStyle(color: orange),
                border: InputBorder.none,
                icon: Icon(
                  CupertinoIcons.search,
                  color: orange,
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                _searchview.clear();
              },
              child: Icon(
                CupertinoIcons.clear_circled_solid,
                color: orange,
              ))
        ],
      ),
    );
  }

  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: employees.rolename.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () {
                updatedata.empid =
                    'Emp${employees.fullname[index].replaceAll(new RegExp(r'[^0-9]'), '')}';
                print(updatedata.empid);
                showDialog(
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, setState) {
                          return ProgressHUD(
                              inAsyncCall: isApiCallProcess,
                              opacity: 0.3,
                              child: AlertDialog(
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 15.00,
                                            ),
                                            Text(
                                                "Do you want to edit this employee details?",
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 25.00,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      isApiCallProcess = true;
                                                    });
                                                    updatedata.employee = true;
                                                    await getempdata();
                                                    setState(() {
                                                      isApiCallProcess = false;
                                                    });
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AddEmployee()));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.00),
                                                    child: Center(
                                                        child: Text("yes")),
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
                        }));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: AutoSizeText(
                            '${employees.fullname[index]}',
                            maxLines: 1,
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
                        Text('Designation :',
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(employees.rolename[index]),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _performSearch() {
    _filterList = [];
    _filterdesignationList = [];
    for (int i = 0; i < employees.fullname.length; i++) {
      var item = employees.fullname[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
        _filterdesignationList
            .add(employees.rolename[employees.fullname.indexOf(item)]);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () {
                updatedata.empid =
                    'Emp${_filterList[index].replaceAll(new RegExp(r'[^0-9]'), '')}';
                print(updatedata.empid);
                showDialog(
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, setState) {
                          return ProgressHUD(
                              inAsyncCall: isApiCallProcess,
                              opacity: 0.3,
                              child: AlertDialog(
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 15.00,
                                            ),
                                            Text(
                                                "Do you want to edit this employee details?",
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 25.00,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      isApiCallProcess = true;
                                                    });
                                                    updatedata.employee = true;
                                                    await getempdata();
                                                    setState(() {
                                                      isApiCallProcess = false;
                                                    });
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AddEmployee()));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.00),
                                                    child: Center(
                                                        child: Text("yes")),
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
                        }));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: AutoSizeText(
                            _filterList[index],
                            maxLines: 1,
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
                        Text('Designation :',
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(_filterdesignationList[index]),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

bool isgenderfemale = false;
bool isgendermale = true;

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  // ignore: non_constant_identifier_names
  String Selectedcountry =
      updatedata.employee == true ? employeedata.nationality : null;

  String selectedcountrycode =
      updatedata.employee == true ? employeedata.codes : null;

  int designationdropdown = 0;
  TextEditingController firstname = updatedata.employee == true
      ? TextEditingController(text: employeedata.firstname)
      : TextEditingController();
  TextEditingController middlename = updatedata.employee == true
      ? TextEditingController(text: employeedata.middlename)
      : TextEditingController();
  TextEditingController lastname = updatedata.employee == true
      ? TextEditingController(text: employeedata.surname)
      : TextEditingController();
  TextEditingController email = updatedata.employee == true
      ? TextEditingController(text: employeedata.email)
      : TextEditingController();
  TextEditingController mobilenumber = updatedata.employee == true
      ? TextEditingController(text: employeedata.mobileno)
      : TextEditingController();
  GlobalKey<FormState> addempphase1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: containerscolor,
            iconTheme: IconThemeData(color: orange),
            title: Row(
              children: [
                Text(
                  'Add Employee',
                  style: TextStyle(color: orange),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Menu(),
          ),
          body: Stack(
            children: [
              BackGround(),
              SingleChildScrollView(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: addempphase1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Details",
                        style: TextStyle(color: orange),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: firstname,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "First Name should not be empty"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "First Name (@required)",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: middlename,
                          cursorColor: grey,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Middle Name",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: lastname,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "Last Name should not be empty"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Last Name (@required)",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: email,
                          cursorColor: grey,
                          validator: (input) => !input.contains('@')
                              ? "Email Id should be valid"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Email (@required)",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select Gender',
                              style: TextStyle(
                                color: grey,
                                fontSize: 16.0,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isgenderfemale = true;
                                      isgendermale = false;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Female',
                                            style: TextStyle(
                                              color: isgenderfemale == true
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          CupertinoIcons.triangle_fill,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: orange, width: 1.0),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      color: isgenderfemale == true
                                          ? orange
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isgendermale = true;
                                      isgenderfemale = false;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Male',
                                            style: TextStyle(
                                              color: isgendermale == false
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          CupertinoIcons.triangle_fill,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: orange, width: 1.0),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: isgendermale == true
                                          ? orange
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              print('Select country: ${country.phoneCode}');
                              setState(() {
                                Selectedcountry =
                                    country.displayNameNoCountryCode;
                                selectedcountrycode = country.phoneCode;
                              });
                            },
                          );
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 50,
                            child: Selectedcountry == null
                                ? Center(
                                    child: Text(
                                    'Select Country (@ required)',
                                    style: TextStyle(color: grey, fontSize: 16),
                                  ))
                                : Center(
                                    child: Text(
                                    Selectedcountry,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: selectedcountrycode != null
                                  ? Center(
                                      child: Text(
                                        '+$selectedcountrycode',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    )
                                  : SizedBox()),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: mobilenumber,
                              cursorColor: grey,
                              validator: (input) => !input.isNotEmpty
                                  ? "Mobile Number should not be empty"
                                  : null,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusColor: orange,
                                hintText: "Mobile Number (@required)",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (validateform()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              employeedetails.gender =
                                  isgendermale == true ? "male" : "female";
                              employeedetails.firstname = firstname.text;
                              employeedetails.middlename = middlename.text;
                              employeedetails.surname = lastname.text;
                              employeedetails.email = email.text;
                              employeedetails.nationality = Selectedcountry;
                              employeedetails.codes = selectedcountrycode;
                              employeedetails.mobileno = mobilenumber.text;
                              await getdesignations();
                              setState(() {
                                isApiCallProcess = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          // ignore: non_constant_identifier_names
                                          (BuildContextcontext) =>
                                              AddempPhase2()));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Next'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }

  bool validateform() {
    final form = addempphase1.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
