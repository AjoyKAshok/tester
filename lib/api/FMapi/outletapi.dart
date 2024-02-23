import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';
import 'storedetailsapi.dart';

class updateoutlet {
  static bool outletedit = false;
  static int outletid;
  static String name;
}

Future getFMoutletdetails() async {
  Map DBrequestData = {'emp_id': '${updateoutlet.outletid}'};
  print("getFMoutletdetails...${DBrequestData}");
  http.Response OutletDetails = await http.post(
    OCurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(DBrequestData),
  );
  if (OutletDetails.statusCode == 200) {
    print("getOutlet Details Done");
    // print(OutletDetails.body);

    String outletdetdata = OutletDetails.body;

    var decodeoutlet = jsonDecode(outletdetdata);
    outletdata.outletid = [];
    outletdata.contactnumber = [];
    outletdata.outletname = [];
    outletdata.outletname_notempty = [];

    outletdata.outletlat = [];
    outletdata.outletlong = [];
    outletdata.outletarea = [];
    outletdata.outletcity = [];
    outletdata.outletstate = [];
    outletdata.outletcountry = [];
    outletdata.address = [];
    outletdata.code = [];
    for (int u = 0; u < decodeoutlet['data'].length; u++) {
      if (decodeoutlet['data'][u]['store'].length == 0) {
        outletdata.contactnumber.add("");
        outletdata.address.add("");
        outletdata.code.add("");
        outletdata.outletname.add("");
        // outletdata.outletid.add("");
      } else {
        outletdata.contactnumber
            .add(decodeoutlet['data'][u]['store'][0]['contact_number'] ?? "");
        outletdata.address.add(decodeoutlet['data'][u]['store'][0]['address']);
        dynamic code = decodeoutlet['data'][u]['store'][0]['store_code'];
        outletdata.code.add(code);
        dynamic outletid = decodeoutlet['data'][u]['outlet_id'];
        outletdata.outletid.add(outletid);
        // print(outletdata.outletid);
        dynamic outletname = decodeoutlet['data'][u]['store'][0]['store_name'];
        outletdata.outletname.add('[$code] $outletname');
        outletdata.outletname_notempty.add('[$code] [$outletid] $outletname');
      }

      // outletdata.outletid.add(decodeoutlet['data'][u]['outlet_id']);
      dynamic outletlat = decodeoutlet['data'][u]['outlet_lat'];
      outletdata.outletlat.add(outletlat);
      dynamic outletlong = decodeoutlet['data'][u]['outlet_long'];
      outletdata.outletlong.add(outletlong);
      dynamic outletarea = decodeoutlet['data'][u]['outlet_area'];
      outletdata.outletarea.add(outletarea);
      dynamic outletcity = decodeoutlet['data'][u]['outlet_city'];
      outletdata.outletcity.add(outletcity);
      dynamic outletstate = decodeoutlet['data'][u]['outlet_state'];
      outletdata.outletstate.add(outletstate);
      dynamic outletcountry = decodeoutlet['data'][u]['outlet_country'];
      outletdata.outletcountry.add(outletcountry);
    }
    await getStoreDetails();
    store.addoutlet = [];
    store.storeid = [];
    for (int u = 0; u < storesdata.storename.length; u++) {
      if (outletdata.outletname.contains(storesdata.storename[u])) {
      } else {
        store.addoutlet.add(storesdata.storename[u]);
        store.storeid.add(storesdata.id[u]);
        // print('Store Names: ${storesdata.storename[u]}');
        // print('Store Ids: ${storesdata.id[u]}');
      }
    }
  }
  if (OutletDetails.statusCode != 200) {
    print(OutletDetails.statusCode);
    print('Outlet Body : ${OutletDetails.body}');
  }
}

class outletdata {
  static List<int> outletid = [];
  static List<dynamic> contactnumber = [];
  static List<String> outletname = [];
  static List<dynamic> outletlat = [];
  static List<dynamic> outletlong = [];
  static List<dynamic> outletarea = [];
  static List<dynamic> outletcity = [];
  static List<dynamic> outletstate = [];
  static List<dynamic> outletcountry = [];
  static List<dynamic> address = [];
  static List<dynamic> code = [];
  static List<String> outletname_notempty = [];
}

class store {
  static List<String> addoutlet = [];
  static List<int> storeid = [];
}

Future getupdatingoutletdata() async {
  Map ODrequestDataforcheckin = {
    "emp_id": "${DBrequestdata.receivedempid}",
    'outlet_id': '${updateoutlet.outletid}',
  };
  print("getupdatingoutletdata...$ODrequestDataforcheckin");
  http.Response OCresponse = await http.post(
    OCurl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(ODrequestDataforcheckin),
  );
  if (OCresponse.statusCode == 200) {
    String OCdata = OCresponse.body;
    var decodeODData = jsonDecode(OCdata);

    if (decodeODData['data'][0]['store'].length == 0) {
      updatingoutlet.outletname = "";
      updatingoutlet.name = "";
    } else {
      updatingoutlet.outletname =
          '[${decodeODData['data'][0]['store'][0]["store_code"]}] ${decodeODData['data'][0]['store'][0]["store_name"]}';
      updatingoutlet.name = decodeODData['data'][0]['store'][0]["store_name"];
    }
    updatingoutlet.area = decodeODData['data'][0]['outlet_area'];

    updatingoutlet.city = decodeODData['data'][0]['outlet_city'];
    updatingoutlet.state = decodeODData['data'][0]['outlet_state'];
    updatingoutlet.country = decodeODData['data'][0]['outlet_country'];
    updatingoutlet.lat = decodeODData['data'][0]['outlet_lat'];
    updatingoutlet.long = decodeODData['data'][0]['outlet_long'];
  }

  if (OCresponse.statusCode != 200) {
    print(OCresponse.statusCode);
  }
}

class updatingoutlet {
  static var outletname;
  static var name;
  static var lat;
  static var long;
  static var area;
  static var city;
  static var state;
  static var country;
}
