import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

class brandmap {
  static var outletid;
  static var brandid;
  static var shelf;
  static var target;
  static var myfile;
}

Future addbrandmap() async {
  Map storedata = {
    'outlet_id': brandmap.outletid,
    'brand_id': brandmap.brandid,
    'shelf': brandmap.shelf,
    'target': brandmap.target,
    'myfile': brandmap.myfile
  };
  print(jsonEncode(storedata));
  http.Response ouletbrandmap = await http.post(
    Addoutletbrandmap,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(storedata),
  );
  print(ouletbrandmap.body);
}
