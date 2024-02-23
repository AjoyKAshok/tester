import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/utils/DatabaseHelper.dart';
import '../../../ConstantMethods.dart';
import '../../../offlinedata/sharedprefsdta.dart';
import '../../api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

var todayJPdata;
var overallJpdata;

Future<dynamic> getJourneyPlan() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  // todayJPdata = prefs.getString('todayjp');
  // print('Printing our JPData : ${todayJPdata}');

  // var printVal = jsonDecode(todayJPdata);
  // print('Encoded to Json : $printVal');
  // print('Length of JP Data: ${printVal['data'].length}');

  // COMMENTING OUT TO TEST IF THE BELOW TWO LINES ARE REQUIRED
  // todayJPdata = await getData(todayjp_table);
  // print("todayJPdata^^^^$todayJPdata");

  // if (todayJPdata == null || currentlysyncing) {

  Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
  print('Parameter for JP : $DBrequestData');
  try {
    http.Response JPresponse = await http.post(
      JPurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(DBrequestData),
    );
    if (JPresponse.statusCode == 200) {
      print('journey plan done from JP Online');
      todayJPdata = JPresponse.body;
      print("getJourneyPlan... online...$todayJPdata");
      // await addtodayjp(todayJPdata);

      // COMMENTING OUT TO TEST IF DATA IS TO BE SAVED TO THE SQL DATABASE THROUGH BELOW ONE LINE
      // await saveDataIntoDB(todayJPdata, todayjp_table);

      var decodeJPData = jsonDecode(todayJPdata);
      gettodayjp.storenames = [];
      gettodayjp.isscheduled = [];
      gettodayjp.distanceinmeters = [];
      gettodayjp.contactnumbers = [];
      gettodayjp.outletcountry = [];
      gettodayjp.outletcity = [];
      gettodayjp.outletarea = [];
      gettodayjp.storecodes = [];
      gettodayjp.id = [];
      gettodayjp.outletlong = [];
      gettodayjp.outletlat = [];
      gettodayjp.outletids = [];
      gettodayjp.checkouttime = [];
      gettodayjp.checkintime = [];
      gettodayjp.status = [];
      // gettodayjp.splitOutlet = [];
      for (int u = 0; u < decodeJPData['data'].length; u++) {
        dynamic storename = decodeJPData['data'][u]['store_name'];
        gettodayjp.storenames.add(storename);
        dynamic storecode = decodeJPData['data'][u]['store_code'];
        gettodayjp.storecodes.add(storecode);
        int isschdlue = decodeJPData['data'][u]['scheduled_calls'];
        gettodayjp.isscheduled.add(isschdlue);
        dynamic outletid = decodeJPData['data'][u]['outlet']['outlet_id'];
        gettodayjp.outletids.add(outletid);
        dynamic outletlat = decodeJPData['data'][u]['outlet']['outlet_lat'];
        gettodayjp.outletlat.add(outletlat);
        dynamic outletlong = decodeJPData['data'][u]['outlet']['outlet_long'];
        gettodayjp.outletlong.add(outletlong);
        dynamic outletarea = decodeJPData['data'][u]['outlet']['outlet_area'];
        gettodayjp.outletarea.add(outletarea);
        dynamic outletcity = decodeJPData['data'][u]['outlet']['outlet_city'];
        gettodayjp.outletcity.add(outletcity);
        dynamic outletcountry =
            decodeJPData['data'][u]['outlet']['outlet_country'];
        gettodayjp.outletcountry.add(outletcountry);
        dynamic tableid = decodeJPData['data'][u]['id'];
        gettodayjp.id.add(tableid);
        dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
        gettodayjp.contactnumbers.add(outletcontact);
        if (decodeJPData['data'][u]['checkin_time'] == null) {
          gettodayjp.checkintime.add('notcheckedin');
        } else {
          gettodayjp.checkintime.add(decodeJPData['data'][u]['checkin_time']);
        }
        if (decodeJPData['data'][u]['checkin_time'] == null) {
          gettodayjp.checkouttime.add('notcheckedout');
        } else {
          gettodayjp.checkouttime.add(decodeJPData['data'][u]['checkout_time']);
        }
        if (decodeJPData['data'][u]['checkin_time'] != null &&
            decodeJPData['data'][u]['checkout_time'] != null) {
          gettodayjp.status.add('done');
        } else if (decodeJPData['data'][u]['checkin_time'] != null &&
            decodeJPData['data'][u]['checkout_time'] == null) {
          gettodayjp.status.add('working');
        } else {
          gettodayjp.status.add('pending');
        }
        
      }

      print("lat: ${gettodayjp.outletlat}");
      print(gettodayjp.isscheduled);
    } else if (JPresponse.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      logout();
    } else {
      print(JPresponse.statusCode);
    }
  } on SocketException catch (_) {
    print("SocketException");
    // else {
    if (todayJPdata != null) {
      print("getJourneyPlan... offline...$todayJPdata");
      var decodeJPData = jsonDecode(todayJPdata);
      gettodayjp.storenames = [];
      gettodayjp.distanceinmeters = [];
      gettodayjp.contactnumbers = [];
      gettodayjp.outletcountry = [];
      gettodayjp.outletcity = [];
      gettodayjp.outletarea = [];
      gettodayjp.storecodes = [];
      gettodayjp.id = [];
      gettodayjp.outletlong = [];
      gettodayjp.outletlat = [];
      gettodayjp.outletids = [];
      gettodayjp.checkouttime = [];
      gettodayjp.checkintime = [];
      gettodayjp.status = [];
      // gettodayjp.splitOutlet = [];
      for (int u = 0; u < decodeJPData['data'].length; u++) {
        dynamic storename = decodeJPData['data'][u]['store_name'];
        gettodayjp.storenames.add(storename);
        dynamic storecode = decodeJPData['data'][u]['store_code'];
        gettodayjp.storecodes.add(storecode);
        int isschdlue = decodeJPData['data'][u]['scheduled_calls'];
        gettodayjp.isscheduled.add(isschdlue);
        dynamic outletid = decodeJPData['data'][u]['outlet']['outlet_id'];
        gettodayjp.outletids.add(outletid);
        dynamic outletlat = decodeJPData['data'][u]['outlet']['outlet_lat'];
        gettodayjp.outletlat.add(outletlat);
        dynamic outletlong = decodeJPData['data'][u]['outlet']['outlet_long'];
        gettodayjp.outletlong.add(outletlong);
        dynamic outletarea = decodeJPData['data'][u]['outlet']['outlet_area'];
        gettodayjp.outletarea.add(outletarea);
        dynamic outletcity = decodeJPData['data'][u]['outlet']['outlet_city'];
        gettodayjp.outletcity.add(outletcity);
        dynamic outletcountry =
            decodeJPData['data'][u]['outlet']['outlet_country'];
        gettodayjp.outletcountry.add(outletcountry);
        dynamic tableid = decodeJPData['data'][u]['id'];
        gettodayjp.id.add(tableid);
        dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
        gettodayjp.contactnumbers.add(outletcontact);
        if (decodeJPData['data'][u]['checkin_time'] == null) {
          gettodayjp.checkintime.add('notcheckedin');
        } else {
          gettodayjp.checkintime.add(decodeJPData['data'][u]['checkin_time']);
        }
        if (decodeJPData['data'][u]['checkin_time'] == null) {
          gettodayjp.checkouttime.add('notcheckedout');
        } else {
          gettodayjp.checkouttime.add(decodeJPData['data'][u]['checkout_time']);
        }
        if (decodeJPData['data'][u]['checkin_time'] != null &&
            decodeJPData['data'][u]['checkout_time'] != null) {
          gettodayjp.status.add('done');
        } else if (decodeJPData['data'][u]['checkin_time'] != null &&
            decodeJPData['data'][u]['checkout_time'] == null) {
          gettodayjp.status.add('working');
        } else {
          gettodayjp.status.add('pending');
        }
        // if (gettodayjp.status[u] == 'done') {
        //   gettodayjp.splitOutlet[u] = true;
        // }
      }
      print("lat: ${gettodayjp.outletlat}");
    }
    // }
    // return false;
  }
  
}

