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
    print('Get Planogram : ${PlanoResponse.statusCode}');
    if (PlanoResponse.statusCode == 200) {
      print('In getPlanogram method : $body');
      var test = jsonDecode(PlanoResponse.body);
      PlanoDetails.imageurl = [];
      PlanoDetails.beforeimage = [];
      PlanoDetails.afterimage = [];
      PlanoDetails.brandname = [];
      PlanoDetails.categoryname = [];
      PlanoDetails.categoryid = [];

      print('Planogram Details done');
      String planobody = PlanoResponse.body;
      print("getPlanogram...online...$planobody");
      // print(
      //     "getPlanogram...online...checking... ${test['data'][0]['store_name']}");
      await saveActivitiesDataIntoDB(
          currenttimesheetid.toString(), planobody, planodetaildata_table);

      var decodeddata = jsonDecode(planobody);
      if (decodeddata['data'].length == 0) {
        print("No Data");
        PlanoDetails.nodata = "nodata";
        print(PlanoDetails.nodata);
      } else {
        for (int u = 0; u < decodeddata['data'].length; u++) {
          if (decodeddata['data'][u]['category_name'] != null) {
            PlanoDetails.image
                .add('${decodeddata['data'][u]['planogram_img']}');
            PlanoDetails.imageurl.add(
                "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['planogram_img']}");

            // PlanoDetails.beforeimage.add(
            //     "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['before_image']}");
            PlanoDetails.beforeimage
                .add("${decodeddata['data'][u]['before_image']}");

            // PlanoDetails.afterimage.add(
            //     "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['after_image']}");
            PlanoDetails.afterimage
                .add("${decodeddata['data'][u]['after_image']}");

            PlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
            PlanoDetails.opm.add(decodeddata['data'][u]['opm']);
            PlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
            PlanoDetails.categoryname
                .add(decodeddata['data'][u]['category_name']);
            PlanoDetails.categoryid.add(decodeddata['data'][u]['c_id']);

            if (decodeddata['data'][u]['before_image'] != null) {
              planocheck = true;
            }
          }
        }
      }

      // print('Image Url : ${PlanoDetails.imageurl}');
      // print('Before Image Url : ${PlanoDetails.beforeimage}');
      // print('After Image Url : ${PlanoDetails.afterimage}');
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
  } on SocketException catch (_) {
    String planodetailsdata = await getActivityData(
        planodetaildata_table, currenttimesheetid.toString());
    print("getPlanogram...offline...$planodetailsdata");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    PlanoDetails.categoryname = [];
    if (planodetailsdata != null) {
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
        print('Get Planogram Check for Data: ${PlanoDetails.nodata}');
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        if (decodeddata['data'][u]['category_name'] != null) {
          PlanoDetails.image.add('${decodeddata['data'][u]['planogram_img']}');
          PlanoDetails.imageurl.add(
              "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['planogram_img']}");
          PlanoDetails.beforeimage.add(
              "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['before_image']}");
          //    PlanoDetails.beforeimage.add(
          // "${decodeddata['data'][u]['before_image']}");

          PlanoDetails.afterimage.add(
              "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['after_image']}");
          //  PlanoDetails.afterimage.add(
          // "${decodeddata['data'][u]['after_image']}");

          PlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
          PlanoDetails.opm.add(decodeddata['data'][u]['opm']);
          PlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
          PlanoDetails.categoryname
              .add(decodeddata['data'][u]['category_name']);
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
        beforeimages.add(File('dummy.png'));
        afterimages.add(File('dummy.png'));
        beforeimagesencode.add('dummy.png');
        afterimagesencode.add('dummy.png');
      }
    }

    return false;
  }
}

// Future<void> getPlanogramDetails() async {
//   print("getPlanogramDetails");
//   Map<String, dynamic> itemMap;
//   Map body = {"time_sheet_id": "$currenttimesheetid"};
//   try {
//     http.Response PlanoResponse = await http.post(
//       PlanogramDetails,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(body),
//     );
//     print(jsonEncode(body));
//     print('Get Planogram Details : ${PlanoResponse.statusCode}');
//     if (PlanoResponse.statusCode == 200) {
//       print('In getPlanogramDetails method : $body');
//       var test = jsonDecode(PlanoResponse.body);
//       List<dynamic> testData = test['data'];

