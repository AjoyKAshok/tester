import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

class Addweekoff {
  static var empid;
  static var month;
  static var day;
  static var year;
}

Future addweekoff() async {
  Map data = {
    'emp_id': '${Addweekoff.empid}',
    'month': '${Addweekoff.month}',
    'day': '${Addweekoff.day}',
    'year': '${Addweekoff.year}',
  };

  print(data);
  http.Response response = await http.post(
    AddWeekoff,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(data),
  );
  print(response.body);
  print("Add Week Off Done");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
