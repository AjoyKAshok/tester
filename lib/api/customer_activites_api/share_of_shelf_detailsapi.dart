import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/shareofshelf.dart';
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service2.dart';

Future<void> getShareofshelf() async {
  print("getShareofshelf...$currenttimesheetid");
  Map body = {
    "time_sheet_id": currenttimesheetid,
  };
  try {
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
      ShareData.categoryid = [];
      ShareData.categoryname = [];
      ShareData.brandid = [];
      ShareData.share = [];
      ShareData.total = [];
      ShareData.target = [];
      ShareData.actualpercent = [];


      print('Share of Shelf done...${shareresponse.body}');

      String availabititybody = shareresponse.body;
      print("getShareofshelf...online...$availabititybody");
      await saveActivitiesDataIntoDB(currenttimesheetid.toString(), availabititybody, shareofshelfdetdata_table);

      var decodeddata = jsonDecode(availabititybody);
      if (decodeddata['data'].length == 0) {
        print("No Data");
        ShareData.nodata = "nodata";
        print(ShareData.nodata);
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        ShareData.categoryid.add(decodeddata['data'][u]['c_id']);
        ShareData.categoryname.add(decodeddata['data'][u]['category_name']);
        ShareData.target.add(decodeddata['data'][u]['opm_target']);
        ShareData.mappingid =decodeddata['data'][u]['opm'];
        ShareData.share.add(decodeddata['data'][u]['merch_update_share']);
        ShareData.actualpercent
            .add(decodeddata['data'][u]['merch_update_actual']);
        if (decodeddata['data'][u]['merch_update_actual'] != null) {
          shareofshelfcheck = true;
        }
        if (decodeddata['data'][u]['share'] != null) {
          print("has data");
          ShareData.ctrgys.add(decodeddata['data'][u]['category_name']);
        }
        ShareData.total.add(decodeddata['data'][u]['total_share']);
      }
      actualpercent.clear();
      totalshare.clear();
      actual.clear();
      total.clear();
      share.clear();
      reasonforsos.clear();
      actualpercent = [];
      totalshare = [];
      totalshelf = [];
      for (int i = 0; i < ShareData.target.length; i++) {
        actualpercent.add(0.0);
        totalshare.add(0.0);
        totalshelf.add(0.0);
        actual.add(TextEditingController());
        total.add(TextEditingController());
        share.add(TextEditingController());
        reasonforsos.add(TextEditingController());
      }
      print("actual");
      print(ShareData.mappingid);
    }
  }
  on SocketException catch (_) {
    String shareofshelfdata = await getActivityData(shareofshelfdetdata_table, currenttimesheetid.toString());
    print("getShareofshelf...offline...$shareofshelfdata");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    ShareData.target = [];
    if(shareofshelfdata!=null) {
      ShareData.categoryid = [];
      ShareData.categoryname = [];
      ShareData.brandid = [];
      ShareData.share = [];
      ShareData.total = [];
      ShareData.target = [];

      ShareData.actualpercent = [];
      print("not null");
      // offlinesosdata = prefs.getStringList('shareofshelfdetdata') ?? [];
      //
      // String data = offlinesosdata[currentoutletindex];
      var decodeddata = jsonDecode(shareofshelfdata);

      if (decodeddata['data'].length == 0) {
        print("No Data");
        ShareData.nodata = "nodata";
        print(ShareData.nodata);
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        ShareData.categoryid.add(decodeddata['data'][u]['c_id']);
        ShareData.categoryname.add(decodeddata['data'][u]['category_name']);
        ShareData.target.add(decodeddata['data'][u]['opm_target']);
        ShareData.mappingid =decodeddata['data'][u]['opm'];
        ShareData.share.add(decodeddata['data'][u]['merch_update_share']);
        ShareData.actualpercent
            .add(decodeddata['data'][u]['merch_update_actual']);
        if (decodeddata['data'][u]['merch_update_actual'] != null) {
          shareofshelfcheck = true;
        }
        if (decodeddata['data'][u]['share'] != null) {
          print("has data");
          ShareData.ctrgys.add(decodeddata['data'][u]['category_name']);
        }
        ShareData.total.add(decodeddata['data'][u]['total_share']);
      }
      actualpercent = [];
      totalshare = [];
      totalshelf = [];
      for (int i = 0; i < ShareData.target.length; i++) {
        actualpercent.add(0.0);
        totalshare.add(0.0);
        totalshelf.add(0.0);
        actual.add(TextEditingController());
        total.add(TextEditingController());
        share.add(TextEditingController());
        reasonforsos.add(TextEditingController());
      }
      print("actual");
      print(ShareData.mappingid);
    }
    return false;
  }
}

class ShareData {
  static List<int> categoryid = [];
  static List<String> categoryname = [];
  static List<String> share = [];
  static List<String> total = [];
  static List<String> target = [];
  static List<String> actual = [];
  static List<int> brandid = [];
  static List<String> ctrgys = [];
  static List<String> actualpercent = [];
  static List<String> noactual = [];
  static var nodata;
  static  var mappingid;
}

bool shareofshelfcheck = false;
