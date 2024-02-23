import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/HRapi/empdetailsforreportapi.dart';

import '../api_service2.dart';

Future addreportcde() async {
  Map newreport = {
    "merchandiser_id": "${Addrepcdedata.merchandiserid}",
    "cde_id": "${Addrepcdedata.cdeid}",
    "reporting_date": "${Addrepcdedata.startdate}",
    "reporting_end_date": "${Addrepcdedata.enddate}"
  };
  print("addreportcde.....");
  print(jsonEncode(newreport));
  http.Response response = await http.post(
    AddReportCDE,
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

class Addrepcdedata {
  static String merchandiserid;
  static String cdeid;
  static String startdate;
  static String enddate;
}
