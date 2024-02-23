import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/notifications.dart';
import '../api_service.dart';
import '../api_service2.dart';

class AddNotificationApi {
  
  static var notification;
  
}

Future addnotificationdetails() async {
  Map notificationdata = {
   
    'notification': '${AddNotificationApi.notification}',
   
  };
  print(jsonEncode(notificationdata));
  http.Response response = await http.post(
    AddPromotion,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(notificationdata),
  );
  print(response.body);
  print("Add Notification Done");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
