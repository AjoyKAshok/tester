import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getRelieverDetails() async {
  http.Response SDResponse = await http.post(
    RelieverDet,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
  );
  if (SDResponse.statusCode == 200) {
    print("get Reliever Details Done");
    String stores = SDResponse.body;
    var decodestores = jsonDecode(stores);
    Relieverdetdata.emp = [];
    Relieverdetdata.relemp = [];
    Relieverdetdata.fromdate = [];
    Relieverdetdata.todate = [];
    Relieverdetdata.reason = [];
    for (int u = 0; u < decodestores['data'].length; u++) {

      if(decodestores["data"][u]['employee']!=null)
        {
          print("$u..firstname..${decodestores["data"][u]['employee']['first_name']??""}");
          Relieverdetdata.emp.add(
              '${decodestores["data"][u]['employee']['first_name']??""} ${decodestores["data"][u]['employee']['surname']??""}(${decodestores["data"][u]['employee']['employee_id']??""})');

        }
      else
        {
          Relieverdetdata.emp.add("");
        }
       if(decodestores["data"][u]['reliever']!=null)
       {
         Relieverdetdata.relemp.add(
             '${decodestores["data"][u]['reliever']['first_name']??""} ${decodestores["data"][u]['reliever']['surname']??""}(${decodestores["data"][u]['reliever']['employee_id']??""})');

       }
     else
       {
         Relieverdetdata.relemp.add("");
       }


      Relieverdetdata.fromdate.add(decodestores['data'][u]['from_date']);
      Relieverdetdata.todate.add(decodestores['data'][u]['to_date']);
      Relieverdetdata.reason.add(decodestores['data'][u]['reason']);
    }
    print("emp..${ Relieverdetdata.emp.length}...reliever..${Relieverdetdata.relemp.length}");
  }

  if (SDResponse.statusCode != 200) {
    print(SDResponse.statusCode);
  }
}

class Relieverdetdata {
  static List<String> emp = [];
  static List<String> relemp = [];
  static List<String> fromdate = [];
  static List<String> todate = [];
  static List<String> reason = [];
}

class AddrelieverData {
  static var empid;
  static var relempid;
  static var from;
  static var to;
  static var reason;
}

Future addrelieveremp() async {
  Map storedata = {
    'employee_id': '${AddrelieverData.empid}',
    'reliever_id': '${AddrelieverData.relempid}',
    'from_date': '${AddrelieverData.from}',
    'to_date': '${AddrelieverData.to}',
    'reason': '${AddrelieverData.reason}',
  };
  print("addrelieveremp");
  print(jsonEncode(storedata));
  http.Response relieverres = await http.post(
    AddReliever,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(storedata),
  );
  await getRelieverDetails();
  print(relieverres.body);
  print("Add Reliever Done");
}

class SearchReliever {
  static var empid;
  static var from;
  static var to;
}

Future<List<String>> searchreliever() async {
  Map serreldata = {
    'emp_merch_id': '${SearchReliever.empid}',
    'from_date': '${SearchReliever.from}',
    'to_date': '${SearchReliever.to}',
  };
  print("searchreliever....$serreldata");
  http.Response relieverres = await http.post(
    searchReliever,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(serreldata),
  );
  if (relieverres.statusCode == 200) {
    print("Search Reliever Done");
    String jsondata = relieverres.body;
    var decodedjsondata = jsonDecode(jsondata);
    relieversid = [];
    relievername = [];
    if (jsondata.contains("alert")) {
      print("No Merchandisers Available");
    } else {
      for (int u = 0; u < decodedjsondata['data'].length; u++) {
        relieversid.add(decodedjsondata['data'][u]['employee_id']);
        relievername.add(
            "${decodedjsondata['data'][u]['first_name']} ${decodedjsondata['data'][u]['surname']} [${decodedjsondata['data'][u]['employee_id']}]");
      }
      return relievername;
    }
  }
  print(serreldata);
  print(relieverres.body);
  print("Search Reliever Done");
}

List<String> relieversid = [];
List<String> relievername = [];
