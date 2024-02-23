import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';

import '../api_service.dart';
import 'package:merchandising/ConstantMethods.dart';

import '../api_service2.dart';

class AddPlanoData {
  static var outletid;
  static var timesheetid;
  static var outletpdtmapid;
  static List<dynamic> categoryid = [];
  static List<dynamic> planoimage = [];
  static List<dynamic> beforeimage = [];
  static List<dynamic> afterimage = [];
  static List<dynamic> categoryname = [];
}

class AddPlanogramData {
  static var outletid;
  static var timesheetid;
  static var outletpdtmapid;
  static List<dynamic> categoryid = [];
  // static List<dynamic> planoimage = [];
  static List<dynamic> beforeimage = [];
  static List<dynamic> afterimage = [];
  static List<dynamic> categoryname = [];
  static List<Map<String, dynamic>> planogram_items = [];
}

Future addPlanogramdata(bool connection) async {
  print("addPlanogramdata...$connection");
  Map addplano = {
    "outlet_id": AddPlanoData.outletid,
    "timesheet_id": AddPlanoData.timesheetid,
    "outlet_products_mapping_id": comid,
    "category_name": AddPlanoData.categoryname,
    "category_id": AddPlanoData.categoryid,
    "plano_image": AddPlanoData.planoimage,
    "before_image": AddPlanoData.beforeimage,
    "after_image": AddPlanoData.afterimage,
  };

  print('Planogram Values Adding: ${jsonEncode(addplano)}');
  print('Adding Planogram Before Image: ${AddPlanoData.beforeimage}');
  print('Adding Planogram After Image: ${AddPlanoData.afterimage}');

  try {
    http.Response planoresponse = await http.post(
      AddPlanogram,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(addplano),
    );

    print('Adding Planogram Values : ${jsonEncode(addplano)}');
    print('From Planogram Submit : ${planoresponse.body}');
    print("Add Planogram Done on Submit");
  } on SocketException catch (_) {
    print("Add Planogram Done offline");
    adddataforsync(
        "http://157.245.55.88/api/add_planogram",
        jsonEncode(addplano),
        "Planogram added for the timesheet id $currenttimesheetid");
  }
}

// Future<void> addPlanogramdataDetails(bool connection,
//     List<Map<String, dynamic>> planogram_items, int count) async {
//   // ... (other code)

//     List<Map<String, dynamic>> planoData = [];
//   Map<String, dynamic> itemMap;

//     final Map<String, String> headers = {
//     "Content-Type": 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//   };

//   for (var i = 0; i < count; i++) {
//     itemMap = {
//       'category_name': planogram_items[i]['category_name'],
//       'category_id': planogram_items[i]['category_id'].toString(),
//       'before_image': await _getMultipartFile('${planogram_items[i]['before_image']}'),
//       'after_image': await _getMultipartFile('${planogram_items[i]['after_image']}'),
//     };
//     print("From Adding PlanoData: ${itemMap}");

//     planoData.add(itemMap);
//     // planoData = {"planogram_items": itemMap} as List<Map<String, dynamic>>;

//   }
//     Map addplano = {
//     "outlet_id": AddPlanogramData.outletid,
//     "timesheet_id": AddPlanogramData.timesheetid,
//     "outlet_products_mapping_id": comid,
//     "planogram_items": planoData,
//   };

//    http.Response response = await http.post(
//     AddPlanogram,
//     headers: headers,
//     body: jsonEncode(addplano),
//   );

//   // Check the response status code
//   if (response.statusCode == 200) {
//     print('Data uploaded successfully! : ${response.body}');
//   } else {
//     print('Failed to upload data. Error: ${response.statusCode}');
//   }
// }

Future<http.MultipartFile> _getMultipartFile(String fileName) async {
  // Read the file as bytes
  File file = File(fileName);
  List<int> fileBytes = await file.readAsBytes();

  // Create the multipart file
  return http.MultipartFile.fromBytes(
    'file',
    fileBytes,
    filename: fileName,
  );
}

