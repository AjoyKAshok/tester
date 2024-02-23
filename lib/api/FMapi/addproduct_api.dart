import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/Fieldmanager/add_product.dart';
import '../api_service.dart';
import '../api_service2.dart';

class Product {
  static var name;
  static var sku;
  static var type;
  static var range;
  static var zrepcode;
  static var piecepercartoon;
  static var priceperpiece;
  static var brandname;
  static var clientid;
  static var category;
  static var imageurl;
}

Future addproduct() async {
  Map product = {
    'sku': '${Product.sku}',
    'product_name': '${Product.name}',
    'type': '${Product.type}',
    'range': '${Product.range}',
    'zrep_code': '${Product.zrepcode}',
    'piece_per_carton': '${Product.piecepercartoon}',
    'price_per_piece': '${Product.priceperpiece}',
    'brand_id': '${Product.brandname}',
    'client_id': '${Product.clientid}',
    'product_categories': '${Product.category}',
    'Image_url': '${Product.imageurl}',
  };
  http.Response addproduct = await http.post(
    AddProducts,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(product),
  );
  print(addproduct.body);
  print("Add Products Done");
}