//       GetPlanoDetails.imageurl = [];
//       GetPlanoDetails.beforeimage = [];
//       GetPlanoDetails.afterimage = [];
//       GetPlanoDetails.brandname = [];
//       GetPlanoDetails.categoryname = [];
//       GetPlanoDetails.categoryid = [];
//       GetPlanoDetails.planogram_items = [];

//       for (var i = 0; i < testData.length; i++) {
//         for (var item in testData) {
//           String cName = testData[i]['category_name'];
//           int cId = testData[i]['id'];

//           String bImage = testData[i]['before_image'];
//           String aImage = testData[i]['after_image'];

//           itemMap = {
//             'category_name': cName,
//             'category_id': cId,
//             'before_image': bImage,
//             'after_image': aImage,
//           };
//         }
//         // Add the map to the list
//         GetPlanoDetails.planogram_items.add(itemMap);
//       }
//       print(
//           'Check from Get Planogram Details: ${GetPlanoDetails.planogram_items}');
//       print('Get Planogram Details done');
//       String planobody = PlanoResponse.body;
//       print("getPlanogramDetails...online...$planobody");
//       // print(
//       //     "getPlanogram...online...checking... ${test['data'][0]['store_name']}");
//       await saveActivitiesDataIntoDB(
//           currenttimesheetid.toString(), planobody, planodetaildata_table);

//       var decodeddata = jsonDecode(planobody);
//       print('From Get Planogram Data : $decodeddata');
//       if (decodeddata['data'].length == 0) {
//         print("No Data");
//         GetPlanoDetails.nodata = "nodata";
//         print(GetPlanoDetails.nodata);
//       } else {
//         for (int u = 0; u < decodeddata['data'].length; u++) {
//           if (decodeddata['data'][u]['category_name'] != null) {
//             // GetPlanoDetails.image
//             //     .add('${decodeddata['data'][u]['before_image']}');
//             // GetPlanoDetails.imageurl.add(
//             //     "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['planogram_img']}");
//             if (decodeddata['data'][u]['planograms'] == []) {
//               GetPlanoDetails.beforeimage.add(
//                   "${decodeddata['data'][u]['planograms'][0]['before_image']}");

//               GetPlanoDetails.afterimage.add(
//                   "${decodeddata['data'][u]['planograms'][0]['after_image']}");
//             } else {
//               GetPlanoDetails.beforeimage.add(
//                   "${decodeddata['data'][u]['planograms'][0]['before_image']}");

//               GetPlanoDetails.afterimage.add(
//                   "${decodeddata['data'][u]['planograms'][0]['after_image']}");
//             }

//             GetPlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
//             GetPlanoDetails.opm.add(decodeddata['data'][u]['opm']);
//             GetPlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
//             GetPlanoDetails.categoryname
//                 .add(decodeddata['data'][u]['category_name']);
//             GetPlanoDetails.categoryid.add(decodeddata['data'][u]['id']);

//             if (decodeddata['data'][u]['before_image'] != null) {
//               planocheck = true;
//             }
//           }
//         }
//       }

