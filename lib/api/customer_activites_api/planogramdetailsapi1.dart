import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Merchandiser/merchandiserscreens/planogram1.dart';
import '../api_service.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/PlanogramcheckPhase1.dart';
import 'dart:async';
import 'dart:io';

import '../api_service2.dart';

Future<void> getPlanogram() async {
  print("getPlanogram");
  Map body = {"time_sheet_id": "$currenttimesheetid"};
  try {
    http.Response PlanoResponse = await http.post(
      PlanogramDetails,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(body),
    );
    if (PlanoResponse.statusCode == 200) {
      print(body);
      PlanoDetails.imageurl = [];
      PlanoDetails.beforeimage = [];
      PlanoDetails.afterimage = [];
      PlanoDetails.brandname = [];
      PlanoDetails.categoryname = [];
      PlanoDetails.categoryid = [];

      print('Planogram Details done');
      String planobody = PlanoResponse.body;
      print("getPlanogram...online...$planobody");
      await saveActivitiesDataIntoDB(currenttimesheetid.toString(), planobody, planodetaildata_table);

      var decodeddata = jsonDecode(planobody);
      if (decodeddata['data'].length == 0) {
        print("No Data");
        PlanoDetails.nodata = "nodata";
        print(PlanoDetails.nodata);
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        if (decodeddata['data'][u]['category_name'] != null) {
          PlanoDetails.image.add('${decodeddata['data'][u]['planogram_img']}');
          PlanoDetails.imageurl.add(
              "https://test.rhapsody.ae/planogram_image/${decodeddata['data'][u]['planogram_img']}");
          PlanoDetails.beforeimage.add(
              "https://test.rhapsody.ae/planogram_image/${decodeddata['data'][u]['before_image']}");
          PlanoDetails.afterimage.add(
              "https://test.rhapsody.ae/planogram_image/${decodeddata['data'][u]['after_image']}");
          PlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
          PlanoDetails.opm.add(decodeddata['data'][u]['opm']);
          PlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
          PlanoDetails.categoryname.add(
              decodeddata['data'][u]['category_name']);
          PlanoDetails.categoryid.add(decodeddata['data'][u]['c_id']);

          if (decodeddata['data'][u]['before_image'] != null) {
            planocheck = true;
          }
        }
      }
      // beforeimages = [];
      // afterimages = [];
      // beforeimagesencode = [];
      // afterimagesencode = [];
      // for (int i = 0; i < PlanoDetails.brandname.length; i++) {
      //   beforeimages.add(File('dummy.txt'));
      //   afterimages.add(File('dummy.txt'));
      //   beforeimagesencode.add('dummy.txt');
      //   afterimagesencode.add('dummy.txt');
      // }
    }
  }
  on SocketException catch (_) {


    String planodetailsdata = await getActivityData(planodetaildata_table, currenttimesheetid.toString());
    print("getPlanogram...offline...$planodetailsdata");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    PlanoDetails.categoryname = [];
    if(planodetailsdata!=null)
    {
      PlanoDetails.imageurl = [];
      PlanoDetails.beforeimage = [];
      PlanoDetails.afterimage = [];
      PlanoDetails.brandname = [];
      PlanoDetails.categoryname = [];
      PlanoDetails.categoryid = [];
      print("not null");
      // offlineplanodata = prefs.getStringList('planodetaildata')??[];
      //
      // String data = offlineplanodata[currentoutletindex];
      var decodeddata = jsonDecode(planodetailsdata);

      if (decodeddata['data'].length == 0) {
        print("No Data");
        PlanoDetails.nodata = "nodata";
        print(PlanoDetails.nodata);
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        if (decodeddata['data'][u]['category_name'] != null) {
          PlanoDetails.image.add('${decodeddata['data'][u]['planogram_img']}');
          PlanoDetails.imageurl.add(
              "https://test.rhapsody.ae/planogram_image/${decodeddata['data'][u]['planogram_img']}");
          PlanoDetails.beforeimage.add(
              "https://test.rhapsody.ae/planogram_image/${decodeddata['data'][u]['before_image']}");
          PlanoDetails.afterimage.add(
              "https://test.rhapsody.ae/planogram_image/${decodeddata['data'][u]['after_image']}");
          PlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
          PlanoDetails.opm.add(decodeddata['data'][u]['opm']);
          PlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
          PlanoDetails.categoryname.add(
              decodeddata['data'][u]['category_name']);
          PlanoDetails.categoryid.add(decodeddata['data'][u]['c_id']);

          if (decodeddata['data'][u]['before_image'] != null) {
            planocheck = true;
          }
        }
      }
      beforeimages = [];
      afterimages = [];
      beforeimagesencode = [];
      afterimagesencode = [];
      for (int i = 0; i < PlanoDetails.brandname.length; i++) {
        beforeimages.add(File('dummy.txt'));
        afterimages.add(File('dummy.txt'));
        beforeimagesencode.add('dummy.txt');
        afterimagesencode.add('dummy.txt');
      }
    }


    return false;
  }
}

class PlanoDetails {
  static List<String> imageurl = [];
  static List<String> beforeimage = [];
  static List<String> afterimage = [];
  static List<String> brandname = [];
  static List<String> categoryname = [];
  static List<String> image = [];
  static List<int> opm = [];
  static List<int> brandid = [];
  static List<int> categoryid = [];
  static List<String> isavail = [];
  static var nodata;
}

bool planocheck = false;
