import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

//import 'package:merchandising/main.dart';
Future<void> clientPromoData() async {
  Map dbRequestData = {'outlet_id': currentoutletid};
  print(jsonEncode(dbRequestData));
  http.Response promoResponse = await http.post(
    clientpromodataurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(dbRequestData),
  );
  print(promoResponse.body);
  if (promoResponse.statusCode == 200) {
    print("getPromotion Details Done");
    String stores = promoResponse.body;
    var decodeStores = jsonDecode(stores);
    ClientPromo.reason = [];
    ClientPromo.productName = [];
    ClientPromo.imageUrl = [];
    ClientPromo.productNameoos = [];
    for (int u = 0; u < decodeStores['data'].length; u++) {
      if ('${decodeStores['data'][u]['is_available']}' == '1') {
        ClientPromo.productName.add(decodeStores['data'][u]['product_name']);
        ClientPromo.imageUrl.add(
            'https://test.rhapsody.ae/promotion_image/${decodeStores['data'][u]['image_url']}');
      } else {
        ClientPromo.productNameoos.add(decodeStores['data'][u]['product_name']);
        ClientPromo.reason.add(decodeStores['data'][u]['reason']);
      }
      ClientPromo.product.add(decodeStores['data'][u]['product_name']);
      ClientPromo.status.add(decodeStores['data'][u]['is_available']);
      ClientPromo.reasoning.add('${decodeStores['data'][u]['is_available']}' ==
              '1'
          ? 'https://test.rhapsody.ae/promotion_image/${decodeStores['data'][u]['image_url']}'
          : decodeStores['data'][u]['reason']);
    }
    print(ClientPromo.productName);
  }
  if (promoResponse.statusCode != 200) {
    print(promoResponse.statusCode);
  }
}

class ClientPromo {
  static List<String> reason = [];
  static List<String> imageUrl = [];
  static List<String> productName = [];
  static List<String> productNameoos = [];

  static List<String> product = [];
  static List<String> status = [];
  static List<String> reasoning = [];
}
