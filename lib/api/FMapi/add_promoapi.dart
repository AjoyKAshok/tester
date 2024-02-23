import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

class AddPromo {
  static var outletid;
  static List<int> productid = [];
  static var fromdate;
  static var todate;
  static var description;
  static List<String> imgurl = [];
}

Future addpromodetails() async {
  Map promodata = {
    'outlet_id': AddPromo.outletid,
    'product_id': AddPromo.productid,
    'from_date': '${AddPromo.fromdate}',
    'to_date': '${AddPromo.todate}',
    'description': '${AddPromo.description}',
    'img_url': AddPromo.imgurl
  };
  print(jsonEncode(promodata));
  http.Response response = await http.post(
    AddPromotion,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(promodata),
  );
  print(response.body);
  print("Add Promotion Done");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
