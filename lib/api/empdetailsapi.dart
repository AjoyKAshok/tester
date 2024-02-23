import 'dart:io';

import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service2.dart';

class myprofile {
  static var surname;
  static var passportnumber;
  static var nationality;
  static var mobilenumber;
  static var designation;
  static var department;
  static var joiningdate;
  static var visaexpirydate;
  static var passportexpirydate;
  static var visacompanyname;
  static var employeescore;
  static var documents;
  static var loginstatuscode;
}

String empdata;

Future getempdetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  empdata = prefs.getString('empdetails');
  if (empdata == null || currentlysyncing) {
    Map body = {'emp_id': '${DBrequestdata.receivedempid}'};
    print(body);
    try{
    http.Response DBresponse = await http.post(
      empdataurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(body),
    );
    print(DBresponse.body);
    if (DBresponse.statusCode == 200) {
      print('empolyee details done');
      empdata = DBresponse.body;
     await addempdetailesdata(empdata);
      var decodedempdata = jsonDecode(empdata);
      myprofile.surname = decodedempdata["data"][0]['surname'];
      myprofile.passportnumber = decodedempdata["data"][0]['passport_number'];
      myprofile.nationality = decodedempdata["data"][0]['nationality'];
      myprofile.mobilenumber = decodedempdata["data"][0]['mobile_number'];
      myprofile.designation = decodedempdata["data"][0]['designation'];
      myprofile.department = decodedempdata["data"][0]['department'];
      myprofile.joiningdate = decodedempdata["data"][0]['joining_date'];
      myprofile.passportexpirydate =
          decodedempdata["data"][0]['passport_exp_date'];
      myprofile.visaexpirydate = decodedempdata["data"][0]['visa_exp_date'];
      myprofile.visacompanyname =
          decodedempdata["data"][0]['visa_company_name'];
      myprofile.employeescore = decodedempdata["data"][0]['employee_score'];
      logoutmessage = decodedempdata["data"][0]['logout_message'];
    }
    if (DBresponse.statusCode != 200) {
      print("empdeatils");
      print(DBresponse.statusCode);
    }}
    on SocketException catch (_) {
  if(empdata!=null) {
    var decodedempdata = jsonDecode(empdata);
    myprofile.surname = decodedempdata["data"][0]['surname'];
    myprofile.passportnumber = decodedempdata["data"][0]['passport_number'];
    myprofile.nationality = decodedempdata["data"][0]['nationality'];
    myprofile.mobilenumber = decodedempdata["data"][0]['mobile_number'];
    myprofile.designation = decodedempdata["data"][0]['designation'];
    myprofile.department = decodedempdata["data"][0]['department'];
    myprofile.joiningdate = decodedempdata["data"][0]['joining_date'];
    myprofile.passportexpirydate =
    decodedempdata["data"][0]['passport_exp_date'];
    myprofile.visaexpirydate = decodedempdata["data"][0]['visa_exp_date'];
    myprofile.visacompanyname = decodedempdata["data"][0]['visa_company_name'];
    myprofile.employeescore = decodedempdata["data"][0]['employee_score'];
    logoutmessage = decodedempdata["data"][0]['logout_message'];
  }
      return false;
    }

  }
  else {
    var decodedempdata = jsonDecode(empdata);
    myprofile.surname = decodedempdata["data"][0]['surname'];
    myprofile.passportnumber = decodedempdata["data"][0]['passport_number'];
    myprofile.nationality = decodedempdata["data"][0]['nationality'];
    myprofile.mobilenumber = decodedempdata["data"][0]['mobile_number'];
    myprofile.designation = decodedempdata["data"][0]['designation'];
    myprofile.department = decodedempdata["data"][0]['department'];
    myprofile.joiningdate = decodedempdata["data"][0]['joining_date'];
    myprofile.passportexpirydate =
        decodedempdata["data"][0]['passport_exp_date'];
    myprofile.visaexpirydate = decodedempdata["data"][0]['visa_exp_date'];
    myprofile.visacompanyname = decodedempdata["data"][0]['visa_company_name'];
    myprofile.employeescore = decodedempdata["data"][0]['employee_score'];
    logoutmessage = decodedempdata["data"][0]['logout_message'];
  }
}