Future<dynamic> getOverAllJourneyPlan() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // todayJPdata = prefs.getString('todayjp');

  if (true) {
    print("todayJPdata...null");
    Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
    try {
      http.Response JPresponse = await http.post(
        overallJPurl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(DBrequestData),
      );
      if (JPresponse.statusCode == 200) {
        print('journey plan done');
        overallJpdata = JPresponse.body;
        print("${JPresponse.body}");
        // await addtodayjp(todayJPdata);
        var decodeJPData = jsonDecode(overallJpdata);
        getoveralljp.storenames = [];
        getoveralljp.isscheduled = [];
        getoveralljp.distanceinmeters = [];
        getoveralljp.contactnumbers = [];
        getoveralljp.outletcountry = [];
        getoveralljp.outletcity = [];
        getoveralljp.outletarea = [];
        getoveralljp.storecodes = [];
        getoveralljp.id = [];
        getoveralljp.date = [];
        getoveralljp.outletlong = [];
        getoveralljp.outletlat = [];
        getoveralljp.outletids = [];
        getoveralljp.checkouttime = [];
        getoveralljp.checkintime = [];
        getoveralljp.status = [];
        for (int u = 0; u < decodeJPData['data'].length; u++) {
          if (decodeJPData['data'][u]['store_name'] != null &&
              decodeJPData['data'][u]['outlet'] != null) {
            dynamic storename = decodeJPData['data'][u]['store_name'];
            getoveralljp.storenames.add(storename);
            dynamic storecode = decodeJPData['data'][u]['store_code'];
            getoveralljp.storecodes.add(storecode);
            int isschdlue = decodeJPData['data'][u]['scheduled_calls'];
            getoveralljp.isscheduled.add(isschdlue);
            dynamic outletid = decodeJPData['data'][u]['outlet']['outlet_id'];
            getoveralljp.outletids.add(outletid);
            dynamic outletlat = decodeJPData['data'][u]['outlet']['outlet_lat'];
            getoveralljp.outletlat.add(outletlat);
            dynamic outletlong =
                decodeJPData['data'][u]['outlet']['outlet_long'];
            getoveralljp.outletlong.add(outletlong);
            dynamic outletarea =
                decodeJPData['data'][u]['outlet']['outlet_area'];
            getoveralljp.outletarea.add(outletarea);
            dynamic outletcity =
                decodeJPData['data'][u]['outlet']['outlet_city'];
            getoveralljp.outletcity.add(outletcity);
            dynamic outletcountry =
                decodeJPData['data'][u]['outlet']['outlet_country'];
            getoveralljp.outletcountry.add(outletcountry);
            dynamic tableid = decodeJPData['data'][u]['id'];
            getoveralljp.id.add(tableid);
            dynamic tabledate = decodeJPData['data'][u]['date'];
            getoveralljp.date.add(tabledate);
            dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
            getoveralljp.contactnumbers.add(outletcontact);
            if (decodeJPData['data'][u]['checkin_time'] == null) {
              getoveralljp.checkintime.add('notcheckedin');
            } else {
              getoveralljp.checkintime
                  .add(decodeJPData['data'][u]['checkin_time']);
            }
            if (decodeJPData['data'][u]['checkin_time'] == null) {
              getoveralljp.checkouttime.add('notcheckedout');
            } else {
              getoveralljp.checkouttime
                  .add(decodeJPData['data'][u]['checkout_time']);
            }
            if (decodeJPData['data'][u]['checkin_time'] != null &&
                decodeJPData['data'][u]['checkout_time'] != null) {
              getoveralljp.status.add('done');
            } else if (decodeJPData['data'][u]['checkin_time'] != null &&
                decodeJPData['data'][u]['checkout_time'] == null) {
              getoveralljp.status.add('working');
            } else {
              getoveralljp.status.add('pending');
            }
          }
        }
        print("lat: ${getoveralljp.outletlat}");
        // print(getoveralljp.isscheduled);
      } else {
        print(JPresponse.statusCode);
      }
    } on SocketException catch (_) {
      print("SocketException");
      // else {
      if (overallJpdata != null) {
        var decodeJPData = jsonDecode(overallJpdata);
        getoveralljp.storenames = [];
        getoveralljp.distanceinmeters = [];
        getoveralljp.contactnumbers = [];
        getoveralljp.outletcountry = [];
        getoveralljp.outletcity = [];
        getoveralljp.outletarea = [];
        getoveralljp.storecodes = [];
        getoveralljp.id = [];
        getoveralljp.date = [];
        getoveralljp.outletlong = [];
        getoveralljp.outletlat = [];
        getoveralljp.outletids = [];
        getoveralljp.checkouttime = [];
        getoveralljp.checkintime = [];
        getoveralljp.status = [];
        for (int u = 0; u < decodeJPData['data'].length; u++) {
          if (decodeJPData['data'][u]['store_name'] != null &&
              decodeJPData['data'][u]['outlet'] != null) {
            dynamic storename = decodeJPData['data'][u]['store_name'];
            getoveralljp.storenames.add(storename);
            dynamic storecode = decodeJPData['data'][u]['store_code'];
            getoveralljp.storecodes.add(storecode);
            int isschdlue = decodeJPData['data'][u]['scheduled_calls'];
            getoveralljp.isscheduled.add(isschdlue);
            dynamic outletid = decodeJPData['data'][u]['outlet']['outlet_id'];
            getoveralljp.outletids.add(outletid);
            dynamic outletlat = decodeJPData['data'][u]['outlet']['outlet_lat'];
            getoveralljp.outletlat.add(outletlat);
            dynamic outletlong =
                decodeJPData['data'][u]['outlet']['outlet_long'];
            getoveralljp.outletlong.add(outletlong);
            dynamic outletarea =
                decodeJPData['data'][u]['outlet']['outlet_area'];
            getoveralljp.outletarea.add(outletarea);
            dynamic outletcity =
                decodeJPData['data'][u]['outlet']['outlet_city'];
            getoveralljp.outletcity.add(outletcity);
            dynamic outletcountry =
                decodeJPData['data'][u]['outlet']['outlet_country'];
            getoveralljp.outletcountry.add(outletcountry);
            dynamic tableid = decodeJPData['data'][u]['id'];
            getoveralljp.id.add(tableid);
            dynamic tabledate = decodeJPData['data'][u]['date'];
            getoveralljp.date.add(tabledate);
            dynamic outletcontact = decodeJPData['data'][u]['contact_number'];
            getoveralljp.contactnumbers.add(outletcontact);
            if (decodeJPData['data'][u]['checkin_time'] == null) {
              getoveralljp.checkintime.add('notcheckedin');
            } else {
              getoveralljp.checkintime
                  .add(decodeJPData['data'][u]['checkin_time']);
            }
            if (decodeJPData['data'][u]['checkin_time'] == null) {
              getoveralljp.checkouttime.add('notcheckedout');
            } else {
              getoveralljp.checkouttime
                  .add(decodeJPData['data'][u]['checkout_time']);
            }
            if (decodeJPData['data'][u]['checkin_time'] != null &&
                decodeJPData['data'][u]['checkout_time'] != null) {
              getoveralljp.status.add('done');
            } else if (decodeJPData['data'][u]['checkin_time'] != null &&
                decodeJPData['data'][u]['checkout_time'] == null) {
              getoveralljp.status.add('working');
            } else {
              getoveralljp.status.add('pending');
            }
          }
        }
        print("lat: ${getoveralljp.outletlat}");
      }
      // }
      // return false;
    }
  } 
}

class gettodayjp {
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
  static List<bool> splitOutlet = [];
  static List<double> sortdistnce = [];
  static List<int> isscheduled = [];
  static List<dynamic> checkintime = [];
  static List<dynamic> checkouttime = [];
  static List<String> status = [];
}

class getoveralljp {
  static List<dynamic> storecodes = [];
  static List<dynamic> storenames = [];
  static List<dynamic> outletids = [];
  static List<dynamic> outletlat = [];
  static List<dynamic> outletlong = [];
  static List<dynamic> outletarea = [];
  static List<dynamic> outletcity = [];
  static List<dynamic> outletcountry = [];
  static List<dynamic> id = [];
  static List<dynamic> date = [];
  static List<dynamic> contactnumbers = [];
  static List<double> distanceinmeters = [];

  static List<double> sortdistnce = [];
  static List<int> isscheduled = [];
  static List<dynamic> checkintime = [];
  static List<dynamic> checkouttime = [];
  static List<String> status = [];
}