Future<void> addPlanogramdataDetails(bool connection,
    List<Map<String, dynamic>> planogram_items, int count) async {
  // ... (other code)
  List<Map<String, dynamic>> planoData = [];
  Map<String, dynamic> itemMap;
  final Uri addPlanogramUri = Uri.parse('$AddPlanogram');
  

  final Map<String, String> headers = {
    "Content-Type": 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
  };

  // Set headers for the multipart request

  // multipartRequest.fields['outlet_products_mapping_id'] =
  //     AddPlanogramData.outletpdtmapid.toString();

  final List<http.MultipartFile> imageFiles = [];

  final List<Map<String, dynamic>> planogramItemsList = [];

  for (var i = 0; i < count; i++) {
    final multipartRequest = http.MultipartRequest('POST', addPlanogramUri);
    print('Checking Add Planogram: ${(planogram_items[i]['category_name'])}');
    print('Checking Add Planogram - Image of ${(planogram_items[i]['category_name'])} : ${(planogram_items[i]['before_image'])}');
    print('Checking Add Planogram - Image of ${(planogram_items[i]['category_name'])} : ${(planogram_items[i]['after_image'])}');
    multipartRequest.headers.addAll(headers);

    multipartRequest.fields['outlet_id'] = AddPlanogramData.outletid.toString();
    multipartRequest.fields['timesheet_id'] =
        AddPlanogramData.timesheetid.toString();
    multipartRequest.fields['category_name'] =
        planogram_items[i]['category_name'];
    multipartRequest.fields['category_id'] = planogram_items[i]['category_id'].toString();
    final beforeImageFile = File(planogram_items[i]['before_image']);
    final afterImageFile = File(planogram_items[i]['after_image']);

    multipartRequest.files.add(await http.MultipartFile.fromBytes(
      'before_image', // Use a unique field name for each image
      await beforeImageFile.readAsBytes(),
      filename: 'before_image_$i.png',
    ));

    multipartRequest.files.add(await http.MultipartFile.fromBytes(
      'after_image', // Use a unique field name for each image
      await afterImageFile.readAsBytes(),
      filename: 'after_image_$i.png',
    ));

    try {
    final streamedResponse = await multipartRequest.send();

    print('Request Headers: ${multipartRequest.headers}');
    print('Request Body: ${multipartRequest.fields}');
    final response = await http.Response.fromStream(streamedResponse);

    print('The status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // Handle a successful response
      print('Files uploaded successfully');
      print('From Planogram Detail Submit : ${response.body}');
    } else {
      // Handle errors
      print('Error uploading files: ${response.body}');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception: $e');
  }

    // final itemMap = {
    //   'category_name': planogram_items[i]['category_name'],
    //   'category_id': planogram_items[i]['category_id'].toString(),
    //   // 'before_image': 'before_image_$i.png', // Include the image file names
    //   // 'after_image': 'after_image_$i.png',
    //   // Add other fields here as needed
    // };

    // planogramItemsList.add(itemMap);
  }

  // print(
  //     'These are the details passed to planogram items  : $planogramItemsList');

  // // Convert the list of planogram items to a JSON string
  // final planogramItemsJson = jsonEncode(planogramItemsList);

  // Add the JSON string as a field named "planogram_items"
  // multipartRequest.fields['planogram_items'] = planogramItemsJson;

  // You may need to add other fields as needed here

  
}


// Future addPlanogramdataDetails(bool connection,
//     List<Map<String, dynamic>> planogram_items, int count) async {
//   print("addPlanogramdataDetails...$connection");
//   List<Map<String, dynamic>> planoData = [];
//   Map<String, dynamic> itemMap;

//   final Uri addPlanogramUri = Uri.parse('$AddPlanogram');
//   int index = count;
//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//   };

//   // print('Planogram Detail Values Adding: ${jsonEncode(addplano)}');

//   final multipartRequest = http.MultipartRequest('POST', addPlanogramUri);

//   // Set headers for the multipart request
//   multipartRequest.headers.addAll(headers);

// // Add JSON data as a field in the multipart request
//   // multipartRequest.fields['json_data'] = jsonEncode(addplano);
//   multipartRequest.fields['outlet_id'] = AddPlanogramData.outletid.toString();
//   multipartRequest.fields['timesheet_id'] =
//       AddPlanogramData.timesheetid.toString();
//   multipartRequest.fields['outlet_products_mapping_id'] =
//       AddPlanogramData.outletpdtmapid.toString();

//   for (var i = 0; i < count; i++) {
//     itemMap = {
//       'category_name': planogram_items[i]['category_name'],
//       'category_id': planogram_items[i]['category_id'].toString(),
//       'before_image': "",
//       'after_image': "",
//     };
//     print("From Adding PlanoData: ${itemMap}");
//     // multipartRequest.fields['category_name'] =
//     //     planogram_items[i]['category_name'];
//     // multipartRequest.fields['category_id'] =
//     //     planogram_items[i]['category_id'].toString();
//     // if (planogram_items[i]['before_image'] != null) {
//     //   multipartRequest.files.add(await http.MultipartFile.fromPath(
//     //       'before_image', (planogram_items[i]['before_image'])));
//     // }
//     // if (planogram_items[i]['after_image'] != null) {
//     //   multipartRequest.files.add(await http.MultipartFile.fromPath(
//     //       'after_image', (planogram_items[i]['after_image'])));
//     // }
//     planoData.add(itemMap);
//     // planoData = {"planogram_items": itemMap} as List<Map<String, dynamic>>;

//   }

//   print("From Adding PlanoData: ${planoData}");

//   final data = {"planogram_items": planoData};
//   Map addplano = {
//     "outlet_id": AddPlanogramData.outletid,
//     "timesheet_id": AddPlanogramData.timesheetid,
//     "outlet_products_mapping_id": comid,
//     "planogram_items": planoData,
//   };
//   print('Planogram Detail Values Adding: ${jsonEncode(addplano)}');
//   multipartRequest.fields['planogram_items'] = jsonEncode(addplano);

//   for (var i = 0; i < index; i++) {
//     final beforeImageFile = File(planogram_items[i]['before_image']);
//     final afterImageFile = File(planogram_items[i]['after_image']);
// final bytes = beforeImageFile.readAsBytesSync().lengthInBytes;
    // final kb = bytes / 1024;
    // final mb = kb / 1024;
    // final afterBytes = afterImageFile.readAsBytesSync().lengthInBytes;
    // final afterKb = afterBytes / 1024;
    // final afterMb = afterKb / 1024;
    // print('Size of Before image: $mb');
    // print('Size of After image: $afterMb');
//     print("Before Image Path : ${File(planogram_items[i]['before_image'])}");

//     // multipartRequest.files.add(await http.MultipartFile.fromPath(
//     //     'before_image', beforeImageFile.path));
//     // multipartRequest.files.add(
//     //     await http.MultipartFile.fromPath('after_image', afterImageFile.path));

//     multipartRequest.files.add(await http.MultipartFile.fromBytes(
//       'before_image',
//       await beforeImageFile.readAsBytes(),
//       filename: 'before_image.jpg',
//     ));

//     multipartRequest.files.add(await http.MultipartFile.fromBytes(
//       'after_image',
//       await afterImageFile.readAsBytes(),
//       filename: 'after_image.jpg',
//     ));
//   }

//   try {
//     final streamedResponse = await multipartRequest.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200) {
//       // Handle a successful response
//       print('Files uploaded successfully');
//       print('From Planogram Detail Submit : ${response.body}');
//     } else {
//       // Handle errors
//       print('Error uploading files: ${response.body}');
//     }
//   } catch (e) {}
//   // try {
//   //   http.Response planoresponse = await http.post(
//   //     AddPlanogram,
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //       'Accept': 'application/json',
//   //       'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//   //     },
//   //     body: jsonEncode(addplano),
//   //   );

//   //   print('Adding Planogram Detail Values : ${jsonEncode(addplano)}');
//   //   print('From Planogram Detail Submit : ${planoresponse.body}');
//   //   print("Add Planogram Detail Done on Submit");
//   // } on SocketException catch (_) {
//   //   print("Add Planogram Done offline");
//   //   adddataforsync(
//   //       "http://157.245.55.88/api/add_planogram",
//   //       jsonEncode(addplano),
//   //       "Planogram Details added for the timesheet id $currenttimesheetid");
//   // }
// }


// Future addPlanogramdataDetails(bool connection,
//     List<Map<String, dynamic>> planogram_items, int count) async {
//   print("addPlanogramdataDetails...$connection");
//   Map addplano = {
//     "outlet_id": AddPlanogramData.outletid,
//     "timesheet_id": AddPlanogramData.timesheetid,
//     "outlet_products_mapping_id": comid,
//     // "category_name": AddPlanogramData.categoryname,
//     // "category_id": AddPlanogramData.categoryid,
//     // // "plano_image": AddPlanogramData.planoimage,
//     // "before_image": AddPlanogramData.beforeimage,
//     // "after_image": AddPlanogramData.afterimage,
//     "planogram_items": AddPlanogramData.planogram_items,
//   };

//   final Uri addPlanogramUri = Uri.parse('$AddPlanogram');

//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//   };

//   print('Planogram Detail Values Adding: ${jsonEncode(addplano)}');
//   // print('Adding Planogram Detail Before Image: ${AddPlanogramData.beforeimage}');
//   //  print('Adding Planogram Detail After Image: ${AddPlanogramData.afterimage}');

//   final multipartRequest = http.MultipartRequest('POST', addPlanogramUri);  

//   // Set headers for the multipart request
//   multipartRequest.headers.addAll(headers);

// // Add JSON data as a field in the multipart request
//   multipartRequest.fields['json_data'] = jsonEncode(addplano);
//   multipartRequest.fields['outlet_id'] = AddPlanogramData.outletid.toString();
//   multipartRequest.fields['timesheet_id'] = AddPlanogramData.timesheetid.toString();
//   multipartRequest.fields['outlet_products_mapping_id'] = AddPlanogramData.outletpdtmapid.toString();

//   for (var i = 0; i < count; i++) {
//     multipartRequest.fields['category_name'] =
//         planogram_items[i]['category_name'];
//     multipartRequest.fields['category_id'] =
//         planogram_items[i]['category_id'].toString();
//     if (planogram_items[i]['before_image'] != null) {
//       multipartRequest.files.add(await http.MultipartFile.fromPath(
//           'before_image', (planogram_items[i]['before_image'])));
//     }
//     if (planogram_items[i]['after_image'] != null) {
//       multipartRequest.files.add(await http.MultipartFile.fromPath(
//           'after_image', (planogram_items[i]['after_image'])));
//     }
//   }

//   try {
//     final streamedResponse = await multipartRequest.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200) {
//       // Handle a successful response
//       print('Files uploaded successfully');
//       print('From Planogram Detail Submit : ${response.body}');
//     } else {
//       // Handle errors
//       print('Error uploading files: ${response.body}');
//     }
//   } catch (e) {}
//   // try {
//   //   http.Response planoresponse = await http.post(
//   //     AddPlanogram,
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //       'Accept': 'application/json',
//   //       'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//   //     },
//   //     body: jsonEncode(addplano),
//   //   );

//   //   print('Adding Planogram Detail Values : ${jsonEncode(addplano)}');
//   //   print('From Planogram Detail Submit : ${planoresponse.body}');
//   //   print("Add Planogram Detail Done on Submit");
//   // } on SocketException catch (_) {
//   //   print("Add Planogram Done offline");
//   //   adddataforsync(
//   //       "http://157.245.55.88/api/add_planogram",
//   //       jsonEncode(addplano),
//   //       "Planogram Details added for the timesheet id $currenttimesheetid");
//   // }
// }