//       // print('Image Url : ${GetPlanoDetails.opm}');
//       // print('Before Image Url : ${GetPlanoDetails.beforeimage}');
//       // print('After Image Url : ${GetPlanoDetails.afterimage}');
//       // beforeimages = [];
//       // afterimages = [];
//       // beforeimagesencode = [];
//       // afterimagesencode = [];
//       // for (int i = 0; i < PlanoDetails.brandname.length; i++) {
//       //   beforeimages.add(File('dummy.txt'));
//       //   afterimages.add(File('dummy.txt'));
//       //   beforeimagesencode.add('dummy.txt');
//       //   afterimagesencode.add('dummy.txt');
//       // }
//     }
//   } on SocketException catch (_) {
//     String planodetailsdata = await getActivityData(
//         planodetaildata_table, currenttimesheetid.toString());
//     print("getPlanogram...offline...$planodetailsdata");
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     GetPlanoDetails.categoryname = [];
//     if (planodetailsdata != null) {
//       GetPlanoDetails.imageurl = [];
//       GetPlanoDetails.beforeimage = [];
//       GetPlanoDetails.afterimage = [];
//       GetPlanoDetails.brandname = [];
//       GetPlanoDetails.categoryname = [];
//       GetPlanoDetails.categoryid = [];
//       print("not null");
//       // offlineplanodata = prefs.getStringList('planodetaildata')??[];
//       //
//       // String data = offlineplanodata[currentoutletindex];
//       var decodeddata = jsonDecode(planodetailsdata);
//       print('From Get Planogram Data : $decodeddata');
//       if (decodeddata['data'].length == 0) {
//         print("No Data");
//         GetPlanoDetails.nodata = "nodata";
//         print('Get Planogram Check for Data: ${GetPlanoDetails.nodata}');
//       } else {
//         for (int u = 0; u < decodeddata['data'].length; u++) {
//           if (decodeddata['data'][u]['category_name'].isEmpty) {
//             GetPlanoDetails.image
//                 .add('${decodeddata['data'][u]['before_image']}');
//             GetPlanoDetails.imageurl
//                 .add("${decodeddata['data'][u]['planogram_img']}");
//           } else {

//           }
//             // GetPlanoDetails.afterimage
//             //     .add("${decodeddata['data'][u]['after_image']}");

//             GetPlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
//             GetPlanoDetails.opm.add(decodeddata['data'][u]['opm']);
//             GetPlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
//             GetPlanoDetails.categoryname
//                 .add(decodeddata['data'][u]['category_name']);
//             GetPlanoDetails.categoryid.add(decodeddata['data'][u]['id']);

//             if (decodeddata['data'][u]['before_image'] != null) {
//               planocheck = true;
//             }
//           }
//         }
      
//       beforeimages = [];
//       afterimages = [];
//       beforeimagesencode = [];
//       afterimagesencode = [];
//       for (int i = 0; i < GetPlanoDetails.brandname.length; i++) {
//         beforeimages.add(File('dummy.png'));
//         afterimages.add(File('dummy.png'));
//         beforeimagesencode.add('dummy.png');
//         afterimagesencode.add('dummy.png');
//       }
//     }

//     return false;
//   }
// }


