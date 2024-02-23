import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/utils/DatabaseHelper.dart';
import '../../api_service2.dart';
import '../../api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';

var JPskippeddata;

Future<void> getskippedJourneyPlan() async {
  // print("getskippedJourneyPlan...$currentlysyncing");
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // JPskippeddata = prefs.getString('todayskipped');
// COMMENTING OUT TO TEST IF THE BELOW TWO LINES ARE REQUIRED
  // JPskippeddata = await getData(todayskipped_table);
  // print("JPskippeddata^^^^$JPskippeddata");

  //
  // if (JPskippeddata == null || currentlysyncing) {
    Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
print('Parameter for JP Skipped : $DBrequestData');
    try{
    http.Response JPresponse = await http.post(
      JPSkippedurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(DBrequestData),
    );
    if (JPresponse.statusCode == 200) {
      print("skippedjourneyplandone");
      JPskippeddata = JPresponse.body;
    // await addtodayskipped(JPskippeddata);
// COMMENTING OUT TO TEST IF THE BELOW TWO LINES ARE REQUIRED
      // await saveDataIntoDB(JPskippeddata,todayskipped_table);
      var decodeJPData = jsonDecode(JPskippeddata);
      print("getskippedJourneyPlan... online...$JPskippeddata");
      todayskipjplist.storenames = [];
      todayskipjplist.distanceinmeters = [];
      todayskipjplist.contactnumbers = [];
      todayskipjplist.outletcountry = [];
      todayskipjplist.outletcity = [];
      todayskipjplist.outletarea = [];
      todayskipjplist.storecodes = [];
      todayskipjplist.id = [];
      todayskipjplist.outletlong = [];
      todayskipjplist.outletlat = [];
      todayskipjplist.outletids = [];
      for (int u = 0; u < decodeJPData['data'].length; u++) {
        dynamic storename = decodeJPData['data'][u]['store_name'];
        todayskipjplist.storenames.add(storename);
        dynamic storecode = decodeJPData['data'][u]['store_code'];
        todayskipjplist.storecodes.add(storecode);
        dynamic outletid = decodeJPData['data'][u]['outlet_id'];
        print(outletid);
        todayskipjplist.outletids.add(outletid);
        dynamic outletlat = decodeJPData['data'][u]['outlet_lat'];
        todayskipjplist.outletlat.add(outletlat);
        dynamic outletlong = decodeJPData['data'][u]['outlet_long'];
        todayskipjplist.outletlong.add(outletlong);
        dynamic outletarea = decodeJPData['data'][u]['outlet_area'];
        todayskipjplist.outletarea.add(outletarea);
        dynamic outletcity = decodeJPData['data'][u]['outlet_city'];
        todayskipjplist.outletcity.add(outletcity);
        dynamic outletcountry = decodeJPData['data'][u]['outlet_country'];
        todayskipjplist.outletcountry.add(outletcountry);
        dynamic tableid = decodeJPData['data'][u]['id'];
        todayskipjplist.id.add(tableid);
        dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
        todayskipjplist.contactnumbers.add(outletcontact);
      }
    } else {
      print("getskippedJourneyPlan..else");
      print(JPresponse.statusCode);
    }}
    on SocketException catch (_) {
  // else {
      if(JPskippeddata != null ) {
        print("getskippedJourneyPlan... offline...$JPskippeddata");
        var decodeJPData = jsonDecode(JPskippeddata);
        todayskipjplist.storenames = [];
        todayskipjplist.distanceinmeters = [];
        todayskipjplist.contactnumbers = [];
        todayskipjplist.outletcountry = [];
        todayskipjplist.outletcity = [];
        todayskipjplist.outletarea = [];
        todayskipjplist.storecodes = [];
        todayskipjplist.id = [];
        todayskipjplist.outletlong = [];
        todayskipjplist.outletlat = [];
        todayskipjplist.outletids = [];
        for (int u = 0; u < decodeJPData['data'].length; u++) {
          dynamic storename = decodeJPData['data'][u]['store_name'];
          todayskipjplist.storenames.add(storename);
          dynamic storecode = decodeJPData['data'][u]['store_code'];
          todayskipjplist.storecodes.add(storecode);
          dynamic outletid = decodeJPData['data'][u]['outlet_id'];
          print(outletid);
          todayskipjplist.outletids.add(outletid);
          dynamic outletlat = decodeJPData['data'][u]['outlet_lat'];
          todayskipjplist.outletlat.add(outletlat);
          dynamic outletlong = decodeJPData['data'][u]['outlet_long'];
          todayskipjplist.outletlong.add(outletlong);
          dynamic outletarea = decodeJPData['data'][u]['outlet_area'];
          todayskipjplist.outletarea.add(outletarea);
          dynamic outletcity = decodeJPData['data'][u]['outlet_city'];
          todayskipjplist.outletcity.add(outletcity);
          dynamic outletcountry = decodeJPData['data'][u]['outlet_country'];
          todayskipjplist.outletcountry.add(outletcountry);
          dynamic tableid = decodeJPData['data'][u]['id'];
          todayskipjplist.id.add(tableid);
          dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
          todayskipjplist.contactnumbers.add(outletcontact);
        }
        // }
      }
      return false;
    }

  // }
  // else {
  //   print("getskippedJourneyPlan..elsepart");
  //   var decodeJPData = jsonDecode(JPskippeddata);
  //   todayskipjplist.storenames = [];
  //   todayskipjplist.distanceinmeters = [];
  //   todayskipjplist.contactnumbers = [];
  //   todayskipjplist.outletcountry = [];
  //   todayskipjplist.outletcity = [];
  //   todayskipjplist.outletarea = [];
  //   todayskipjplist.storecodes = [];
  //   todayskipjplist.id = [];
  //   todayskipjplist.outletlong = [];
  //   todayskipjplist.outletlat = [];
  //   todayskipjplist.outletids = [];
  //   for (int u = 0; u < decodeJPData['data'].length; u++) {
  //     dynamic storename = decodeJPData['data'][u]['store_name'];
  //     todayskipjplist.storenames.add(storename);
  //     dynamic storecode = decodeJPData['data'][u]['store_code'];
  //     todayskipjplist.storecodes.add(storecode);
  //     dynamic outletid = decodeJPData['data'][u]['outlet_id'];
  //     print(outletid);
  //     todayskipjplist.outletids.add(outletid);
  //     dynamic outletlat = decodeJPData['data'][u]['outlet_lat'];
  //     todayskipjplist.outletlat.add(outletlat);
  //     dynamic outletlong = decodeJPData['data'][u]['outlet_long'];
  //     todayskipjplist.outletlong.add(outletlong);
  //     dynamic outletarea = decodeJPData['data'][u]['outlet_area'];
  //     todayskipjplist.outletarea.add(outletarea);
  //     dynamic outletcity = decodeJPData['data'][u]['outlet_city'];
  //     todayskipjplist.outletcity.add(outletcity);
  //     dynamic outletcountry = decodeJPData['data'][u]['outlet_country'];
  //     todayskipjplist.outletcountry.add(outletcountry);
  //     dynamic tableid = decodeJPData['data'][u]['id'];
  //     todayskipjplist.id.add(tableid);
  //     dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
  //     todayskipjplist.contactnumbers.add(outletcontact);
  //   }
  // }
}

class todayskipjplist {
  static List<dynamic> storecodes = [];
  static List<dynamic> storenames = [];
  static List<dynamic> outletids = [];
  static List<dynamic> outletlat = [];
  static List<dynamic> outletlong = [];
  static List<dynamic> outletarea = [];
  static List<dynamic> outletcity = [];
  static List<dynamic> outletcountry = [];
  static List<dynamic> id = [];
  static List<dynamic> contactnumbers = [];
  static List<double> distanceinmeters = [];
}
