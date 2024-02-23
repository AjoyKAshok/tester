import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Visibility.dart';
import 'package:merchandising/ConstantMethods.dart';

import '../api_service2.dart';

class AddVisiData {
  static int outletid;
  static int timesheetid;
  static List<int> productid = [];
  static List<int> brandid = [];
  static List<int> categoryid = [];
  static List<dynamic> categoryname = [];
  static List<dynamic> productname = [];
  static List<int> checkvalue = [];
  static List<String> reason = [];
  static List<String> area = [];
  static List<String> sos = [];
  static List<String> poi = [];
  static var outletpdtmap;
}

Future addVisibilitydata(bool connection) async {
  Map addvisibility = {
    'outlet_id': currentoutletid,
    'timesheet_id': currenttimesheetid,
    'outlet_products_mapping_id': AddVisiData.outletpdtmap,
    'category_id': AddVisiData.categoryid,
    'category_name': AddVisiData.categoryname,
    'check_value': AddVisiData.checkvalue,
    'reason': AddVisiData.reason,
    "g_area": AddVisiData.area,
    "main_aisle": AddVisiData.sos,
    "pois": AddVisiData.poi
  };
  print("addVisibilitydata...${AddVisiData.outletpdtmap}");
  print(jsonEncode(addvisibility));



    try{
    http.Response availresponse = await http.post(
    AddVisibility,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(addvisibility),
  );
  print(availresponse.body);
    print("Add Visibility done");}
    on SocketException catch (_) {
      print("Add Visibility done offline");
      adddataforsync(
          "https://test.rhapsody.ae/api/add_visibility",
          jsonEncode(addvisibility),
          "Visibility added for the timesheet id $currenttimesheetid");
    }





}
