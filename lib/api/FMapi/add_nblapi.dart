import 'dart:io';

import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

class AddNBLData {
  static var outletid;
  static File nblfile;
  static String nblfilename;
}

addnbl() async {
  var request = http.MultipartRequest("POST", FMAddNBL);
  request.fields['outlet_id'] = AddNBLData.outletid.toString();
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
  };
  request.headers.addAll(headers);
  request.files.add(await http.MultipartFile.fromPath(
    'nbl_file',
    AddNBLData.nblfile.path,
  ));
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  print(response.body);
}
