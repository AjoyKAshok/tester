import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/main.dart';
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/availabitiy.dart';

import 'api_service2.dart';

Future<void> getAvaiablitity() async {
  print("getAvailablity....$currenttimesheetid");
  Map body = {"time_sheet_id": "$currenttimesheetid"};
  print(jsonEncode(body));
  try {
    http.Response response = await http.post(
      AvailabilityDetails,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Avaiablity.productid = [];
      Avaiablity.productname = [];
      Avaiablity.fullname = [];
      Avaiablity.storedetailes = [];
      Avaiablity.brand = [];
      Avaiablity.category = [];
      Avaiablity.checkvalue = [];
      Avaiablity.zrepcode = [];
      Avaiablity.reason = [];
      Avaiablity.oos = [];
      Avaiablity.oosreason = [];
      Avaiablity.insreason = [];


      print('Availability done');
      String availabititybody = response.body;
      print("getAvaiablitity...online...$availabititybody");
      var decodeddata = jsonDecode(availabititybody);
      await saveActivitiesDataIntoDB(currenttimesheetid.toString(), availabititybody, availabilitydetdata_table);

      print("availablity length....${decodeddata['data'].length}...aaaa..");
      if (decodeddata['data'].length == 0) {
        print("No Data");
        Avaiablity.nodata = "nodata";
        print(Avaiablity.nodata);
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        Avaiablity.productid.add(decodeddata['data'][u]['product_id']);
        Avaiablity.brand.add(decodeddata['data'][u]['b_name']);

        Avaiablity.category.add(decodeddata['data'][u]['c_name']);
        Avaiablity.productname.add(decodeddata['data'][u]['p_name']);
        Avaiablity.mappingid = decodeddata['data'][u]['opm'];
        //Avaiablity.zrepcode.add(decodeddata['data'][u]['zrep_code']);
        Avaiablity.fullname.add(
            '${decodeddata['data'][u]['p_name']} [${decodeddata['data'][u]['zrep_code']}]');
        if (decodeddata['data'][u]['is_available'] == null) {
          Avaiablity.isavail = null;
          // print(Avaiablity.isavail);
        }
        //print(decodeddata['data'][u]['is_available']);
        if (decodeddata['data'][u]['is_available'] != null) {
          avaliabilitycheck = true;
          Avaiablity.checkvalue
              .add(int.parse(decodeddata['data'][u]['is_available']));
        } else {
          Avaiablity.checkvalue.add(1);
        }
        Avaiablity.storedetailes.add(
            '[${decodeddata['data'][u]['store_code']}] ${decodeddata['data'][u]['store_name']}');
        if (decodeddata['data'][u]['reason'] == null) {
          Avaiablity.reason.add('');
        } else {
          Avaiablity.reason.add(decodeddata['data'][u]['reason']);
        }
      }
      comid = Avaiablity.mappingid;
      print(Avaiablity.category);


      print("CheckValue length..${ Avaiablity.checkvalue.length}");
      //   reasons = [];
      //   outofStockitems = [];
      // for (int i = 0;
      //     i < Avaiablity.productname.length;
      //     i++) {
      //   reasons.add('');
      //   outofStockitems.add(1);
      // }
      reasons = [];
      outofStockitems = [];
      for (int i = 0; i < Avaiablity.productname.length; i++) {
        reasons.add('');
        outofStockitems.add(1);
        if (true) {
          // ignore: unrelated_type_equality_checks
          if ('${Avaiablity.checkvalue[i]}' == '0') {
            print('came out');
            Avaiablity.oos.add(Avaiablity.productname[i]);
            Avaiablity.oosreason.add(Avaiablity.reason[i]);
          } else {
            print('came in');
            Avaiablity.insreason.add(Avaiablity.productname[i]);
          }
        }
      }
      Distintbrands = Avaiablity.brand.toSet().toList();
      Distintcategory = Avaiablity.category.toSet().toList();
    }
  }
  on SocketException catch (_) {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String availabilitydetdata = await getActivityData(availabilitydetdata_table, currenttimesheetid.toString());
    print("getAvaiablitity...offline...$availabilitydetdata");
    Avaiablity.fullname = [];
    if(availabilitydetdata!=null) {
      print("availablity offline");
      Avaiablity.productid = [];
      Avaiablity.productname = [];
      Avaiablity.fullname = [];
      Avaiablity.storedetailes = [];
      Avaiablity.brand = [];
      Avaiablity.category = [];
      Avaiablity.checkvalue = [];
      Avaiablity.zrepcode = [];
      Avaiablity.reason = [];
      Avaiablity.oos = [];
      Avaiablity.oosreason = [];
      Avaiablity.insreason = [];
      print("not null");
      // offlineAvailabilityData = prefs.getStringList('availabilitydetdata') ?? [];

      // String data = offlineAvailabilityData[currentoutletindex];
      var decodeddata = jsonDecode(availabilitydetdata);

      print("availablity length....${decodeddata['data'].length}");
      if (decodeddata['data'].length == 0) {
        print("No Data");
        Avaiablity.nodata = "nodata";
        print(Avaiablity.nodata);
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        Avaiablity.productid.add(decodeddata['data'][u]['product_id']);
        Avaiablity.brand.add(decodeddata['data'][u]['b_name']);

        Avaiablity.category.add(decodeddata['data'][u]['c_name']);
        Avaiablity.productname.add(decodeddata['data'][u]['p_name']);
        Avaiablity.mappingid = decodeddata['data'][u]['opm'];
        //Avaiablity.zrepcode.add(decodeddata['data'][u]['zrep_code']);
        Avaiablity.fullname.add(
            '${decodeddata['data'][u]['p_name']} [${decodeddata['data'][u]['zrep_code']}]');
        if (decodeddata['data'][u]['is_available'] == null) {
          Avaiablity.isavail = null;
          // print(Avaiablity.isavail);
        }
        //print(decodeddata['data'][u]['is_available']);
        if (decodeddata['data'][u]['is_available'] != null) {
          avaliabilitycheck = true;
          Avaiablity.checkvalue
              .add(int.parse(decodeddata['data'][u]['is_available']));
        } else {
          Avaiablity.checkvalue.add(1);
        }
        Avaiablity.storedetailes.add(
            '[${decodeddata['data'][u]['store_code']}] ${decodeddata['data'][u]['store_name']}');
        if (decodeddata['data'][u]['reason'] == null) {
          Avaiablity.reason.add('');
        } else {
          Avaiablity.reason.add(decodeddata['data'][u]['reason']);
        }
      }
      comid = Avaiablity.mappingid;
      print(Avaiablity.category);

      print("CheckValue length..${ Avaiablity.checkvalue.length}");
      //   reasons = [];
      //   outofStockitems = [];
      // for (int i = 0;
      //     i < Avaiablity.productname.length;
      //     i++) {
      //   reasons.add('');
      //   outofStockitems.add(1);
      // }
      reasons = [];
      outofStockitems = [];
      for (int i = 0; i < Avaiablity.productname.length; i++) {
        reasons.add('');
        outofStockitems.add(1);
        if (true) {
          // ignore: unrelated_type_equality_checks
          if ('${Avaiablity.checkvalue[i]}' == '0') {
            print('came out');
            Avaiablity.oos.add(Avaiablity.productname[i]);
            Avaiablity.oosreason.add(Avaiablity.reason[i]);
          } else {
            print('came in');
            Avaiablity.insreason.add(Avaiablity.productname[i]);
          }
        }
      }
      Distintbrands = Avaiablity.brand.toSet().toList();
      Distintcategory = Avaiablity.category.toSet().toList();
    }

    return false;
  }
}

List<String> Distintcategory = [];
List<String> Distintbrands = [];

class Avaiablity {
  static var mappingid;
  static List<dynamic> productid = [];
  static List<String> productname = [];
  static List<String> storedetailes = [];
  static List<String> brand = [];
  static List<String> category = [];
  static List<int> checkvalue = [];
  static List<int> zrepcode = [];
  static List<String> reason = [];
  static List<String> fullname = [];
  static List<String> oos = [];
  static List<String> oosreason = [];
  static List<String> insreason = [];
  static List<String> isavail = [];
  static var nodata;
}

bool avaliabilitycheck = false;
