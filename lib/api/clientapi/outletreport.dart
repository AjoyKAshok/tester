import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

// ignore: non_constant_identifier_names
Future OutletsForClient() async {
  Map dbRequestData = {'emp_id': '${DBrequestdata.receivedempid}'};

  print("OutletsForClient...${dbRequestData}");
  http.Response outletDetails = await http.post(
    clientoutletsurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(dbRequestData),
  );
  print('Status Code from Client Outlets : ${outletDetails.statusCode}');
  if (outletDetails.statusCode == 200) {
    print("cilent outlets received");
    String outletdetdata = outletDetails.body;
    var decodeoutlet = jsonDecode(outletdetdata);
    print('Outlet Data : $decodeoutlet');
    ClientOutlets.outletid = [];
    ClientOutlets.timesheetid = [];
    ClientOutlets.outletname = [];
    ClientOutlets.lastvisiteddate = [];
    ClientOutlets.checkintime = [];
    ClientOutlets.checkouttime = [];
    ClientOutlets.checkinlocation = [];
    ClientOutlets.checkoutlocation = [];
    ClientOutlets.merchandiserid = [];
    ClientOutlets.storeCode = [];
    for (int u = 0; u < decodeoutlet['data'].length; u++) {
      ClientOutlets.timesheetid.add(decodeoutlet['data'][u]['id']);
      ClientOutlets.outletid.add(decodeoutlet['data'][u]['outlet_id']);
      ClientOutlets.outletname.add(decodeoutlet['data'][u]['store_name'] ?? "");
      ClientOutlets.lastvisiteddate.add(decodeoutlet['data'][u]['date']);
      ClientOutlets.checkintime.add(decodeoutlet['data'][u]['checkin_time']);
      ClientOutlets.checkouttime.add(decodeoutlet['data'][u]['checkout_time']);
      ClientOutlets.checkinlocation
          .add(decodeoutlet['data'][u]['checkin_location']);
      ClientOutlets.checkoutlocation
          .add(decodeoutlet['data'][u]['checkout_location']);
      ClientOutlets.merchandiserid.add(decodeoutlet['data'][u]['employee_id']);
      ClientOutlets.storeCode.add(decodeoutlet['data'][u]['store_code']);
      ClientOutlets.outletmapingid.add(decodeoutlet['data'][u]['opm_id']);
      ClientOutlets.isschedulevisit
          .add(decodeoutlet['data'][u]['scheduled_calls']);
    }
    print("client outlets received");
  }
  if (outletDetails.statusCode != 200) {
    print(outletDetails.statusCode);
  }
}

class ClientOutlets {
  static List<int> outletid = [];
  static List<dynamic> timesheetid = [];
  static List<String> outletname = [];
  static List<dynamic> lastvisiteddate = [];
  static List<dynamic> checkintime = [];
  static List<dynamic> checkouttime = [];
  static List<dynamic> checkinlocation = [];
  static List<dynamic> checkoutlocation = [];
  static List<dynamic> merchandiserid = [];
  static List<dynamic> storeCode = [];
  static List<dynamic> outletmapingid = [];
  static List<dynamic> isschedulevisit = [];
}
