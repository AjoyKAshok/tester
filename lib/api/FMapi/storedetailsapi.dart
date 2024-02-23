import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getStoreDetails() async {
  Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
  print(DBrequestData);
  http.Response SDResponse = await http.post(
    StoreDetailsurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(DBrequestData),
  );
  if (SDResponse.statusCode == 200) {
    print("getStoreDetailsDone");
    String stores = SDResponse.body;
    var decodestores = jsonDecode(stores);
    storesdata.id = [];
    storesdata.storecode = [];
    storesdata.storename = [];
    storesdata.storecontnum = [];
    storesdata.storeaddress = [];
    for (int u = 0; u < decodestores['data'].length; u++) {
      String storecode = decodestores['data'][u]['store_code'];
      storesdata.storecode.add(storecode);
      storesdata.id.add(decodestores['data'][u]['id']);
      storesdata.storename
          .add('[$storecode] ${decodestores['data'][u]['store_name']}');
      dynamic contactnumber = decodestores['data'][u]['contact_number'];
      storesdata.storecontnum.add(contactnumber);
      dynamic storeaddress = decodestores['data'][u]['address'];
      storesdata.storeaddress.add(storeaddress);
    }
  }
  // print(storesdata.storecode[0]);
  // print(storesdata.storename[0]);
  if (SDResponse.statusCode != 200) {
    print(SDResponse.statusCode);
  }
}

class storesdata {
  static List<int> id = [];
  static List<String> storecode = [];
  static List<String> storename = [];
  static List<dynamic> storecontnum = [];
  static List<dynamic> storeaddress = [];
}
