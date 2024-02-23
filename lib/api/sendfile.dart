import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'api_service2.dart';

class reports {
  static File reportfile;
}

UploadFile() async {
  print(currenttimesheetid);
  var request = http.MultipartRequest("POST", Uploadfile);
  request.fields['timesheet_id'] = currenttimesheetid.toString();
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
  };
  request.headers.addAll(headers);
  request.files.add(await http.MultipartFile.fromPath(
    'report_file',
    reports.reportfile.path,
  ));
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  print(response.body);
}

Future<String> DownloadFile() async {
  Map body = {
    "time_sheet_id": currenttimesheetid,
  };
  print(jsonEncode(body));
  http.Response response = await http.post(
    downloadfile,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print('urls received');
    var decodeddata = jsonDecode(response.body);
    urls = [];
    for (int u = 0; u < decodeddata['data'].length; u++) {
      urls.add(
          'https://test.rhapsody.ae/excel_report_file/${decodeddata['data'][u]['file_name']}');
    }
  }
  print(urls);
  return urls[0];
}
List<String> urls = [];
