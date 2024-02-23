import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

int taskdecativate;
int taskactivate;

class Checklistdata {
  static var outletid;
  static List<String> tasklist = [];
}

Future addchecklistdata() async {
  Map data = {
    'outlet_id': Checklistdata.outletid,
    'task_list': Checklistdata.tasklist,
  };
  print(jsonEncode(data));
  http.Response response = await http.post(
    AddTaskList,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(data),
  );
  print("Add Check List Done");

  print(response.body);
}

Future<void> activateCL() async {
  Map data = {
    'task_id': taskactivate,
  };
  print(jsonEncode(data));
  http.Response response = await http.post(
    actCL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(data),
  );
  print("Task Activate Done");

  print(response.body);
}

Future<void> deactivateCL() async {
  Map data = {
    'task_id': taskdecativate,
  };
  print(jsonEncode(data));
  http.Response response = await http.post(
    deactCL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(data),
  );
  print("Task Deactivate Done");

  print(response.body);
}
