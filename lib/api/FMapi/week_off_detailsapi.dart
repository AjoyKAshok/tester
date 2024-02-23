import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getWeekoffdetails() async {
  http.Response response = await http.post(
    Weekoffdetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (response.statusCode == 200) {
    print("getWeekoff Details Done");
    String weekoff = response.body;
    var decodeddata = jsonDecode(weekoff);
    Weekoff.empname = [];
    Weekoff.empid = [];
    Weekoff.month = [];
    Weekoff.day = [];
    Weekoff.year = [];
    for (int u = 0; u < decodeddata['data'].length; u++) {
      Weekoff.empid.add('${decodeddata["data"][u]['employee_id']}');
      Weekoff.empname.add('${decodeddata["data"][u]['first_name']} '
          '(${decodeddata["data"][u]['employee_id']})');
      Weekoff.month.add(decodeddata['data'][u]['month']);
      Weekoff.day.add(decodeddata['data'][u]['day']);
      Weekoff.year.add(decodeddata['data'][u]['year']);
    }
  }
  if (response.statusCode != 200) {
    print(response.statusCode);
  }
}

class Weekoff {
  static List<dynamic> empid = [];
  static List<String> empname = [];
  static List<dynamic> month = [];
  static List<dynamic> day = [];
  static List<dynamic> year = [];
}
