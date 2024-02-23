import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:merchandising/ConstantMethods.dart';

import '../api_service2.dart';

class AddPromo {
  static List<int> productid = [];
  static List<int> checkvalue = [];
  static List<String> reason = [];
}

Future<int> addPromotion(bool connection) async {
  Map addpromodata = {
    'outlet_id': currentoutletid,
    'timesheet_id': currenttimesheetid,
    'product_id': AddPromo.productid,
    'check_value': AddPromo.checkvalue,
    'reason': AddPromo.reason
  };
  print("addpromotion....$addpromodata");

      try{
  http.Response response = await http.post(MercAddPromotion,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(addpromodata),
  );
      print("promotion");
  print(response.body);
  return response.statusCode;
      }
      on SocketException catch (_) {
        adddataforsync(
            "https://test.rhapsody.ae/api/merchandiser_add_promotion__details",
            jsonEncode(addpromodata),
            "Promotion added for the timesheet id $currenttimesheetid");
        print("Add Promotion offline");
      }





  print(jsonEncode(addpromodata));


}
