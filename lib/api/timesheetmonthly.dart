import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/api_service.dart';
import 'package:intl/intl.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/timesheetmonthly.dart';
import 'package:merchandising/api/timesheetapi.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Time Sheet.dart';

import 'api_service2.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String todaydate = formatter.format(now);
List dataofdates = [];
List<dynamic> listOfDatesapi;

Future<void> gettimesheetmonthly() async {
  listOfDatesapi = new List<String>.generate(
      daysInMonth(DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())),
          int.parse(DateFormat('mm').format(DateTime.now())))),
      (i) =>
          "${int.parse(DateFormat('yyyy').format(DateTime.now()))}-${DateFormat('MM').format(DateTime.now())}-${'${i + 1}'.toString().padLeft(2, "0")}");
  Map request = {
    "emp_id": "${DBrequestdata.receivedempid}",
    "month": "$todaydate"
  };
  Map fmrequest = {"emp_id": "${timesheet.empid}", "month": "$todaydate"};
  print("Month request for TS ------------> ${request}");
  print("Time Sheet Month Log---->${request}");

  try {
    http.Response dataresponse = await http.post(
      TSSplitMurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body:
          currentuser.roleid == 6 ? jsonEncode(request) : jsonEncode(fmrequest),
    );
    if (dataresponse.statusCode == 200) {
      TMmonthly.day1 = [];
      TMmonthly.day2 = [];
      TMmonthly.day3 = [];
      TMmonthly.day4 = [];
      TMmonthly.day5 = [];
      TMmonthly.day6 = [];
      TMmonthly.day7 = [];
      TMmonthly.day8 = [];
      TMmonthly.day9 = [];
      TMmonthly.day10 = [];
      TMmonthly.day11 = [];
      TMmonthly.day12 = [];
      TMmonthly.day13 = [];
      TMmonthly.day14 = [];
      TMmonthly.day15 = [];
      TMmonthly.day16 = [];
      TMmonthly.day17 = [];
      TMmonthly.day18 = [];
      TMmonthly.day19 = [];
      TMmonthly.day20 = [];
      TMmonthly.day21 = [];
      TMmonthly.day22 = [];
      TMmonthly.day23 = [];
      TMmonthly.day24 = [];
      TMmonthly.day25 = [];
      TMmonthly.day26 = [];
      TMmonthly.day27 = [];
      TMmonthly.day28 = [];
      TMmonthly.day29 = [];
      TMmonthly.day30 = [];
      TMmonthly.day31 = [];
      String data = dataresponse.body;
      var decodeData = jsonDecode(data);
      print('Decoded Data from API : $decodeData');
      print(decodeData['data'].length);
      print('length : ${listOfDatesapi.length}');
      dataofdates = [];
      for (int u = 0; u < decodeData['data'].length; u++) {
        String date = decodeData['data'][u]['date'];
        print(date);
        if (dataofdates.contains(date)) {
        } else {
          dataofdates.add(date);
          dataofdates.sort();
        }

        if (date == listOfDatesapi[1 - 1]) {
          TMmonthly.day1.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[2 - 1]) {
          TMmonthly.day2.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[3 - 1]) {
          TMmonthly.day3.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[4 - 1]) {
          TMmonthly.day4.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[5 - 1]) {
          TMmonthly.day5.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[6 - 1]) {
          TMmonthly.day6.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[7 - 1]) {
          TMmonthly.day7.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[8 - 1]) {
          TMmonthly.day8.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[9 - 1]) {
          TMmonthly.day9.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[10 - 1]) {
          TMmonthly.day10.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[11 - 1]) {
          TMmonthly.day11.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[12 - 1]) {
          TMmonthly.day12.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[13 - 1]) {
          TMmonthly.day13.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[14 - 1]) {
          TMmonthly.day14.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[15 - 1]) {
          TMmonthly.day15.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[16 - 1]) {
          TMmonthly.day16.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[17 - 1]) {
          TMmonthly.day17.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[18 - 1]) {
          TMmonthly.day18.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[19 - 1]) {
          TMmonthly.day19.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[20 - 1]) {
          TMmonthly.day20.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[21 - 1]) {
          TMmonthly.day21.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[22 - 1]) {
          TMmonthly.day22.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[23 - 1]) {
          TMmonthly.day23.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[24 - 1]) {
          TMmonthly.day24.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[25 - 1]) {
          TMmonthly.day25.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[26 - 1]) {
          TMmonthly.day26.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[27 - 1]) {
          TMmonthly.day27.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (date == listOfDatesapi[28 - 1]) {
          TMmonthly.day28.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
        }
        if (listOfDatesapi.length > 28) {
          if (date == listOfDatesapi[28]) {
            TMmonthly.day29.add(
                '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
          }
        }
        if (listOfDatesapi.length > 29) {
          if (date == listOfDatesapi[29]) {
            TMmonthly.day30.add(
                '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
          }
        }
        if (listOfDatesapi.length > 30) {
          if (date == listOfDatesapi[30]) {
            TMmonthly.day31.add(
                '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');
          }
        }

        if (decodeData['data'][u]['type'] != null) //split_time
        {
          String date_input = date;
          var date_input_split = date_input.split("-");

          String input = decodeData['data'][u]['split_time'];
          var inputSplit = input.split(",");
          print("split_time..$input");
          for (var i = 0; i < inputSplit.length; i++) {
            var oneHex = (inputSplit[i]);
            var inputSplittwo = inputSplit[i].split("-");
            // print('values new');
            var split_intime = inputSplittwo.length > 0 ? inputSplittwo[0] : "";
            var split_outtime =
                inputSplittwo.length > 1 ? inputSplittwo[1] : "";

            var days = inputSplittwo.length > 2 ? date_input_split[2] : "";
            print('"days": ${days}');

            if (days == "01") {
              print('"days1": ${days}');
              TMmonthly.day1.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "02") {
              print('"days2": ${days}');
              TMmonthly.day2.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "03") {
              print('"days3": ${days}');
              TMmonthly.day3.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "04") {
              TMmonthly.day4.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "05") {
              TMmonthly.day5.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "06") {
              TMmonthly.day6.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "07") {
              TMmonthly.day7.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "08") {
              TMmonthly.day8.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "09") {
              TMmonthly.day9.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "10") {
              TMmonthly.day10.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "11") {
              TMmonthly.day11.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "12") {
              TMmonthly.day12.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "13") {
              TMmonthly.day13.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "14") {
              TMmonthly.day14.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "15") {
              TMmonthly.day15.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "16") {
              TMmonthly.day16.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "17") {
              TMmonthly.day17.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "18") {
              TMmonthly.day18.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "19") {
              TMmonthly.day19.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "20") {
              TMmonthly.day20.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "21") {
              TMmonthly.day21.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "22") {
              TMmonthly.day22.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "23") {
              TMmonthly.day23.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "24") {
              TMmonthly.day24.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "25") {
              TMmonthly.day25.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "26") {
              TMmonthly.day26.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "27") {
              TMmonthly.day27.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "28") {
              TMmonthly.day28.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "29") {
              TMmonthly.day29.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "30") {
              TMmonthly.day30.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            } else if (days == "31") {
              TMmonthly.day31.add(
                  '{"Outlet": "${decodeData['data'][u]['store_name']} (split)","CheckIn":"${split_intime}","CheckOut":"${split_outtime}"}');
            }
          }
        }
      }
      print(dataofdates);
    } else {
      print(dataresponse.body);
    }
  } on SocketException catch (_) {
    return false;
  }
}

class TMmonthly {
  static List<String> day1 = [];
  static List<String> day2 = [];
  static List<String> day3 = [];
  static List<String> day4 = [];
  static List<String> day5 = [];
  static List<String> day6 = [];
  static List<String> day7 = [];
  static List<String> day8 = [];
  static List<String> day9 = [];
  static List<String> day10 = [];
  static List<String> day11 = [];
  static List<String> day12 = [];
  static List<String> day13 = [];
  static List<String> day14 = [];
  static List<String> day15 = [];
  static List<String> day16 = [];
  static List<String> day17 = [];
  static List<String> day18 = [];
  static List<String> day19 = [];
  static List<String> day20 = [];
  static List<String> day21 = [];
  static List<String> day22 = [];
  static List<String> day23 = [];
  static List<String> day24 = [];
  static List<String> day25 = [];
  static List<String> day26 = [];
  static List<String> day27 = [];
  static List<String> day28 = [];
  static List<String> day29 = [];
  static List<String> day30 = [];
  static List<String> day31 = [];
}

/*
final DateTime nowss = DateTime.now();
final DateFormat formatterss = DateFormat('yyyy-MM-dd');
final String todaydatess = formatter.format(now);
List dataofdatesss=[];
List<dynamic> listOfDatesapiss;


Future<void> gettimesheetmonthlySS() async {
  listOfDatesapiss = new List<String>.generate(
      daysInMonth(DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())),
          int.parse(DateFormat('mm').format(DateTime.now())))),
          (i) => "${int.parse(DateFormat('yyyy').format(DateTime.now()))}-${DateFormat('MM').format(DateTime.now())}-${'${i + 1}'.toString().padLeft(2,"0")}");
  Map request = {
    "emp_id": "${DBrequestdata.receivedempid}",
    "month" : "$todaydatess"
  };
  Map fmrequest = {
    "emp_id": "${timesheet.empid}",
    "month" : "$todaydatess"
  };
  print("Month request for TS ------------> ${request}");
  print("Time Sheet Month Log---->${request}");
  http.Response dataresponse = await http.post(TSMurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: currentuser.roleid == 6 ? jsonEncode(request) : jsonEncode(fmrequest),
  );
  if (dataresponse.statusCode == 200) {
    TMmonthlySS.day1=[];
    TMmonthlySS.day2=[];
    TMmonthlySS.day3=[];
    TMmonthlySS.day4=[];
    TMmonthlySS.day5=[];
    TMmonthlySS.day6=[];
    TMmonthlySS.day7=[];
    TMmonthlySS.day8=[];
    TMmonthlySS.day9=[];
    TMmonthlySS.day10=[];
    TMmonthlySS.day11=[];
    TMmonthlySS.day12=[];
    TMmonthlySS.day13=[];
    TMmonthlySS.day14=[];
    TMmonthlySS.day15=[];
    TMmonthlySS.day16=[];
    TMmonthlySS.day17=[];
    TMmonthlySS.day18=[];
    TMmonthlySS.day19=[];
    TMmonthlySS.day20=[];
    TMmonthlySS.day21=[];
    TMmonthlySS.day22=[];
    TMmonthlySS.day23=[];
    TMmonthlySS.day24=[];
    TMmonthlySS.day25=[];
    TMmonthlySS.day26=[];
    TMmonthlySS.day27=[];
    TMmonthlySS.day28=[];
    TMmonthlySS.day29=[];
    TMmonthlySS.day30=[];
    TMmonthlySS.day31=[];
    String data = dataresponse.body;
    var decodeData = jsonDecode(data);
    print(decodeData['data'].length);
    print('length : ${listOfDatesapi.length}');
    dataofdatesss = [];
    for (int u=0;u<decodeData['data'].length;u++){

      String date = decodeData['data'][u]['date'];
      print(date);
      if(dataofdates.contains(date)){

      }else{
        dataofdates.add(date);
        dataofdates.sort();
      }

      if(date == listOfDatesapiss[1-1]){

        TMmonthly.day1.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');

      }
      if(date == listOfDatesapiss[2-1]){TMmonthly.day2.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}

      if(date == listOfDatesapiss[3-1]){TMmonthly.day3.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[4-1]){TMmonthly.day4.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[5-1]){TMmonthly.day5.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[6-1]){TMmonthly.day6.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[7-1]){TMmonthly.day7.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[8-1]){TMmonthly.day8.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[9-1]){TMmonthly.day9.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[10-1]){TMmonthly.day10.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[11-1]){TMmonthly.day11.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[12-1]){TMmonthly.day12.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[13-1]){TMmonthly.day13.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[14-1]){TMmonthly.day14.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[15-1]){TMmonthly.day15.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[16-1]){TMmonthly.day16.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[17-1]){TMmonthly.day17.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[18-1]){TMmonthly.day18.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[19-1]){TMmonthly.day19.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[20-1]){TMmonthly.day20.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[21-1]){TMmonthly.day21.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[22-1]){TMmonthly.day22.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[23-1]){TMmonthly.day23.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[24-1]){TMmonthly.day24.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[25-1]){TMmonthly.day25.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[26-1]){TMmonthly.day26.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[27-1]){TMmonthly.day27.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(date == listOfDatesapiss[28-1]){TMmonthly.day28.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      if(listOfDatesapiss.length > 28){
        if (date == listOfDatesapiss[28]) {TMmonthly.day29.add('{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      }
      if(listOfDatesapiss.length > 29){
        if (date == listOfDatesapiss[29]) {
          TMmonthly.day30.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      }
      if(listOfDatesapiss.length > 30){
        if (date == listOfDatesapiss[30]) {
          TMmonthly.day31.add(
              '{"Outlet": "${decodeData['data'][u]['store_name']}","CheckIn":"${decodeData['data'][u]['checkin_time']}","CheckOut":"${decodeData['data'][u]['checkout_time']}"}');}
      }
    }
    print(dataofdates);
  }else{
    print(dataresponse.body);
  }
}




class TMmonthlySS{
  static List<String> day1= [];
  static List<String> day2 = [];
  static List<String> day3 = [];
  static List<String> day4 = [];
  static List<String> day5 = [];
  static List<String> day6 = [];
  static List<String> day7 = [];
  static List<String> day8 = [];
  static List<String> day9 = [];
  static List<String> day10 = [];
  static List<String> day11 = [];
  static List<String> day12 = [];
  static List<String> day13 = [];
  static List<String> day14 = [];
  static List<String> day15 = [];
  static List<String> day16 = [];
  static List<String> day17 = [];
  static List<String> day18 = [];
  static List<String> day19 = [];
  static List<String> day20 = [];
  static List<String> day21 = [];
  static List<String> day22 = [];
  static List<String> day23 = [];
  static List<String> day24 = [];
  static List<String> day25 = [];
  static List<String> day26 = [];
  static List<String> day27 = [];
  static List<String> day28 = [];
  static List<String> day29 = [];
  static List<String> day30 = [];
  static List<String> day31 = [];
}


 */
