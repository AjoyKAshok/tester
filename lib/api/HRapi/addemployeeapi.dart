import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';

import '../api_service2.dart';

class employeedetails {
  static var firstname;
  static var middlename;
  static var surname;
  static var passportno;
  static var nationality;
  static var gender;
  static var codes;
  static var emiratesid;
  static var mobileno;
  static var email;
  static var designation;
  static var departmant;
  static var joiningdate;
  static var visaexpdate;
  static var passportexpdate;
  static var medicalinsno;
  static var medicalinsexpdate;
  static var visacompanyname;
}

Future addemployees() async {
  Map updateempboday = {
    "emp_id": "${updatedata.empid}",
    'first_name': '${employeedetails.firstname}',
    'middle_name': '${employeedetails.middlename}',
    'surname': '${employeedetails.surname}',
    'passport_number': '${employeedetails.passportno}',
    'nationality': '${employeedetails.nationality}',
    'gender': '${employeedetails.gender}',
    'codes': '${employeedetails.codes}',
    'emirates_id': '${employeedetails.emiratesid}',
    'mobile_number': '${employeedetails.mobileno}',
    'email': '${employeedetails.email}',
    'designation': '${employeedetails.designation}',
    'department': '${employeedetails.departmant}',
    'joining_date': '${employeedetails.joiningdate}',
    'visa_exp_date': '${employeedetails.visaexpdate}',
    'passport_exp_date': '${employeedetails.passportexpdate}',
    'medical_ins_no': '${employeedetails.medicalinsno}',
    'medical_ins_exp_date': '${employeedetails.medicalinsexpdate}',
    'visa_company_name': '${employeedetails.visacompanyname}',
  };
  Map addempbody = {
    'first_name': '${employeedetails.firstname}',
    'middle_name': '${employeedetails.middlename}',
    'surname': '${employeedetails.surname}',
    'passport_number': '${employeedetails.passportno}',
    'nationality': '${employeedetails.nationality}',
    'gender': '${employeedetails.gender}',
    'codes': '${employeedetails.codes}',
    'emirates_id': '${employeedetails.emiratesid}',
    'mobile_number': '${employeedetails.mobileno}',
    'email': '${employeedetails.email}',
    'designation': '${employeedetails.designation}',
    'department': '${employeedetails.departmant}',
    'joining_date': '${employeedetails.joiningdate}',
    'visa_exp_date': '${employeedetails.visaexpdate}',
    'passport_exp_date': '${employeedetails.passportexpdate}',
    'medical_ins_no': '${employeedetails.medicalinsno}',
    'medical_ins_exp_date': '${employeedetails.medicalinsexpdate}',
    'visa_company_name': '${employeedetails.visacompanyname}',
  };
  print(addempbody);
  http.Response employees = await http.post(
    updatedata.employee == true ? updateemp : AddEmployee,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: updatedata.employee == true
        ? jsonEncode(updateempboday)
        : jsonEncode(addempbody),
  );
  print(employees.body);
}

class rolenames {
  static List<String> designation;
  static List<int> id;
}

Future getdesignations() async {
  Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
  http.Response responsedata = await http.post(
    designation,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(DBrequestData),
  );
  if (responsedata.statusCode == 200) {
    print('designations done');
    var decodeddata = jsonDecode(responsedata.body);
    rolenames.designation = [];
    rolenames.id = [];
    for (int u = 0; u < decodeddata['data'].length; u++) {
      rolenames.designation.add(decodeddata["data"][u]['name']);
      rolenames.id.add(decodeddata["data"][u]['id']);
    }
  }
  if (responsedata.statusCode != 200) {
    print(responsedata.statusCode);
  }
}
