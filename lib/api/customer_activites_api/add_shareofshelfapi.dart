import 'dart:convert';
import 'dart:io';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:http/http.dart' as http;

import '../api_service2.dart';

class AddShareData {
  static var outletid;
  static var timesheetid;
  static List<dynamic> categoryid = [];
  static List<dynamic> categoryname = [];
  static List<dynamic> totalshare = [];
  static List<dynamic> share = [];
  static List<dynamic> target = [];
  static List<dynamic> actual = [];
  static List<dynamic> actualpercent = [];
  static List<String> reason = [];
  static var mappingid ;
}

Future addShareofshelfdata(bool connection) async {


  Map addshare = {
    'outlet_id': currentoutletid,
    'timesheet_id': currenttimesheetid,
    'category_name': AddShareData.categoryname,
    'outlet_products_mapping_id': AddShareData.mappingid,
    'category_id': AddShareData.categoryid,
    'total_share': AddShareData.totalshare,
    'share': AddShareData.share,
    'target': AddShareData.target,
    'actual': AddShareData.actualpercent,
    "reason": AddShareData.reason,
  };
  print(jsonEncode(addshare));


    try {
      http.Response shareresponse = await http.post(AddShareofshelf,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(addshare),
      );
      print("addshareofshelfbody...");
      print(shareresponse.body);
    }
    on SocketException catch (_) {
      print("offline share self");
      adddataforsync(
          "https://test.rhapsody.ae/api/add_share_of_shelf",
          jsonEncode(addshare),
          "Share of shelf added for the timesheet id $currenttimesheetid");
    }





}
