import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';
import 'brand_detailsapi.dart';

class BrandDetails {
  static var brandname;
  static var fieldmanagerempid;
  static var salesempid;
  static var clientempid;
}

Future addbranddetails() async {
  Map branddata = {
    'brand_name': '${BrandDetails.brandname}',
    'field_manager_id': '${BrandDetails.fieldmanagerempid}',
    'sales_manager_id': '${BrandDetails.salesempid}',
    'client_id': '${BrandDetails.clientempid}',
  };
  print(jsonEncode(branddata));
  http.Response brand = await http.post(
    AddBrand,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(branddata),
  );
  print(brand.body);
  if (brand.statusCode == 200) {
    await getBrandDetails();
  }
}

Future getemployeestoaddbrand() async {
  Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
  http.Response Empforbrand = await http.post(
    empdetailsurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(DBrequestData),
  );
  if (Empforbrand.statusCode == 200) {
    print('Employees to Add Brand done');
    String empdata = Empforbrand.body;
    var decodedempdata = jsonDecode(empdata);

    employees.client = [];
    employees.feildmanagers = [];
    employees.sales = [];

    for (int u = 0; u < decodedempdata['data'].length; u++) {
      decodedempdata['data'][u]['role'][0]['id'] == 5
          ? employees.feildmanagers.add(
              '${decodedempdata["data"][u]['first_name']} ${decodedempdata["data"][u]['surname']}(${decodedempdata["data"][u]['employee_id']})')
          : null;
      decodedempdata['data'][u]['role'][0]['id'] == 7
          ? employees.client.add(
              '${decodedempdata["data"][u]['first_name']} ${decodedempdata["data"][u]['surname']}(${decodedempdata["data"][u]['employee_id']})')
          : null;
      decodedempdata['data'][u]['role'][0]['id'] == 9
          ? employees.sales.add(
              '${decodedempdata["data"][u]['first_name']} ${decodedempdata["data"][u]['surname']}(${decodedempdata["data"][u]['employee_id']})')
          : null;
    }
  }
  if (Empforbrand.statusCode != 200) {
    print(Empforbrand.statusCode);
  }
}

class employees {
  static List<String> client = [];
  static List<String> feildmanagers = [];
  static List<String> sales = [];
}
