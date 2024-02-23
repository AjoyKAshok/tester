import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';

import '../api_service2.dart';

Future<void> getShareofshelf() async {
  Map body = {
    "time_sheet_id": checkinoutdata.checkid,
  };
  http.Response shareresponse = await http.post(
    ShareofshelfDetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  if (shareresponse.statusCode == 200) {
    print(body);
    ShareData.brandname = [];
    ShareData.brandid = [];
    ShareData.share = [];
    ShareData.total = [];
    ShareData.target = [];
    ShareData.actual = [];

    print('Share of Shelf done');

    String availabititybody = shareresponse.body;
    var decodeddata = jsonDecode(availabititybody);
    for (int u = 0; u < decodeddata['data'].length; u++) {
      ShareData.brandname.add(decodeddata['data'][u]['b_name']);
      ShareData.brandid.add(decodeddata['data'][u]['b_id']);
      ShareData.share.add(decodeddata['data'][u]['share']);
      ShareData.target.add(decodeddata['data'][u]['target']);
      ShareData.actual.add(decodeddata['data'][u]['actual']);
      ShareData.total.add(decodeddata['data'][u]['total_share']);
    }
    print(ShareData.brandname);
  }
}

class ShareData {
  static List<String> brandname = [];
  static List<String> share = [];
  static List<String> total = [];
  static List<String> target = [];
  static List<String> actual = [];
  static List<int> brandid = [];
}
