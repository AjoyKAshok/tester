import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:merchandising/ConstantMethods.dart";
import 'package:photo_view/photo_view.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/clientapi/outletreport.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/customer_activites_api/competition_details.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/api/clientapi/clientpromodetailes.dart';
import 'package:merchandising/api/clientapi/stockexpirydetailes.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'reports.dart';
import 'package:merchandising/api/sendfile.dart';

bool Exportall = false;
String pathtoexport;

Future<String> ExportStockExpiry() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < Stockdata.productname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("SKU[Zrep]");
      row.add("Expiry datae");
      row.add("Price");
      row.add("Near Expire");
      row.add("value");
      row.add("Exposure Quantity");
      row.add("Estimated Expiry Value");
      row.add("Capture Period");
      row.add("Expiry Period");
      row.add("Remarks");
      row.add("Captured By");
      employeeData.add(row);
    } else {
      row.add(Stockdata.productname[i - 8]);
      row.add(Stockdata.expirydate[i - 8]);
      row.add(Stockdata.pieceperprice[i - 8]);
      row.add(Stockdata.nearexpiry[i - 8]);
      row.add(Stockdata.nearexpiryvalue[i - 8]);
      row.add(Stockdata.exposurequantity[i - 8]);
      row.add(Stockdata.nearexpiryvalue[i - 8]);
      row.add(Stockdata.period[i - 8]);
      row.add(Stockdata.expiryperiod[i - 8]);
      row.add(Stockdata.remarks[i - 8]);
      row.add(Stockdata.capturedby[i - 8]);
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
    String dir = (await getExternalStorageDirectory()).path +
        "/Expiryinfo${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    print(dir);
    return dir;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}

Future<String> Exportavaiablity() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < Avaiablity.productname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("Product Name");
      //row.add("zrep");
      row.add("Status");
      row.add("Reason");
      employeeData.add(row);
    } else {
      print(Avaiablity.zrepcode.length);
      row.add('${Avaiablity.productname[i - 8]}');
      //row.add(Avaiablity.zrepcode[i-8]);
      row.add(Avaiablity.checkvalue[i - 8].toString() == "1"
          ? "IN Stock"
          : "Not Available");
      row.add(Avaiablity.reason[i - 8] == null ? "" : Avaiablity.reason[i - 8]);
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
//     String newdir = (await getExternalStorageDirectory()).path +"/reports${DateFormat.Hm().format(DateTime.now())}";
//     print(newdir);
    String dir = (await getExternalStorageDirectory()).path +
        "/Availabitydata${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    // new Directory(newdir).create().then((Directory directory) {
    //    print(directory.path);
    //  });
    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    print(dir);
    return dir;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}

Future<String> ExportVisibility() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < VisibilityData.categoryname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("Category  Name");
      //row.add("zrep");
      row.add("Status");
      row.add("Reason/Img");
      employeeData.add(row);
      print("length");
      print(VisibilityData.isavailable.length);
    } else if (VisibilityData.isavailable[i - 8] != null) {
      row.add('${VisibilityData.categoryname[i - 8]}');
      //row.add(Avaiablity.zrepcode[i-8]);
      row.add(VisibilityData.isavailable[i - 8].toString() == "1"
          ? "IN Stock"
          : "Not Available");
      row.add(VisibilityData.isavailable[i - 8].toString() == "1"
          ? "https://test.rhapsody.ae/visibility_image/${VisibilityData.imageurl[i - 8]}"
          : VisibilityData.reason[i - 8].toString());
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
//     String newdir = (await getExternalStorageDirectory()).path +"/reports${DateFormat.Hm().format(DateTime.now())}";
//     print(newdir);
    String dir = (await getExternalStorageDirectory()).path +
        "/visibilitydata${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    // new Directory(newdir).create().then((Directory directory) {
    //    print(directory.path);
    //  });
    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    print(dir);
    return dir;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}

Future<File> ExportShareofshelf() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < ShareData.categoryname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("Category  Name");
      row.add("Target");
      row.add("Share");
      row.add("Actual percent");
      employeeData.add(row);
    } else {
      row.add('${ShareData.categoryname[i - 8]}');
      row.add("${ShareData.target[i - 8]} %");
      row.add("${ShareData.share[i - 8]} m");
      row.add("${ShareData.actualpercent[i - 8]} %");
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
//     String newdir = (await getExternalStorageDirectory()).path +"/reports${DateFormat.Hm().format(DateTime.now())}";
//     print(newdir);
    //var downloadspath = await DownloadsPathProvider.downloadsDirectory;
    String dir = (await getExternalStorageDirectory()).path +
        "/shareofshelfdata${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    // new Directory(newdir).create().then((Directory directory) {
    //    print(directory.path);
    //  });
    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    return f;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}

