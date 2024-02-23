import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/main.dart';
import 'api_service.dart';
import 'api_service2.dart';

class result {
  static var id;
  static var isapproved;
  static var isrejected;
}

Future<void> leaveacceptorreject() async {
  print(result.isapproved);
  print(result.isrejected);
  Map body = {
    "id": "${result.id}",
    "is_approved": "${result.isapproved}",
    "is_rejected": "${result.isrejected}"
  };
  print(body);
  http.Response response = await http.post(LeaveacceptReject,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(body));
  print(response.body);
}
