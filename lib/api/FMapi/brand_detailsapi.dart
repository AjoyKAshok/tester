import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getBrandDetails() async {
  http.Response BDResponse = await http.post(
    BrandDetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (BDResponse.statusCode == 200) {
    print("getBrandDetailsDone");
    String brand = BDResponse.body;
    var decodebrands = jsonDecode(brand);

    BrandData.brandname = [];
    BrandData.client = [];
    BrandData.fieldmanager = [];
    BrandData.salesmanager = [];
    BrandData.brandid = [];
    for (int u = 0; u < decodebrands['data'].length; u++) {
      dynamic brandname = decodebrands['data'][u]['brand_name'];
      BrandData.brandname.add(brandname);

      dynamic client =
          '${decodebrands['data'][u]['employee_client'][0]['first_name']} ${decodebrands['data'][u]['employee_client'][0]['surname']}(${decodebrands["data"][u]['employee_client'][0]['employee_id']})';
      BrandData.client.add(client);

      dynamic fieldmanager =
          '${decodebrands['data'][u]['employee_field'][0]['first_name']} ${decodebrands['data'][u]['employee_client'][0]['surname']}(${decodebrands["data"][u]['employee_field'][0]['employee_id']})';
      BrandData.fieldmanager.add(fieldmanager);

      dynamic salesmanager =
          '${decodebrands["data"][u]['employee_sales'][0]['first_name']} ${decodebrands['data'][u]['employee_client'][0]['surname']}(${decodebrands["data"][u]['employee_sales'][0]['employee_id']})';
      BrandData.salesmanager.add(salesmanager);

      var brandid = decodebrands['data'][u]['id'];
      BrandData.brandid.add(brandid);
    }
  }
  if (BDResponse.statusCode != 200) {
    print(BDResponse.statusCode);
  }
}

class BrandData {
  static List<String> brandname = [];
  static List<dynamic> client = [];
  static List<dynamic> fieldmanager = [];
  static List<dynamic> salesmanager = [];
  static List<int> brandid = [];
}
