import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/main.dart';

import '../api_service2.dart';

Future getFMdb() async {
  Map body = {'emp_id': '${DBrequestdata.receivedempid}'};
  print("swathi response body before  ");
  print(body);
  http.Response DBresponse = await http.post(
    FMDashBoardurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  print("swathi response success after ");
  if (DBresponse.statusCode == 200) {
    print(DBresponse.statusCode);
    print("swathi response success ");
    print(DBresponse.body);
    String data = DBresponse.body;
    var decodeData = jsonDecode(data);
    FMdashboarddata.merchtotal = decodeData['Merchandiser'];
    FMdashboarddata.merchpresent = decodeData['MerchandiserPresent'];
    FMdashboarddata.merchabsent = decodeData['MerchandiserAbsent'];
    FMdashboarddata.mtotaloutlets = decodeData['Total_Outlets'];
    FMdashboarddata.mcompoutlets = decodeData['Total_Completed_Outlets'];
    FMdashboarddata.mpendingoutlets = decodeData['Total_Pending_Outlets'];
    FMdashboarddata.leavebalance = decodeData['AvailableLeave'];
    FMdashboarddata.leaveresponsetotal = decodeData['TotalLeaveReq'];
    FMdashboarddata.attendance = decodeData['Attendace'];
    FMdashboarddata.totaloulets = decodeData['Today_Outlets'];
    FMdashboarddata.compoutlets = decodeData['Today_Completed_Outlets'];
    FMdashboarddata.pendingoutlets = decodeData['Today_Pending_Outlets'];
    remaining.leaves = FMdashboarddata.leavebalance;
    print("FM DashBoard Done");
    return FMdashboarddata.pendingoutlets;
  }
  else{
    print("swathi response success ");
    print(DBresponse.statusCode);
    print(DBrequestdata.receivedtoken);
    print(DBresponse.body);
  };
}

class FMdashboarddata {
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
