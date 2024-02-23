import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'api_service2.dart';

Future holidaysdata() async {
  http.Response holidaysdata = await http.post(
    holidaysdataurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (holidaysdata.statusCode == 200) {
    holidays.dates = [];
    holidays.description = [];
    String responsedata = holidaysdata.body;
    var decodeddata = jsonDecode(responsedata);
    for (int u = 0; u < decodeddata['data'].length; u++) {
      holidays.dates.add(decodeddata['data'][u]['date']);
      holidays.description.add(decodeddata['data'][u]['description']);
    }
  }
  if (holidaysdata.statusCode != 200) {
    print(holidaysdata.statusCode);
  }
}

class holidays {
  static List<String> dates = [];
  static List<dynamic> description = [];
}
