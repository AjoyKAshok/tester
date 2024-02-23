import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/HRapi/addemployeeapi.dart';
import 'package:intl/intl.dart';
import 'package:merchandising/HR/addreport.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/utils/background.dart';
import 'dart:async';

class AddempPhase3 extends StatefulWidget {
  @override
  _AddempPhase3State createState() => _AddempPhase3State();
}

class _AddempPhase3State extends State<AddempPhase3> {
  GlobalKey<FormState> addempphase3 = GlobalKey<FormState>();

  TextEditingController passport = updatedata.employee == true
      ? TextEditingController(text: employeedata.passportno)
      : TextEditingController();
  TextEditingController visacompany = updatedata.employee == true
      ? TextEditingController(text: employeedata.visacompanyname)
      : TextEditingController();
  TextEditingController visanumber = updatedata.employee == true
      ? TextEditingController(text: employeedata.visacompanyname)
      : TextEditingController();
  TextEditingController medicalinsurance = updatedata.employee == true
      ? TextEditingController(text: employeedata.medicalinsno)
      : TextEditingController();
  TextEditingController emiratesid = updatedata.employee == true
      ? TextEditingController(text: employeedata.emiratesid)
      : TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: GestureDetector(
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
                      key: addempphase3,
                      child: Column(
                        children: [
                          Text(
                            "Documents Info",
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
                              controller: emiratesid,
                              cursorColor: grey,
                              validator: (input) => !input.isNotEmpty
                                  ? "Emirates id should not be empty"
                                  : null,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusColor: orange,
                                hintText: "Emirates ID (@required)",
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
                              controller: passport,
                              cursorColor: grey,
                              validator: (input) => !input.isNotEmpty
                                  ? "Passport Number should not be empty"
                                  : null,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusColor: orange,
                                hintText: "Passport Number (@required)",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          PassportExpirydate(),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: visacompany,
                              cursorColor: grey,
                              validator: (input) => !input.isNotEmpty
                                  ? "Visa Company should not be empty"
                                  : null,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusColor: orange,
                                hintText: "Visa Company (@required)",
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
                              controller: visanumber,
                              cursorColor: grey,
                              validator: (input) => !input.isNotEmpty
                                  ? "Visa Number should not be empty"
                                  : null,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusColor: orange,
                                hintText: "Visa Number (@required)",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          visaExpirydate(),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: medicalinsurance,
                              cursorColor: grey,
                              validator: (input) => !input.isNotEmpty
                                  ? "Mediacal Insurance should not be empty"
                                  : null,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusColor: orange,
                                hintText:
                                    "Medical Insurance Number (@required)",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          MedicalExpirydate(),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                if (validateform()) {
                                  setState(() {
                                    isApiCallProcess = true;
                                  });
                                  employeedetails.emiratesid = emiratesid.text;
                                  employeedetails.passportno = passport.text;
                                  employeedetails.visacompanyname =
                                      visacompany.text;
                                  print(visanumber.text);
                                  employeedetails.medicalinsno =
                                      medicalinsurance.text;
                                  employeedetails.passportexpdate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(passportexpiry);
                                  employeedetails.visaexpdate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(visaexpiry);
                                  employeedetails.medicalinsexpdate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(medicalexpiry);
                                  await addemployees();
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  Flushbar(
                                    messageText: Text(
                                      "Employee has been added",
                                      style: TextStyle(color: iconscolor),
                                    ),
                                    backgroundColor: pink,
                                    duration: Duration(seconds: 3),
                                  )..show(context);

                                  Timer(Duration(seconds: 4), () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                // ignore: non_constant_identifier_names
                                                (BuildContextcontext) =>
                                                    HRdashboard()));
                                  });
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
                  ),
                ),
              ],
            )),
      ),
    );
  }

  bool validateform() {
    final form = addempphase3.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

// ignore: camel_case_types
class visaExpirydate extends StatefulWidget {
  @override
  _visaExpirydateState createState() => _visaExpirydateState();
}

// ignore: camel_case_types
class _visaExpirydateState extends State<visaExpirydate> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: visaexpiry,
      firstDate: DateTime(2015, 8),
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
    if (picked != null && picked != visaexpiry)
      setState(() {
        visaexpiry = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            "Visa Expiry Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${visaexpiry.toLocal()}".split(' ')[0],
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

DateTime visaexpiry = updatedata.employee == true
    ? DateFormat("yyyy-MM-dd").parse(employeedata.visaexpdate)
    : DateTime.now();

DateTime passportexpiry = updatedata.employee == true
    ? DateFormat("yyyy-MM-dd").parse(employeedata.passportexpdate)
    : DateTime.now();

DateTime medicalexpiry = updatedata.employee == true
    ? DateFormat("yyyy-MM-dd").parse(employeedata.medicalinsexpdate)
    : DateTime.now();

class PassportExpirydate extends StatefulWidget {
  @override
  _PassportExpirydateState createState() => _PassportExpirydateState();
}

class _PassportExpirydateState extends State<PassportExpirydate> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: passportexpiry,
      firstDate: DateTime(2015, 8),
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
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != StartDate)
      setState(() {
        passportexpiry = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            "Passport Expiry Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${passportexpiry.toLocal()}".split(' ')[0],
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

class MedicalExpirydate extends StatefulWidget {
  @override
  _MedicalExpirydate createState() => _MedicalExpirydate();
}

class _MedicalExpirydate extends State<MedicalExpirydate> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: medicalexpiry,
      firstDate: DateTime(2015, 8),
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
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != StartDate)
      setState(() {
        medicalexpiry = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            "Insurance Expiry Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${medicalexpiry.toLocal()}".split(' ')[0],
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
