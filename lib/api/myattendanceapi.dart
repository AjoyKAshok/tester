import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:intl/intl.dart';

import 'api_service2.dart';

Future getmyattandance() async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String todaydate = formatter.format(now);
  Map empattenddata = {
    'emp_id': '${DBrequestdata.receivedempid}',
    'month': '$todaydate',
  };

  http.Response Attendancedetails = await http.post(
    Attendance,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(empattenddata),
  );
  print(jsonEncode(empattenddata));

  if (Attendancedetails.statusCode == 200) {
    print("get Attendance Done");

    String attendancedet = Attendancedetails.body;
    var decodedattendance = jsonDecode(attendancedet);
    presentlist.date = [];
    presentlist.checkin = [];
    presentlist.checkout = [];
    absentlist.date = [];
    absentlist.approvedby = [];

    for (int u = 0; u < decodedattendance['data'].length; u++) {
      var result = decodedattendance['data'][u]['is_present'];
      if (result == '1') {
        presentlist.date.add(decodedattendance['data'][u]['date']);
        presentlist.checkin.add(decodedattendance['data'][u]['checkin_time']);
        presentlist.checkout.add(
            decodedattendance['data'][u]['checkout_time'] == null
                ? '-'
                : decodedattendance['data'][u]['checkout_time']);
      } else {
        absentlist.date.add(decodedattendance['data'][u]['date']);
        absentlist.approvedby
            .add(decodedattendance['data'][u]['leave_approved_by']);
      }
      if (decodedattendance['data'][u]['date'] == todaydate) {
        print(decodedattendance['data'][u]['date']);
        print("${todaydate}");
        noattendance.noatt = "attadded";
      }
    }
    print(presentlist.date);
    print(presentlist.checkin);
    print(presentlist.checkout);
  }
  if (Attendancedetails.statusCode != 200) {
    // print(Attendancedetails.statusCode);

  }
}

class presentlist {
  static List<dynamic> date = [];
  static List<dynamic> checkin = [];
  static List<dynamic> checkout = [];
}

class absentlist {
  static List<dynamic> date = [];
  static List<dynamic> approvedby = [];
}

class noattendance {
  static String noatt;
}
