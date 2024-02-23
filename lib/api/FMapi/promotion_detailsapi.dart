import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getPromoDetails() async {
  Map DBrequestData = {
    'outlet_id': currentoutletid,
  };
  print(DBrequestData);
  http.Response promoresponse = await http.post(
    PromoDetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(DBrequestData),
  );
  if (promoresponse.statusCode == 200) {
    print("getPromotion Details Done");
    print(promoresponse.body);
    String stores = promoresponse.body;
    var decodestores = jsonDecode(stores);
    PromoData.outletid = [];
    PromoData.productname = [];
    PromoData.fromdate = [];
    PromoData.todate = [];
    PromoData.description = [];
    PromoData.storename = [];
    PromoData.productid = [];
    print(decodestores['data'].length);
    for (int u = 0; u < decodestores['data'].length; u++) {
      PromoData.productname.add(decodestores['data'][u]['product_name']);

      PromoData.outletid.add(decodestores['data'][u]['outlet_id']);
      PromoData.storename.add(decodestores['data'][u]['store_name']);

      PromoData.fromdate.add(decodestores['data'][u]['from_date']);
      PromoData.productid.add(decodestores['data'][u]['product_id']);

      PromoData.todate.add(decodestores['data'][u]['to_date']);

      PromoData.description.add(decodestores['data'][u]['description']);
    }
  }
  if (promoresponse.statusCode != 200) {
    print(promoresponse.statusCode);
  }
}

class PromoData {
  static List<int> outletid = [];
  static List<String> storename = [];
  static List<String> productname = [];
  static List<String> fromdate = [];
  static List<String> todate = [];
  static List<String> description = [];
  static List<int> productid = [];
}
