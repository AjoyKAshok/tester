import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:merchandising/network/NetworkStatusService.dart';


import 'package:provider/provider.dart';
import '../api_service.dart';
import 'package:merchandising/ConstantMethods.dart';

import '../api_service2.dart';

class AddAvail {
  static var outletid;
  static var timesheetid;
  static List<dynamic> productid = [];
  static List<dynamic> brandname = [];
  static List<dynamic> categoryname = [];
  static List<dynamic> productname = [];
  static List<dynamic> checkvalue = [];
  static List<dynamic> reason = [];
}

Future addAvailability(bool connection) async {
  Map addavailability = {
    "outlet_id": currentoutletid,
    "timesheet_id": currenttimesheetid,
    'outlet_products_mapping_id': comid,
    "product_id": AddAvail.productid,
    "brand_name": AddAvail.brandname, //jsonEncode(AddAvail.brandname),
    "category_name": AddAvail.categoryname, //jsonEncode(AddAvail.categoryname),
    "product_name": AddAvail.productname, //jsonEncode(AddAvail.productname),
    "check_value": AddAvail.checkvalue,
    "reason": AddAvail.reason
  };
  print("AVAILABILTIY...${AddAvail.reason}");
  print("CHECKVALUE...${AddAvail.checkvalue}");
  print(jsonEncode(addavailability));


      try {
        http.Response availresponse = await http.post(AddAvailability,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
          },
          body: jsonEncode(addavailability),
        );
        print(availresponse.body);
        print("Add Availability Done");
        print("online");
      }
      on SocketException catch (_) {
        adddataforsync(
            "https://test.rhapsody.ae/api/add_availability",
            jsonEncode(addavailability),
            "Availability added for the timesheet id $currenttimesheetid");
        print("catch blk ");
      }






}
