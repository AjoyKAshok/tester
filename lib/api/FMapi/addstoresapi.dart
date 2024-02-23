import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

class storedetails {
  static var storecode;
  static var storename;
  static var contactnumber;
  static var address;
}

Future addstoredetails() async {
  Map storedata = {
    'store_code': '${storedetails.storecode}',
    'store_name': '${storedetails.storename}',
    'contact_number': '${storedetails.contactnumber}',
    'address': '${storedetails.address}',
  };
  http.Response stores = await http.post(
    AddStoreurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(storedata),
  );
//print(stores.body);
  print("Add Stores Done");
}
