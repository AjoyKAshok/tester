import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/HRapi/empdetailsforreportapi.dart';

import '../api_service2.dart';

Future addreport() async {
  Map newreport = {
    "employee_id": "${report.merchandiserid}",
    "reporting_to_emp_id": "${report.feildmanagerid}",
    "reporting_date": "${report.startdate}",
    "reporting_end_date": "${report.enddate}"
  };
  print(newreport);
  http.Response response = await http.post(
    addreportaurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(newreport),
  );
  if (response.statusCode == 200) {
    print(response.body);
    getempdetailsforreport();
  } else {
    print(response.body);
  }
}

class report {
  static String merchandiserid;
  static String feildmanagerid;
  static String startdate;
  static String enddate;
}
