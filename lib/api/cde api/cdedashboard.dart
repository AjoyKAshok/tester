import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/main.dart';

import '../api_service2.dart';

Future getCDEdb() async {
  Map body = {'emp_id': '${DBrequestdata.receivedempid}'};
  print(body);
  http.Response dbResponse = await http.post(
    CDEdashboard,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  if (dbResponse.statusCode == 200) {
    String data = dbResponse.body;
    var decodeData = jsonDecode(data);
    CDEDBdata.merchtotal = decodeData['total_merchandisers'];
    CDEDBdata.merchpresent = decodeData['present_merchandisers'];
    CDEDBdata.merchabsent = decodeData['absent_merchandisers'];
    CDEDBdata.mtotaloutlets = decodeData['total_outlets'];
    CDEDBdata.mcompoutlets = decodeData['completed_outlets'];
    CDEDBdata.mpendingoutlets = decodeData['pending_outlets'];

    CDEDBdata.totaloulets = decodeData['today_outlets'];
    CDEDBdata.compoutlets = decodeData['today_completed'];
    CDEDBdata.pendingoutlets = decodeData['today_pending'];
    remaining.leaves = CDEDBdata.leavebalance;
    print("CDE DashBoard Done");
    return CDEDBdata.pendingoutlets;
  }
}

class CDEDBdata {
  static var merchtotal;
  static int merchpresent;
  static int merchabsent;
  static int totaloulets;
  static int compoutlets;
  static int pendingoutlets;
  static int mtotaloutlets;
  static int mcompoutlets;
  static int mpendingoutlets;
  static int leaveresponsetotal;
  static int leavebalance;
  static int attendance;
}
