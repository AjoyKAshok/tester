import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import '../api_service2.dart';

Future<void> getNBLdetails() async {
  print ("getNBLdetails");
  Map body ={
    "outlet_id": currentoutletid,
  };
  print(jsonEncode(body));
  try {
    http.Response response = await http.post(NBLDetailsFMs,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },

      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      NBLDetData.fileurl = [];
      NBLDetData.outletid = [];
      NBLDetData.id = [];
      NBLDetData.isactive = [];
      String nbllistbody = response.body;
      var decodebrands = jsonDecode(nbllistbody);
      print("getNBLdetails... online...$nbllistbody");
      await saveActivitiesDataIntoDB(currentoutletid.toString(), nbllistbody, nbldetaildata_table);
      for (int u = 0; u < decodebrands['data'].length; u++) {
        NBLDetData.outletid.add(decodebrands['data'][u]['outlet_id']);
        NBLDetData.fileurl.add(decodebrands['data'][u]['file_url']);
        NBLDetData.id.add(decodebrands['data'][u]['id']);
        NBLDetData.isactive.add(decodebrands['data'][u]['is_active']);
      }
      print("files");
      print(NBLDetData.fileurl);

    }
  }
  on SocketException catch (_) {
    print("get FM NBL Details Done");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nbldata = await getActivityData(nbldetaildata_table, currentoutletid.toString());
    print("getNBLdetails... offline...$nbldata");
    // if(prefs.getStringList('nbldetaildata')!=null)
    if(nbldata!=null)
    {
      // print("not null");
      // offlinenbldata = prefs.getStringList('nbldetaildata')??[];
      // String brand = offlinenbldata[currentoutletindex];
      var decodebrands = jsonDecode(nbldata);

      NBLDetData.fileurl = [];
      NBLDetData.outletid = [];
      NBLDetData.id = [];
      NBLDetData.isactive = [];

      for (int u = 0; u < decodebrands['data'].length; u++) {
        NBLDetData.outletid.add(decodebrands['data'][u]['outlet_id']);
        NBLDetData.fileurl.add(decodebrands['data'][u]['file_url']);
        NBLDetData.id.add(decodebrands['data'][u]['id']);
        NBLDetData.isactive.add(decodebrands['data'][u]['is_active']);
      }
      print("files");
      print(NBLDetData.fileurl);
    }

    return false;
  }

}
//   if(response.statusCode != 200){
//     print(response.statusCode);
//   }
// }

class NBLDetData {
  static List<String> fileurl = [];
  static List<dynamic> outletid = [];
  static List<int> id = [];
  static List<int> isactive = [];
}
