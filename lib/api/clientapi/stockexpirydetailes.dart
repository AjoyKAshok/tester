import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/ConstantMethods.dart';
import '../api_service.dart';
import '../api_service2.dart';

// ignore: non_constant_identifier_names
Future Addedstockdataforclient() async {
  print("calling added expiry data");
  Map body = {'outlet_id': '$currentoutletid'};
  print(jsonEncode(body));
  http.Response response = await http.post(
    Uri.parse(
        "https://rms2.rhapsody.ae/api/client_view_outlet_stock_expirey_details"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  if (response.statusCode == 200) {
    String outletdetdata = response.body;
    var decodeoutlet = jsonDecode(outletdetdata);
    Stockdata.productname = [];
    Stockdata.captureddate = [];
    Stockdata.outletid = [];
    Stockdata.pieceperprice = [];
    Stockdata.nearexpiry = [];
    Stockdata.exposurequantity = [];
    Stockdata.expirydate = [];
    Stockdata.remarks = [];
    Stockdata.capturedby = [];
    Stockdata.zrepcode = [];
    Stockdata.nearexpiryvalue = [];
    Stockdata.estimateexpiryvalue = [];
    Stockdata.period = [];
    Stockdata.expiryperiod = [];
    Stockdata.outlet = [];
    for (int u = 0; u < decodeoutlet['data'].length; u++) {
      Stockdata.productname.add(decodeoutlet['data'][u]['description']);
      Stockdata.captureddate.add(decodeoutlet['data'][u]['date']);
      Stockdata.outletid.add(decodeoutlet['data'][u]['outlet_id']);
      Stockdata.pieceperprice.add(decodeoutlet['data'][u]['piece_price']);
      Stockdata.nearexpiry.add(decodeoutlet['data'][u]['near_expiry']);
      Stockdata.exposurequantity.add(decodeoutlet['data'][u]['exposure_qty']);
      Stockdata.expirydate.add(decodeoutlet['data'][u]['expiry_date']);
      Stockdata.remarks.add(decodeoutlet['data'][u]['remarks']);
      Stockdata.capturedby.add(decodeoutlet['data'][u]['merchandiser_name']);
      Stockdata.zrepcode.add(decodeoutlet['data'][u]['zrep']);
      Stockdata.nearexpiryvalue
          .add(decodeoutlet['data'][u]['near_expiry_value']);
      Stockdata.estimateexpiryvalue
          .add(decodeoutlet['data'][u]['extimate_expire_value']);
      Stockdata.period.add(decodeoutlet['data'][u]['period']);
      Stockdata.expiryperiod.add(decodeoutlet['data'][u]['expiry_period']);
      Stockdata.outlet.add(decodeoutlet['data'][u]['store_name']);
    }
    print(Stockdata.period);
    print("expiry data done");
  }
  if (response.statusCode != 200) {
    print(response.statusCode);
  }
}

class Stockdata {
  static List<dynamic> productname = [];
  static List<String> captureddate = [];
  static List<dynamic> outletid = [];
  static List<dynamic> pieceperprice = [];
  static List<dynamic> nearexpiry = [];
  static List<dynamic> exposurequantity = [];
  static List<dynamic> expirydate = [];
  static List<dynamic> remarks = [];
  static List<dynamic> capturedby = [];
  static List<dynamic> zrepcode = [];
  static List<dynamic> nearexpiryvalue = [];
  static List<dynamic> estimateexpiryvalue = [];
  static List<dynamic> period = [];
  static List<dynamic> expiryperiod = [];
  static List<dynamic> outlet = [];
}

// ignore: non_constant_identifier_names
Future Addedstockdataformerch() async {
  print("calling added expiry data");
  Map body = {
    "emp_id": DBrequestdata.receivedempid,
  };
  print(jsonEncode(body));
  try{
    http.Response response = await http.post(
      Uri.parse(
          "https://rms2.rhapsody.ae/api/merchandiser_view_updated_stock_expirey_details"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      String outletdetdata = response.body;
      var decodeoutlet = jsonDecode(outletdetdata);
      StockDataMerch.productname = [];
      StockDataMerch.captureddate = [];
      StockDataMerch.outletid = [];
      StockDataMerch.pieceperprice = [];
      StockDataMerch.nearexpiry = [];
      StockDataMerch.exposurequantity = [];
      StockDataMerch.expirydate = [];
      StockDataMerch.remarks = [];
      StockDataMerch.capturedby = [];
      StockDataMerch.zrepcode = [];
      StockDataMerch.nearexpiryvalue = [];
      StockDataMerch.estimateexpiryvalue = [];
      StockDataMerch.period = [];
      StockDataMerch.expiryperiod = [];
      StockDataMerch.outlet = [];
      StockDataMerch.Productlocation = [];
      StockDataMerch.Customerstoregroup = [];
      StockDataMerch.Uom = [];
      StockDataMerch.categoryname = [];

      print(decodeoutlet['data'].length);
      for (int u = 0; u < decodeoutlet['data'].length; u++) {
        print("here");
        print(decodeoutlet['data'][u]['outlet_id'].toString());
        print(currentoutletid);
      /*  if (decodeoutlet['data'][u]['outlet_id'].toString() ==
            "$currentoutletid") {*/
        var d =decodeoutlet['data'][u]['outlet_id'];
        print("Des"+ '$d');
        print("currentoutletid"+ '$currentoutletid');
          print(
              '${decodeoutlet['data'][u]['created_at']} ${decodeoutlet['data'][u]['description']}}');
          StockDataMerch.productname.add(
              "${decodeoutlet['data'][u]['description']} [${decodeoutlet['data'][u]['zrep']}]");
          StockDataMerch.captureddate.add(decodeoutlet['data'][u]['created_at']);
          StockDataMerch.outletid.add(decodeoutlet['data'][u]['outlet_id']);
          StockDataMerch.pieceperprice
              .add(decodeoutlet['data'][u]['piece_price']);
          StockDataMerch.nearexpiry
              .add(decodeoutlet['data'][u]['number_ of_ expiry_items_count']);
          StockDataMerch.exposurequantity
              .add(decodeoutlet['data'][u]['exposure_qty']);
          StockDataMerch.expirydate.add(decodeoutlet['data'][u]['expiry_date']);
          StockDataMerch.remarks.add(decodeoutlet['data'][u]['remarks']);
          StockDataMerch.nearexpiryvalue
              .add(decodeoutlet['data'][u]['near_expiry_value']);
          StockDataMerch.outlet.add(decodeoutlet['data'][u]['store_name']);
          StockDataMerch.outlet.add(decodeoutlet['data'][u]['store_name']);
          StockDataMerch.Productlocation.add(
              decodeoutlet['data'][u]['prodcut_location']);
          StockDataMerch.Customerstoregroup.add(
              decodeoutlet['data'][u]['customer_storegroup']);
          StockDataMerch.Uom.add(decodeoutlet['data'][u]['uom']);

          StockDataMerch.categoryname
              .add(decodeoutlet['data'][u]['category_name']);
        // }
      }
    }
    if (response.statusCode != 200) {
      print(response.statusCode);
    }
  }
  on SocketException catch (_) {
    adddataforsync(
        "https://rms2.rhapsody.ae/api/merchandiser_view_updated_stock_expirey_details",
        jsonEncode(body),
        " ");
  }


}

class StockDataMerch {
  static List<dynamic> productname = [];
  static List<String> captureddate = [];
  static List<dynamic> outletid = [];
  static List<dynamic> pieceperprice = [];
  static List<dynamic> nearexpiry = [];
  static List<dynamic> exposurequantity = [];
  static List<dynamic> expirydate = [];
  static List<dynamic> remarks = [];
  static List<dynamic> capturedby = [];
  static List<dynamic> zrepcode = [];
  static List<dynamic> nearexpiryvalue = [];
  static List<dynamic> estimateexpiryvalue = [];
  static List<dynamic> period = [];
  static List<dynamic> expiryperiod = [];
  static List<dynamic> outlet = [];
  static List<dynamic> Productlocation = [];
  static List<dynamic> Customerstoregroup = [];
  static List<dynamic> Uom = [];

  static List<dynamic> categoryname = [];
}