Future<void> getPlanogramDetails() async {
  print("getPlanogramDetails");
  Map<String, dynamic> itemMap;
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
    print(jsonEncode(body));
    print('Get Planogram Details : ${PlanoResponse.statusCode}');
    if (PlanoResponse.statusCode == 200) {
      print('In getPlanogramDetails method : $body');
      var test = jsonDecode(PlanoResponse.body);
      List<dynamic> testData = test['data'];

      print('Printing out the test Data from Planogram detaisl : $testData');

      GetPlanoDetails.imageurl = [];
      GetPlanoDetails.beforeimage = [];
      GetPlanoDetails.afterimage = [];
      GetPlanoDetails.brandname = [];
      GetPlanoDetails.categoryname = [];
      GetPlanoDetails.categoryid = [];
      GetPlanoDetails.planogram_items = [];

      for (var i = 0; i < testData.length; i++) {
        for (var item in testData) {
          String cName = testData[i]['category_name'];
          int cId = testData[i]['id'];

          String bImage = testData[i]['before_image'];
          String aImage = testData[i]['after_image'];

          itemMap = {
            'category_name': cName,
            'category_id': cId,
            'before_image': bImage,
            'after_image': aImage,
          };
        }
        // Add the map to the list
        GetPlanoDetails.planogram_items.add(itemMap);
      }
      print(
          'Check from Get Planogram Details: ${GetPlanoDetails.planogram_items}');
      print('Get Planogram Details done');
      String planobody = PlanoResponse.body;
      print("getPlanogramDetails...online...$planobody");
      // print(
      //     "getPlanogram...online...checking... ${test['data'][0]['store_name']}");
      await saveActivitiesDataIntoDB(
          currenttimesheetid.toString(), planobody, planodetaildata_table);

      var decodeddata = jsonDecode(planobody);
      print('From Get Planogram Data : $decodeddata');
      if (decodeddata['data'].length == 0) {
        print("No Data");
        GetPlanoDetails.nodata = "nodata";
        print(GetPlanoDetails.nodata);
      } else {
        for (int u = 0; u < decodeddata['data'].length; u++) {
          if (decodeddata['data'][u]['category_name'] != null) {
            // GetPlanoDetails.image
            //     .add('${decodeddata['data'][u]['before_image']}');
            // GetPlanoDetails.imageurl.add(
            //     "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['planogram_img']}");

            print(decodeddata['data'][u]['planograms']);

            if (decodeddata['data'][u]['planograms'].isEmpty) {
              print('Entered the if loop');
              GetPlanoDetails.beforeimage.add('dummy.png');
                GetPlanoDetails.afterimage.add('dummy.png');
           
            } else {
              
                print('Entered the second else loop');
                GetPlanoDetails.beforeimage.add(
                    "${decodeddata['data'][u]['planograms'][0]['before_image']}");
                GetPlanoDetails.afterimage.add(
                    "${decodeddata['data'][u]['planograms'][0]['after_image']}");
              
            }

            GetPlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
            GetPlanoDetails.opm.add(decodeddata['data'][u]['opm']);
            GetPlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
            GetPlanoDetails.categoryname
                .add(decodeddata['data'][u]['category_name']);
            GetPlanoDetails.categoryid.add(decodeddata['data'][u]['id']);

            if (decodeddata['data'][u]['before_image'] != null) {
              planocheck = true;
            }
          }
        }
      }

   
    }
  } on SocketException catch (_) {
    String planodetailsdata = await getActivityData(
        planodetaildata_table, currenttimesheetid.toString());
    print("getPlanogram...offline...$planodetailsdata");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    GetPlanoDetails.categoryname = [];
    if (planodetailsdata != null) {
      GetPlanoDetails.imageurl = [];
      GetPlanoDetails.beforeimage = [];
      GetPlanoDetails.afterimage = [];
      GetPlanoDetails.brandname = [];
      GetPlanoDetails.categoryname = [];
      GetPlanoDetails.categoryid = [];
      print("not null");
      // offlineplanodata = prefs.getStringList('planodetaildata')??[];
      //
      // String data = offlineplanodata[currentoutletindex];
      var decodeddata = jsonDecode(planodetailsdata);
      print('From Get Planogram Data : $decodeddata');
      if (decodeddata['data'].length == 0) {
        print("No Data");
        GetPlanoDetails.nodata = "nodata";
        print('Get Planogram Check for Data: ${GetPlanoDetails.nodata}');
      }
      for (int u = 0; u < decodeddata['data'].length; u++) {
        if (decodeddata['data'][u]['category_name'] != null) {
          GetPlanoDetails.image
              .add('${decodeddata['data'][u]['before_image']}');
          GetPlanoDetails.imageurl.add(
              "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['planogram_img']}");
          GetPlanoDetails.beforeimage.add(
              "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['before_image']}");
          // GetPlanoDetails.beforeimage
          // .add("${decodeddata['data'][u]['before_image']}");

          GetPlanoDetails.afterimage.add(
              "http://157.245.55.88/planogram_image/${decodeddata['data'][u]['after_image']}");
          // GetPlanoDetails.afterimage
          //     .add("${decodeddata['data'][u]['after_image']}");

          GetPlanoDetails.brandname.add(decodeddata['data'][u]['brand_name']);
          GetPlanoDetails.opm.add(decodeddata['data'][u]['opm']);
          GetPlanoDetails.brandid.add(decodeddata['data'][u]['BID']);
          GetPlanoDetails.categoryname
              .add(decodeddata['data'][u]['category_name']);
          GetPlanoDetails.categoryid.add(decodeddata['data'][u]['id']);

          if (decodeddata['data'][u]['before_image'] != null) {
            planocheck = true;
          }
        }
      }
      beforeimages = [];
      afterimages = [];
      beforeimagesencode = [];
      afterimagesencode = [];
      for (int i = 0; i < GetPlanoDetails.brandname.length; i++) {
        beforeimages.add(File('dummy.png'));
        afterimages.add(File('dummy.png'));
        beforeimagesencode.add('dummy.png');
        afterimagesencode.add('dummy.png');
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

class GetPlanoDetails {
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
  static List<Map<String, dynamic>> planogram_items = [];
  static var nodata;
}

bool planocheck = false;
