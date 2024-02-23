import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../api_service.dart';
import 'package:merchandising/ConstantMethods.dart';

import '../api_service2.dart';

class AddPlanoData {
  static var outletid;
  static var timesheetid;
  static var outletpdtmapid;
  static List<dynamic> categoryid = [];
  static List<dynamic> planoimage = [];
  static List<dynamic> beforeimage = [];
  static List<dynamic> afterimage = [];
  static List<dynamic> categoryname = [];
}

Future addPlanogramdata(bool connection) async {
  print("addPlanogramdata...$connection");
  Map addplano = {
    "outlet_id": AddPlanoData.outletid,
    "timesheet_id": AddPlanoData.timesheetid,
    "outlet_products_mapping_id": comid,
    "category_name": AddPlanoData.categoryname,
    "category_id": AddPlanoData.categoryid,
    "plano_image": AddPlanoData.planoimage,
    "before_image": AddPlanoData.beforeimage,
    "after_image": AddPlanoData.afterimage,
  };

  print(jsonEncode(addplano));


      try {
        http.Response planoresponse = await http.post(AddPlanogram,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
          },
          body: jsonEncode(addplano),
        );

        print(jsonEncode(addplano));
        print(planoresponse.body);
        print("Add Planogram Done");
      }
      on SocketException catch (_) {
        print("Add Planogram Done offline");
        adddataforsync(
            "https://test.rhapsody.ae/api/add_planogram",
            jsonEncode(addplano),
            "Planogram added for the timesheet id $currenttimesheetid");
      }






}
