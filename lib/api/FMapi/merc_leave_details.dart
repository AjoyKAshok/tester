import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:merchandising/main.dart';

import '../api_service2.dart';

Future<void> merchleavedetails() async {
  http.Response LDresponse = await http.post(
    currentuser.roleid == 3 ? LDurl : MercLeaveDetails,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (LDresponse.statusCode == 200) {
    leavedataResponse.reasons = [];
    leavedataResponse.leavetypes = [];
    leavedataResponse.totnoofdays = [];
    leavedataResponse.empname = [];
    leavedataResponse.empid = [];
    leavedataResponse.Startdates = [];
    leavedataResponse.enddates = [];
    leavedataResponse.requestedon = [];
    leavedataResponse.supportdocs = [];
    leavedataResponse.isleaveaccepted = [];
    leavedataResponse.isleaverejected = [];
    print('merchandisers leave Details Done');
    String LDdata = LDresponse.body;
    var decodeLDData = jsonDecode(LDdata);
    for (int u = 0; u < decodeLDData['data'].length; u++) {
      if (currentuser.roleid == 3) {
        if (decodeLDData['data'][u]['is_approved'] == '1' ||
            decodeLDData['data'][u]['is_approved'] == '2') {
          dynamic id = decodeLDData['data'][u]['lrid'];
          leavedataResponse.leaveid.add(id);
          dynamic reason = decodeLDData['data'][u]['reason'];
          leavedataResponse.reasons.add(reason);
          dynamic type = decodeLDData['data'][u]['leavetype'];
          leavedataResponse.leavetypes.add(type);
          dynamic totnoofdays = decodeLDData['data'][u]['total_days'];
          leavedataResponse.totnoofdays.add(totnoofdays);
          dynamic empid = decodeLDData['data'][u]['employee_id'];
          leavedataResponse.empid.add(empid);
          dynamic empname =
              ('${decodeLDData["data"][u]['employee']['first_name']} ${decodeLDData["data"][u]['employee']['surname']}');
          leavedataResponse.empname.add(empname);
          dynamic startdate = decodeLDData['data'][u]['leavestartdate'];
          leavedataResponse.Startdates.add(startdate);

          dynamic enddate = decodeLDData['data'][u]['leaveenddate'];
          leavedataResponse.enddates.add(enddate);

          dynamic requeston = decodeLDData['data'][u]['created_at'];
          leavedataResponse.requestedon.add(requeston);

          String isrejected = decodeLDData['data'][u]['is_rejected'];
          leavedataResponse.isleaverejected.add(isrejected);

          String isaccepted = decodeLDData['data'][u]['is_approved'];
          leavedataResponse.isleaveaccepted.add(isaccepted);

          dynamic suppdoc = decodeLDData['data'][u]['supportingdocument'];
          leavedataResponse.supportdocs.add(suppdoc);
        }
      } else {
        dynamic id = decodeLDData['data'][u]['lrid'];
        leavedataResponse.leaveid.add(id);
        dynamic reason = decodeLDData['data'][u]['reason'];
        leavedataResponse.reasons.add(reason);
        dynamic type = decodeLDData['data'][u]['leavetype'];
        leavedataResponse.leavetypes.add(type);
        dynamic totnoofdays = decodeLDData['data'][u]['total_days'];
        leavedataResponse.totnoofdays.add(totnoofdays);
        dynamic empid = decodeLDData['data'][u]['employee_id'];
        leavedataResponse.empid.add(empid);
        dynamic empname =
            ('${decodeLDData["data"][u]['employee']['first_name']} ${decodeLDData["data"][u]['employee']['surname']}');
        leavedataResponse.empname.add(empname);
        dynamic startdate = decodeLDData['data'][u]['leavestartdate'];
        leavedataResponse.Startdates.add(startdate);

        dynamic enddate = decodeLDData['data'][u]['leaveenddate'];
        leavedataResponse.enddates.add(enddate);

        dynamic requeston = decodeLDData['data'][u]['created_at'];
        leavedataResponse.requestedon.add(requeston);

        String isrejected = decodeLDData['data'][u]['is_rejected'];
        leavedataResponse.isleaverejected.add(isrejected);

        String isaccepted = decodeLDData['data'][u]['is_approved'];
        leavedataResponse.isleaveaccepted.add(isaccepted);

        dynamic suppdoc = decodeLDData['data'][u]['supportingdocument'];
        leavedataResponse.supportdocs.add(suppdoc);
      }
    }
  }
}

class leavedataResponse {
  static List<dynamic> leaveid = [];
  static List<dynamic> reasons = [];
  static List<dynamic> leavetypes = [];
  static List<dynamic> totnoofdays = [];
  static List<dynamic> empname = [];
  static List<dynamic> empid = [];
  static List<dynamic> Startdates = [];
  static List<dynamic> enddates = [];
  static List<dynamic> requestedon = [];
  static List<dynamic> isleaverejected = [];
  static List<dynamic> isleaveaccepted = [];
  static List<dynamic> supportdocs = [];
}
