import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:intl/intl.dart';

import '../api_service2.dart';

class addunschdulejp {
  static var date;
  static List<int> outletid;
  static var empid;
}

Future addunschdulejourneypaln() async {
  Map body = {
    "emp_id": "${addunschdulejp.empid}",
    "date": "${addunschdulejp.date}",
    "outlet_id": addunschdulejp.outletid
  };
  print(body);
  http.Response response = await http.post(
    unschdulejp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

class addschdulejp {
  static var date;
  static List<int> outletid;
  static List<String> days;
  static var empid;
  static var month;
  static var year;
}

Future addschdulejourneypaln() async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy');
  final String thisyear = formatter.format(now);
  Map body = {
    "emp_id": '${addschdulejp.empid}',
    "month": addschdulejp.month,
    "days": addschdulejp.days,
    "year": thisyear,
    "outlet_id": addschdulejp.outletid
  };
  print(jsonEncode(body));
  http.Response response = await http.post(
    schdulejp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
