import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';

import '../api_service2.dart';

Future<void> getCompetition() async {
  http.Response competitionresponse = await http.post(
    CompetitionDetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (competitionresponse.statusCode == 200) {
    CompetitionData.brandname = [];
    CompetitionData.timesheetid = [];
    CompetitionData.companyname = [];
    CompetitionData.itemname = [];
    CompetitionData.promotype = [];
    CompetitionData.promodesc = [];
    CompetitionData.mrp = [];
    CompetitionData.sellingprice = [];
    CompetitionData.captureimg = [];

    print('Competion Check Details done');

    String competition = competitionresponse.body;
    var decodeddata = jsonDecode(competition);
    for (int u = 0; u < decodeddata['data'].length; u++) {
      if (decodeddata['data'][u]['timesheet_id'].toString() ==
          "$currenttimesheetid") {
        CompetitionData.brandname.add(decodeddata['data'][u]['brand_name']);
        CompetitionData.companyname.add(decodeddata['data'][u]['company_name']);
        CompetitionData.itemname.add(decodeddata['data'][u]['item_name']);
        CompetitionData.promotype.add(decodeddata['data'][u]['promotion_type']);
        CompetitionData.promodesc
            .add(decodeddata['data'][u]['promotion_description']);
        CompetitionData.mrp.add(decodeddata['data'][u]['mrp']);
        CompetitionData.sellingprice
            .add(decodeddata['data'][u]['selling_price']);
        CompetitionData.captureimg.add(
            'https://test.rhapsody.ae/competitor/${decodeddata['data'][u]['capture_image']}');
      }
    }
    print(CompetitionData.brandname);
  }
}

class CompetitionData {
  static List<String> brandname = [];
  static List<int> timesheetid = [];
  static List<String> companyname = [];
  static List<String> itemname = [];
  static List<String> promotype = [];
  static List<String> promodesc = [];
  static List<int> mrp = [];
  static List<int> sellingprice = [];
  static List<String> captureimg = [];
}
