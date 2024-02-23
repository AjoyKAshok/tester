import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';

import '../api_service2.dart';

class AddShareData {
  static var outletid;
  static List<int> target = [];
  static List<dynamic> categories = [];
  static List<int> mappingid = [];
}

addShareofshelffm() async {
  Map addshare = {
    "mapping_id": AddShareData.mappingid,
    "outlet_id": AddShareData.outletid,
    "category_id": AddShareData.categories,
    "target": AddShareData.target
  };
  print(jsonEncode(addshare));
  http.Response shareresponse = await http.post(
    addoutletshareofshelf,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(addshare),
  );
  print(shareresponse.body);
}

addplanogramfm() async {}
