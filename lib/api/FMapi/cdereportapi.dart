import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import 'package:merchandising/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';

import '../api_service2.dart';

String empreportdata;

Future CDEReportingDetails() async {
  Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
  print("CDEReportingDetails...$DBrequestData");
  http.Response EmpReport = await http.post(
    CDEReportingDet,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(DBrequestData),
  );
  if (EmpReport.statusCode == 200) {
    try {
      print('CDE reporting details done');
      CDEreportdata.cdeempid = [];
      CDEreportdata.mername = [];
      CDEreportdata.mersname = [];
      CDEreportdata.cdeempname = [];
      CDEreportdata.cdeempsname = [];
      CDEreportdata.startdate = [];
      CDEreportdata.merchandisersid = [];
      CDEreportdata.enddate = [];
      // print('reporting details');
      empreportdata = EmpReport.body;
      await addempdetailesreport(empreportdata);
      var decodeddata = jsonDecode(empreportdata);
      //  print('yme');
      //print(decodeddata);
      for (int u = decodeddata['data'].length-1; u >=0; u--) {
        print(decodeddata['data']);
        CDEreportdata.cdeempid.add(decodeddata["data"][u]['cde_id']);

        if (decodeddata["data"][u]['merchandiser'] != null)
            // &&
            // decodeddata["data"][u]['merchandiser']['first_name'] != "")
        {
          CDEreportdata.mername
              .add(decodeddata["data"][u]['merchandiser']['first_name']??"");
        } else {
          CDEreportdata.mername.add("");
        }

        // if (decodeddata["data"][u]['merchandiser'] != null &&
        //     decodeddata["data"][u]['merchandiser']['surname'] != "") {
        //   CDEreportdata.mersname
        //       .add(decodeddata["data"][u]['merchandiser']['surname']);
        // } else {
        //   CDEreportdata.mersname.add("");
        // }

        // CDEreportdata.cdeempid.add(decodeddata["data"][u]['cde_id']);

        if (decodeddata["data"][u]['cde_reporting'] != null) {
          CDEreportdata.cdeempname
              .add(decodeddata["data"][u]['cde_reporting']['first_name']??"");
        } else {
          CDEreportdata.cdeempname.add("");
        }

        CDEreportdata.mersname.add("");
        CDEreportdata.cdeempsname.add("");
        CDEreportdata.startdate.add(decodeddata["data"][u]['reporting_date']);
        CDEreportdata.enddate.add(decodeddata["data"][u]['reporting_end_date']);
        CDEreportdata.merchandisersid
            .add(decodeddata["data"][u]['merchandiser_id']);

        // print(decodeddata["data"][u]['cde_reporting']['first_name']);

      }
print("CDEreportdata.merchandisersid.length");
      print(CDEreportdata.merchandisersid.length);
      // print(CDEreportdata.cdeempsname);
      // print(CDEreportdata.cdeempid.length);

    } on Exception catch (exception) {
      //   throw Exception("Error on server1");
    } catch (error) {
      print("throwing new error...$error");
      //  throw Exception("Error on server");

    }
  }
  if (EmpReport.statusCode != 200) {
    print(EmpReport.body);
  }
}

class CDEreportdata {
  static List<dynamic> cdeempid = [];

  static List<dynamic> mername = [];
  static List<dynamic> mersname = [];
  static List<dynamic> cdeempname = [];
  static List<dynamic> cdeempsname = [];

  static List<dynamic> startdate = [];
  static List<dynamic> merchandisers = [];
  static List<dynamic> enddate = [];
  static List<dynamic> merchandisersid = [];
  static List<dynamic> fmnames = [];
}
