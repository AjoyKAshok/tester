import 'dart:io';

import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/utils/DBAddDataServerModel.dart';
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_launcher_icons/constants.dart';
import 'dart:convert';
import 'package:merchandising/ConstantMethods.dart';
import 'package:intl/intl.dart';
import 'syncreferenceapi.dart';
// import '../api/api_service2.dart';

bool backgroundsyncing = false;
List<String> requireurlstosync = [];
List<String> requirebodytosync = [];
List<String> message = [];
bool uploadDataToServer= false;

syncData()
async {
  print("timer...${onlinemode.value}....${message.length}...$uploadDataToServer");
  // Future.delayed(Duration(seconds: 2), () async {
  //
  // });
  if(onlinemode.value && !uploadDataToServer){
    print("timer...true..$uploadDataToServer");
    await syncServerSendData();
    print("timer...false");
  }


}


syncServerSendData()
async {
  List<DBAddDataServerModel> data= await getDataForSyncList_(addDataForSync);
  print("syncServerSendData data length... ${data.length}...uploadDataToServer..$uploadDataToServer");
  if(data!=null&&data.length>0&&!uploadDataToServer)
    {
uploadDataToServer= true;
      data.forEach((DBAddDataServerModel value) async {
        // print("vale...${value.addtoserverurl}..${value.toMap().keys}");



      // for (int i = 0; i < data.length;) {
        var checkintime = null;
        var timesheetid = null;
        var checkouttime = null;
        var journeytimeid = null;

        var type = jsonDecode(value.addtoserverbody)["type"];
        checkintime = jsonDecode(value.addtoserverbody)["checkin_time"];
        timesheetid = jsonDecode(value.addtoserverbody)["timesheet_id"];
        checkouttime = jsonDecode(value.addtoserverbody)["checkout_time"];
        journeytimeid = jsonDecode(value.addtoserverbody)["journey_time_id"];

        if (type == "Split Shift" &&
            checkintime == "" &&
            timesheetid != null &&
            checkouttime != "" &&
            journeytimeid == "") {
          print(true);
          print(type);
          print(checkintime);
          print(timesheetid);
          print(checkouttime);
          print(journeytimeid);
          currenttimesheetid = timesheetid;
          await getTotalJnyTime();
          print(TotalJnyTime.id.last);
          Map breaktime = {
            "type": "Split Shift",
            "timesheet_id": timesheetid,
            "checkin_time": "",
            "checkout_time": checkouttime,
            "journey_time_id": TotalJnyTime.id.last,
          };
          if(onlinemode.value==true)
          {
            try
            {
              http.Response response = await http.post(
                Uri.parse(value.addtoserverurl),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
                },
                body: jsonEncode(breaktime),
              );
              print(response.body);
              print("check 1 sync send");
              CreateLog(
                  "Api request : url-${value.addtoserverurl},Body-${value.addtoserverbody},response-${response.body}",
                  true);
              print("check 1 sync send createlog done");
            }
            on SocketException catch (_) {

            }

            // i++;
          }
          print("if  uRL....${value.addtoserverurl}...${value.addtoserverbody}");

        } else {
          // progress.value++;
          print("length....${data.length}...index...");
          if(onlinemode.value==true&&data.length>0&&data.isNotEmpty)
          {

            print("else uRL....${value.addtoserverurl}...${value.addtoserverbody}");
            try{
              http.Response response = await http.post(
                Uri.parse(value.addtoserverurl),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
                },
                body: value.addtoserverbody,
              );

              if (response.statusCode == 200) {
                print(response.body);
                print("check 2 sync send");
                if(data!=null&&data!=[])
                {
                  CreateLog(
                      "Api request : url-${value.addtoserverurl},Body-${value.addtoserverbody},response-${response.body}",
                      true);
                }

                // i++;
              }
              else
              {
                print(response.body);
                print("check 3 sync send");
                if(data!=null&&data!=[])
                {
                  CreateLog(
                      "Api Error : url-${value.addtoserverurl},Body-${value.addtoserverbody},response-${response.body}",
                      false);
                }

                // i++;
              }}
            on SocketException catch (_){
              // i++;
              return false;
            }



          }


        }
      // }
      });
      await deleteTable_(addDataForSync);
      uploadDataToServer=false;
      print("uploadDataToServer...data removed");
    }


}