Future<String> ExportPLanogram() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < PlanoDetails.categoryname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("Category  Name");
      row.add("Before Image Url");
      row.add("After Image Url");
      employeeData.add(row);
    } else {
      row.add('${PlanoDetails.categoryname[i - 8]}');
      row.add(PlanoDetails.beforeimage[i - 8].toString());
      row.add(PlanoDetails.afterimage[i - 8].toString());
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
//     String newdir = (await getExternalStorageDirectory()).path +"/reports${DateFormat.Hm().format(DateTime.now())}";
//     print(newdir);
    print("check export");
    print(Exportall);
    String dir = Exportall
        ? pathtoexport +
            "/PLanogramData${DateFormat.Hm().format(DateTime.now())}.csv"
        : (await getExternalStorageDirectory()).path +
            "/PLanogramData${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    // new Directory(newdir).create().then((Directory directory) {
    //    print(directory.path);
    //  });

    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    print(dir);
    return dir;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}

Future<String> ExportCompetation() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < CompetitionData.brandname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("Product Name");
      row.add("Company Name");
      row.add("Category");
      row.add("Regular price");
      row.add("Selling price");
      row.add("Promotion Type");
      row.add("Promotion Description");
      row.add("Captured Image");
      employeeData.add(row);
    } else {
      row.add('${CompetitionData.itemname[i - 8]}');
      row.add(CompetitionData.companyname[i - 8].toString());
      row.add(CompetitionData.brandname[i - 8].toString());
      row.add(CompetitionData.mrp[i - 8].toString());
      row.add('${CompetitionData.sellingprice[i - 8]}');
      row.add(CompetitionData.promotype[i - 8].toString());
      row.add(CompetitionData.promodesc[i - 8].toString());
      row.add(CompetitionData.captureimg[i - 8].toString());
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
//     String newdir = (await getExternalStorageDirectory()).path +"/reports${DateFormat.Hm().format(DateTime.now())}";
//     print(newdir);
    String dir = (await getExternalStorageDirectory()).path +
        "/CompetitorData${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    // new Directory(newdir).create().then((Directory directory) {
    //    print(directory.path);
    //  });

    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    print(dir);
    return dir;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}

Future<String> Exportpromotion() async {
  List<List<dynamic>> employeeData = [];
  for (int i = 0; i < CompetitionData.brandname.length + 8; i++) {
    print(i);
    List<dynamic> row = [];
    if (i == 0) {
      row.add("Outlet");
      row.add(ClientOutlets.outletname[indexclientselected]);
      employeeData.add(row);
    } else if (i == 1) {
      row.add("visited on");
      row.add(ClientOutlets.lastvisiteddate[indexclientselected]);
      employeeData.add(row);
    } else if (i == 2) {
      row.add("Check IN Time");
      row.add(ClientOutlets.checkintime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 3) {
      row.add("Check out Time");
      row.add(ClientOutlets.checkouttime[indexclientselected]);
      employeeData.add(row);
    } else if (i == 4) {
      row.add("Check IN Location");
      row.add(ClientOutlets.checkinlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 5) {
      row.add("Check Out Time");
      row.add(ClientOutlets.checkoutlocation[indexclientselected]);
      employeeData.add(row);
    } else if (i == 6) {
      row.add("Visited By");
      row.add(ClientOutlets.merchandiserid[indexclientselected]);
      employeeData.add(row);
    } else if (i == 7) {
      row.add("Product Name");
      row.add("Status");
      row.add("url/Reason");
      employeeData.add(row);
    } else {
      row.add('${ClientPromo.product[i - 8]}');
      row.add(ClientPromo.status[i - 8].toString());
      row.add(ClientPromo.reasoning[i - 8].toString());
      employeeData.add(row);
    }
  }
  print("permissions");
  print(await Permission.storage.request().isGranted);
  if (await Permission.storage.request().isGranted) {
//store file in documents folder
//     String newdir = (await getExternalStorageDirectory()).path +"/reports${DateFormat.Hm().format(DateTime.now())}";
//     print(newdir);
    String dir = (await getExternalStorageDirectory()).path +
        "/PromotiondataData${DateFormat.Hm().format(DateTime.now())}.csv";
    String file = "$dir";
    // new Directory(newdir).create().then((Directory directory) {
    //    print(directory.path);
    //  });

    File f = new File(file);
// convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(employeeData);
    f.writeAsString(csv);
    print(dir);
    return dir;
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
}
