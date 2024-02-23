import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getCategoryDetails() async {
  http.Response CDResponse = await http.post(
    CategoryDetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (CDResponse.statusCode == 200) {
    print("getCategoryDetailsDone");

    String category = CDResponse.body;
    var decodededcategory = jsonDecode(category);

    Category.name = [];
    Category.id = [];

    for (int u = 0; u < decodededcategory['data'].length; u++) {
      dynamic categoryname = decodededcategory['data'][u]['category_name'];
      Category.name.add(categoryname);
      var categoryid = decodededcategory['data'][u]['id'];
      Category.id.add(categoryid);
    }
  }
  print(Category.name);
  if (CDResponse.statusCode != 200) {
    print(CDResponse.statusCode);
  }
}

class Category {
  static List<String> name = [];
  static List<int> id = [];
}