syncingsenddata() async {
print("syncingsenddata....");
  CreateLog("synchronising data from device to server started", true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  lastsyncedon = DateTime.parse(prefs.getString('lastsyncedondate'));
  requireurlstosync = prefs.getStringList('addtoserverurl');
  print(lastsyncedon);
  if (requireurlstosync != null) {
    requireurlstosync = prefs.getStringList('addtoserverurl');
    requirebodytosync = prefs.getStringList('addtoserverbody');
    message = prefs.getStringList('addtoservermessage');

  } else {
    requireurlstosync = [];
    requirebodytosync = [];
    message = [];
    backgroundsyncing= false;

  }
  print("syncing current data_post1");
  if (requireurlstosync != [] &&
      requireurlstosync != null &&
      onlinemode.value) {
    backgroundsyncing = true;
    for (int i = 0; i < requireurlstosync.length;) {
      var checkintime = null;
      var timesheetid = null;
      var checkouttime = null;
      var journeytimeid = null;

      var type = jsonDecode(requirebodytosync[i])["type"];
      checkintime = jsonDecode(requirebodytosync[i])["checkin_time"];
      timesheetid = jsonDecode(requirebodytosync[i])["timesheet_id"];
      checkouttime = jsonDecode(requirebodytosync[i])["checkout_time"];
      journeytimeid = jsonDecode(requirebodytosync[i])["journey_time_id"];

      if (type == "Split Shift" &&
          checkintime == "" &&
          timesheetid != null &&
          checkouttime != "" &&
          journeytimeid == "") {
        print(true);
        print(type);
        print(checkintime);
        print(timesheetid);
        print(checkouttime);
        print(journeytimeid);
        currenttimesheetid = timesheetid;
        await getTotalJnyTime();
        print(TotalJnyTime.id.last);
        Map breaktime = {
          "type": "Split Shift",
          "timesheet_id": timesheetid,
          "checkin_time": "",
          "checkout_time": checkouttime,
          "journey_time_id": TotalJnyTime.id.last,
        };
        if(onlinemode.value==true&&requireurlstosync.length >i)
          {
            http.Response response = await http.post(
              Uri.parse(requireurlstosync[i]),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
              },
              body: jsonEncode(breaktime),
            );
            print(response.body);
            print("check 1 sync send");
            CreateLog(
                "Api request : url-${requireurlstosync[i]},Body-${requirebodytosync[i]},response-${response.body}",
                true);
            print("check 1 sync send createlog done");
            i++;
          }


      } else {
        // progress.value++;
        print("length....${requireurlstosync.length}...index...$i");
        if(onlinemode.value==true&&requireurlstosync.length>i&&requirebodytosync.isNotEmpty)
          {

            print("uRL....${requireurlstosync[i]}");
            try{
            http.Response response = await http.post(
              Uri.parse(requireurlstosync[i]),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
              },
              body: requirebodytosync[i],
            );

            if (response.statusCode == 200) {
              print(response.body);
              print("check 2 sync send");
if(requireurlstosync!=null&&requireurlstosync!=[])
  {
    CreateLog(
        "Api request : url-${requireurlstosync[i]},Body-${requirebodytosync[i]},response-${response.body}",
        true);
  }

              i++;
            }
            else
            {
              print(response.body);
              print("check 3 sync send");
              if(requireurlstosync!=null&&requireurlstosync!=[])
                {
                  CreateLog(
                      "Api Error : url-${requireurlstosync[i]},Body-${requirebodytosync[i]},response-${response.body}",
                      false);
                }

              i++;
            }}
            on SocketException catch (_){
              i++;
              return false;
            }



}


      }
    }
    requireurlstosync = [];
    requirebodytosync = [];
    message = [];
   await removesenddatafromlocal();

   backgroundsyncing= false;
    print("data removed from sharedpref");
  }
}

CreateLog(message, status) async {
  logreport.add(message);
  logtime.add(DateFormat.yMd().add_jm().format(DateTime.now()).toString());
  logreportstatus.add("$status");
  await savelogreport(logreport, logtime, logreportstatus);
}
