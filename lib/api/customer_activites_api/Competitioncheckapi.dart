import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/main.dart';
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getcompinfo() async {
  http.Response response = await http.post(
    getcompdetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (response.statusCode == 200) {
    competitiondata.company = [];
    competitiondata.brand = [];
    competitiondata.promotion = [];
    String body = response.body;
    var decodeddata = jsonDecode(body);
    for (int u = 0; u < decodeddata['data'].length; u++) {
      competitiondata.company.add(decodeddata['data'][u]['company_name']);
      competitiondata.brand.add(decodeddata['data'][u]['brand_name']);
      competitiondata.promotion.add(decodeddata['data'][u]['promotion_type']);
      competitiondata.descrptn
          .add(decodeddata['data'][u]['promotion_description']);

      if (decodeddata['data'][u]['capture_image'] != null &&
          currentuser.roleid == 5) {
        competitiondata.cptcmy.add(decodeddata['data'][u]['company_name']);
        competitiondata.cptmrp.add(decodeddata['data'][u]['mrp']);
        competitiondata.cptsellprice
            .add(decodeddata['data'][u]['selling_price']);
        competitiondata.cptimg.add(decodeddata['data'][u]['capture_image']);
        competitiondata.cptbrand.add(decodeddata['data'][u]['brand_name']);
      }
    }
    print(competitiondata.company);
  }
}

class competitiondata {
  static List<String> company = [];
  static List<String> brand = [];
  static List<String> promotion = [];
  static List<String> descrptn = [];

  static List<String> cptcmy = [];
  static List<String> cptbrand = [];
  static List<String> cptimg = [];
  static List<int> cptmrp = [];
  static List<int> cptsellprice = [];
}
