import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

var timesheetiddel;

Future<void> deletetimesheet() async {
  Map body = {"time_sheet_id": "$timesheetiddel"};
  http.Response response = await http.post(
    deltimesheet,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  print(response.body);
}
