/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
class AddVisiData{
  static var outletid;
  static var timesheetid;
  static List<dynamic> mappingids = [];
  static List<dynamic> brandid=[];
  static List<dynamic> brandname=[];
  static List<dynamic> planoimage=[];
  static List<dynamic> planobeforeimage=[];
  static List<dynamic> planoafterimage = [];
}

Future addplanogramdata() async{
  Map addvisibility = {
    "outlet_id" : currentoutletid,
    "timesheet_id" : currenttimesheetid,
    "outlet_products_mapping_id": PlanoDetails.opm,
    "brand_id" : PlanoDetails.brandid,
    "brand_name" : PlanoDetails.brandname,
    "plano_image" : PlanoDetails.image,
    "before_image" : PlanoDetails.beforeimage,
    "after_image" : PlanoDetails.afterimage,
  };
  print(jsonEncode(addvisibility));
  http.Response availresponse = await http.post(AddPlanogram,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(addvisibility),
  );
  print(availresponse.body);
}*/
