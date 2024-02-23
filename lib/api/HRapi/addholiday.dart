import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/holidays.dart';

import '../api_service2.dart';

void addholiday() async {
  Map newholiday = {
    "date": "${addholidays.date}",
    "description": "${addholidays.description}"
  };
  print(newholiday);
  http.Response response = await http.post(
    addholidayurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(newholiday),
  );
  if (response.statusCode == 200) {
    print(response.body);
    holidaysdata();
  } else {
    print(response.body);
  }
}

class addholidays {
  static String date;
  static String description;
}
