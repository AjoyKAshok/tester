import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';
import 'category_detailsapi.dart';

class CategorytoAdd {
  static var name;
}

Future addcategory() async {
  Map category = {
    'category_name': '${CategorytoAdd.name}',
  };
  http.Response addcategory = await http.post(
    AddCategory,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(category),
  );
  print(addcategory.body);
  if (addcategory.statusCode == 200) {
    await getCategoryDetails();
  }
}

class CategoryOutletmap {
  static var outletid;
  static var clientid;
  static List<dynamic> categoryid = [];
}

Future addcategoryoutletmap() async {
  Map categoryom = {
    "outlet_id": currentoutletid,
    "client_id": CategoryOutletmap.clientid,
    "categories": CategoryOutletmap.categoryid
  };
  print(' add categories : ${jsonEncode(categoryom)}');
  http.Response categorymap = await http.post(
    AddOutletMap,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(categoryom),
  );
  print(categorymap.body);
}
