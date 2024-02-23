import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merchandising/utils/DatabaseHelper.dart';
import '../../api_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';

import '../../api_service2.dart';

Future<void> getSkipJourneyPlanweekly() async {
  String skippedjpweekly;
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // skippedjpweekly = prefs.getString('skjourneyplanweekly');

  skippedjpweekly = await getData(skjourneyplanweekly_table);
  print("skippedjpweekly^^^^$skippedjpweekly");

  // if (skippedjpweekly == null || currentlysyncing) {
    print("in");
    Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};

    try{
    http.Response JPresponse = await http.post(
      WJPSkippedurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(DBrequestData),
    );
    if (JPresponse.statusCode == 200) {
      getweeklyskipjp.sundaystorenames = [];
      getweeklyskipjp.mondaystorenames = [];
      getweeklyskipjp.tuesdaystorenames = [];
      getweeklyskipjp.wednesdaystorenames = [];
      getweeklyskipjp.thrusdaystorenames = [];
      getweeklyskipjp.fridaystorenames = [];
      getweeklyskipjp.saturdaystorenames = [];

      getweeklyskipjp.sundaystorecodes = [];
      getweeklyskipjp.mondaystorecodes = [];
      getweeklyskipjp.tuesdaystorecodes = [];
      getweeklyskipjp.wednesdaystorecodes = [];
      getweeklyskipjp.thrusdaystorecodes = [];
      getweeklyskipjp.fridaystorecodes = [];
      getweeklyskipjp.saturdaystorecodes = [];

      getweeklyskipjp.sundayaddress = [];
      getweeklyskipjp.mondayaddress = [];
      getweeklyskipjp.tuesdayaddress = [];
      getweeklyskipjp.wednesdayaddress = [];
      getweeklyskipjp.thrusdayaddress = [];
      getweeklyskipjp.fridayaddress = [];
      getweeklyskipjp.saturdayaddress = [];

      getweeklyskipjp.sundaycontactnumbers = [];
      getweeklyskipjp.mondaycontactnumbers = [];
      getweeklyskipjp.tuesdaycontactnumbers = [];
      getweeklyskipjp.wednesdaycontactnumbers = [];
      getweeklyskipjp.thrusdaycontactnumbers = [];
      getweeklyskipjp.fridaycontactnumbers = [];
      getweeklyskipjp.saturdaycontactnumbers = [];

      print('journey plan weekly skipped done');
      skippedjpweekly = JPresponse.body;
      print("getSkipJourneyPlanweekly... online...$skippedjpweekly");
      await saveDataIntoDB(skippedjpweekly,skjourneyplanweekly_table);
     // await addskippedjpweekly(skippedjpweekly);
      var decodeJPData = jsonDecode(skippedjpweekly);
      for (int u = 0; u < decodeJPData['data'].length; u++) {
        dynamic storename = decodeJPData['data'][u]['store_name'];

        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Sunday'
            : decodeJPData['data'][u]['day'] == 'Sunday') {
          getweeklyskipjp.sundaystorenames.add(storename);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Monday'
            : decodeJPData['data'][u]['day'] == 'Monday') {
          getweeklyskipjp.mondaystorenames.add(storename);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Tuesday'
            : decodeJPData['data'][u]['day'] == 'Tuesday') {
          getweeklyskipjp.tuesdaystorenames.add(storename);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Wednesday'
            : decodeJPData['data'][u]['day'] == 'Wednesday') {
          getweeklyskipjp.wednesdaystorenames.add(storename);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Thursday'
            : decodeJPData['data'][u]['day'] == 'Thursday') {
          getweeklyskipjp.thrusdaystorenames.add(storename);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Friday'
            : decodeJPData['data'][u]['day'] == 'Friday') {
          getweeklyskipjp.fridaystorenames.add(storename);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Saturday'
            : decodeJPData['data'][u]['day'] == 'Saturday') {
          getweeklyskipjp.saturdaystorenames.add(storename);
        }

        dynamic storecode = decodeJPData['data'][u]['store_code'];

        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Sunday'
            : decodeJPData['data'][u]['day'] == 'Sunday') {
          getweeklyskipjp.sundaystorecodes.add(storecode);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Monday'
            : decodeJPData['data'][u]['day'] == 'Monday') {
          getweeklyskipjp.mondaystorecodes.add(storecode);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Tuesday'
            : decodeJPData['data'][u]['day'] == 'Tuesday') {
          getweeklyskipjp.tuesdaystorecodes.add(storecode);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Wednesday'
            : decodeJPData['data'][u]['day'] == 'Wednesday') {
          getweeklyskipjp.wednesdaystorecodes.add(storecode);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Thursday'
            : decodeJPData['data'][u]['day'] == 'Thursday') {
          getweeklyskipjp.thrusdaystorecodes.add(storecode);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Friday'
            : decodeJPData['data'][u]['day'] == 'Friday') {
          getweeklyskipjp.fridaystorecodes.add(storecode);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Saturday'
            : decodeJPData['data'][u]['day'] == 'Saturday') {
          getweeklyskipjp.saturdaystorecodes.add(storecode);
        }
        dynamic address = decodeJPData['data'][u]['address'];

        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Sunday'
            : decodeJPData['data'][u]['day'] == 'Sunday') {
          getweeklyskipjp.sundayaddress.add(address);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Monday'
            : decodeJPData['data'][u]['day'] == 'Monday') {
          getweeklyskipjp.mondayaddress.add(address);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Tuesday'
            : decodeJPData['data'][u]['day'] == 'Tuesday') {
          getweeklyskipjp.tuesdayaddress.add(address);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Wednesday'
            : decodeJPData['data'][u]['day'] == 'Wednesday') {
          getweeklyskipjp.wednesdayaddress.add(address);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Thursday'
            : decodeJPData['data'][u]['day'] == 'Thursday') {
          getweeklyskipjp.thrusdayaddress.add(address);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Friday'
            : decodeJPData['data'][u]['day'] == 'Friday') {
          getweeklyskipjp.fridayaddress.add(address);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Saturday'
            : decodeJPData['data'][u]['day'] == 'Saturday') {
          getweeklyskipjp.saturdayaddress.add(address);
        }

        dynamic numbers = decodeJPData['data'][u]['contact_number'];

        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Sunday'
            : decodeJPData['data'][u]['day'] == 'Sunday') {
          getweeklyskipjp.sundaycontactnumbers.add(numbers);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Monday'
            : decodeJPData['data'][u]['day'] == 'Monday') {
          getweeklyskipjp.mondaycontactnumbers.add(numbers);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Tuesday'
            : decodeJPData['data'][u]['day'] == 'Tuesday') {
          getweeklyskipjp.tuesdaycontactnumbers.add(numbers);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Wednesday'
            : decodeJPData['data'][u]['day'] == 'Wednesday') {
          getweeklyskipjp.wednesdaycontactnumbers.add(numbers);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Thursday'
            : decodeJPData['data'][u]['day'] == 'Thursday') {
          getweeklyskipjp.thrusdaycontactnumbers.add(numbers);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Friday'
            : decodeJPData['data'][u]['day'] == 'Friday') {
          getweeklyskipjp.fridaycontactnumbers.add(numbers);
        }
        if (decodeJPData['data'][u]['day'] == null
            ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
                    .parse(decodeJPData['data'][u]['date'])) ==
                'Saturday'
            : decodeJPData['data'][u]['day'] == 'Saturday') {
          getweeklyskipjp.saturdaycontactnumbers.add(numbers);
        }
      }
    } else {
      print(JPresponse.statusCode);
    }}
    on SocketException catch (_) {
  // else {
      if(skippedjpweekly != null) {
        print("getSkipJourneyPlanweekly... offline...$skippedjpweekly");
        var decodeJPData = jsonDecode(skippedjpweekly);
        for (int u = 0; u < decodeJPData['data'].length; u++) {
          dynamic storename = decodeJPData['data'][u]['store_name'];

          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Sunday'
              : decodeJPData['data'][u]['day'] == 'Sunday') {
            getweeklyskipjp.sundaystorenames.add(storename);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Monday'
              : decodeJPData['data'][u]['day'] == 'Monday') {
            getweeklyskipjp.mondaystorenames.add(storename);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Tuesday'
              : decodeJPData['data'][u]['day'] == 'Tuesday') {
            getweeklyskipjp.tuesdaystorenames.add(storename);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Wednesday'
              : decodeJPData['data'][u]['day'] == 'Wednesday') {
            getweeklyskipjp.wednesdaystorenames.add(storename);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Thursday'
              : decodeJPData['data'][u]['day'] == 'Thursday') {
            getweeklyskipjp.thrusdaystorenames.add(storename);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Friday'
              : decodeJPData['data'][u]['day'] == 'Friday') {
            getweeklyskipjp.fridaystorenames.add(storename);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Saturday'
              : decodeJPData['data'][u]['day'] == 'Saturday') {
            getweeklyskipjp.saturdaystorenames.add(storename);
          }

          dynamic storecode = decodeJPData['data'][u]['store_code'];

          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Sunday'
              : decodeJPData['data'][u]['day'] == 'Sunday') {
            getweeklyskipjp.sundaystorecodes.add(storecode);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Monday'
              : decodeJPData['data'][u]['day'] == 'Monday') {
            getweeklyskipjp.mondaystorecodes.add(storecode);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Tuesday'
              : decodeJPData['data'][u]['day'] == 'Tuesday') {
            getweeklyskipjp.tuesdaystorecodes.add(storecode);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Wednesday'
              : decodeJPData['data'][u]['day'] == 'Wednesday') {
            getweeklyskipjp.wednesdaystorecodes.add(storecode);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Thursday'
              : decodeJPData['data'][u]['day'] == 'Thursday') {
            getweeklyskipjp.thrusdaystorecodes.add(storecode);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Friday'
              : decodeJPData['data'][u]['day'] == 'Friday') {
            getweeklyskipjp.fridaystorecodes.add(storecode);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Saturday'
              : decodeJPData['data'][u]['day'] == 'Saturday') {
            getweeklyskipjp.saturdaystorecodes.add(storecode);
          }
          dynamic address = decodeJPData['data'][u]['address'];

          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Sunday'
              : decodeJPData['data'][u]['day'] == 'Sunday') {
            getweeklyskipjp.sundayaddress.add(address);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Monday'
              : decodeJPData['data'][u]['day'] == 'Monday') {
            getweeklyskipjp.mondayaddress.add(address);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Tuesday'
              : decodeJPData['data'][u]['day'] == 'Tuesday') {
            getweeklyskipjp.tuesdayaddress.add(address);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Wednesday'
              : decodeJPData['data'][u]['day'] == 'Wednesday') {
            getweeklyskipjp.wednesdayaddress.add(address);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Thursday'
              : decodeJPData['data'][u]['day'] == 'Thursday') {
            getweeklyskipjp.thrusdayaddress.add(address);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Friday'
              : decodeJPData['data'][u]['day'] == 'Friday') {
            getweeklyskipjp.fridayaddress.add(address);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Saturday'
              : decodeJPData['data'][u]['day'] == 'Saturday') {
            getweeklyskipjp.saturdayaddress.add(address);
          }

          dynamic numbers = decodeJPData['data'][u]['contact_number'];

          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Sunday'
              : decodeJPData['data'][u]['day'] == 'Sunday') {
            getweeklyskipjp.sundaycontactnumbers.add(numbers);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Monday'
              : decodeJPData['data'][u]['day'] == 'Monday') {
            getweeklyskipjp.mondaycontactnumbers.add(numbers);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Tuesday'
              : decodeJPData['data'][u]['day'] == 'Tuesday') {
            getweeklyskipjp.tuesdaycontactnumbers.add(numbers);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Wednesday'
              : decodeJPData['data'][u]['day'] == 'Wednesday') {
            getweeklyskipjp.wednesdaycontactnumbers.add(numbers);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Thursday'
              : decodeJPData['data'][u]['day'] == 'Thursday') {
            getweeklyskipjp.thrusdaycontactnumbers.add(numbers);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Friday'
              : decodeJPData['data'][u]['day'] == 'Friday') {
            getweeklyskipjp.fridaycontactnumbers.add(numbers);
          }
          if (decodeJPData['data'][u]['day'] == null
              ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
              .parse(decodeJPData['data'][u]['date'])) ==
              'Saturday'
              : decodeJPData['data'][u]['day'] == 'Saturday') {
            getweeklyskipjp.saturdaycontactnumbers.add(numbers);
          }
        }
        // }
      }
      return false;
    }

  // }
  // else {
  //   var decodeJPData = jsonDecode(skippedjpweekly);
  //   for (int u = 0; u < decodeJPData['data'].length; u++) {
  //     dynamic storename = decodeJPData['data'][u]['store_name'];
  //
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Sunday'
  //         : decodeJPData['data'][u]['day'] == 'Sunday') {
  //       getweeklyskipjp.sundaystorenames.add(storename);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Monday'
  //         : decodeJPData['data'][u]['day'] == 'Monday') {
  //       getweeklyskipjp.mondaystorenames.add(storename);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Tuesday'
  //         : decodeJPData['data'][u]['day'] == 'Tuesday') {
  //       getweeklyskipjp.tuesdaystorenames.add(storename);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Wednesday'
  //         : decodeJPData['data'][u]['day'] == 'Wednesday') {
  //       getweeklyskipjp.wednesdaystorenames.add(storename);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Thursday'
  //         : decodeJPData['data'][u]['day'] == 'Thursday') {
  //       getweeklyskipjp.thrusdaystorenames.add(storename);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Friday'
  //         : decodeJPData['data'][u]['day'] == 'Friday') {
  //       getweeklyskipjp.fridaystorenames.add(storename);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Saturday'
  //         : decodeJPData['data'][u]['day'] == 'Saturday') {
  //       getweeklyskipjp.saturdaystorenames.add(storename);
  //     }
  //
  //     dynamic storecode = decodeJPData['data'][u]['store_code'];
  //
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Sunday'
  //         : decodeJPData['data'][u]['day'] == 'Sunday') {
  //       getweeklyskipjp.sundaystorecodes.add(storecode);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Monday'
  //         : decodeJPData['data'][u]['day'] == 'Monday') {
  //       getweeklyskipjp.mondaystorecodes.add(storecode);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Tuesday'
  //         : decodeJPData['data'][u]['day'] == 'Tuesday') {
  //       getweeklyskipjp.tuesdaystorecodes.add(storecode);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Wednesday'
  //         : decodeJPData['data'][u]['day'] == 'Wednesday') {
  //       getweeklyskipjp.wednesdaystorecodes.add(storecode);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Thursday'
  //         : decodeJPData['data'][u]['day'] == 'Thursday') {
  //       getweeklyskipjp.thrusdaystorecodes.add(storecode);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Friday'
  //         : decodeJPData['data'][u]['day'] == 'Friday') {
  //       getweeklyskipjp.fridaystorecodes.add(storecode);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Saturday'
  //         : decodeJPData['data'][u]['day'] == 'Saturday') {
  //       getweeklyskipjp.saturdaystorecodes.add(storecode);
  //     }
  //     dynamic address = decodeJPData['data'][u]['address'];
  //
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Sunday'
  //         : decodeJPData['data'][u]['day'] == 'Sunday') {
  //       getweeklyskipjp.sundayaddress.add(address);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Monday'
  //         : decodeJPData['data'][u]['day'] == 'Monday') {
  //       getweeklyskipjp.mondayaddress.add(address);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Tuesday'
  //         : decodeJPData['data'][u]['day'] == 'Tuesday') {
  //       getweeklyskipjp.tuesdayaddress.add(address);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Wednesday'
  //         : decodeJPData['data'][u]['day'] == 'Wednesday') {
  //       getweeklyskipjp.wednesdayaddress.add(address);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Thursday'
  //         : decodeJPData['data'][u]['day'] == 'Thursday') {
  //       getweeklyskipjp.thrusdayaddress.add(address);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Friday'
  //         : decodeJPData['data'][u]['day'] == 'Friday') {
  //       getweeklyskipjp.fridayaddress.add(address);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Saturday'
  //         : decodeJPData['data'][u]['day'] == 'Saturday') {
  //       getweeklyskipjp.saturdayaddress.add(address);
  //     }
  //
  //     dynamic numbers = decodeJPData['data'][u]['contact_number'];
  //
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Sunday'
  //         : decodeJPData['data'][u]['day'] == 'Sunday') {
  //       getweeklyskipjp.sundaycontactnumbers.add(numbers);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Monday'
  //         : decodeJPData['data'][u]['day'] == 'Monday') {
  //       getweeklyskipjp.mondaycontactnumbers.add(numbers);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Tuesday'
  //         : decodeJPData['data'][u]['day'] == 'Tuesday') {
  //       getweeklyskipjp.tuesdaycontactnumbers.add(numbers);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Wednesday'
  //         : decodeJPData['data'][u]['day'] == 'Wednesday') {
  //       getweeklyskipjp.wednesdaycontactnumbers.add(numbers);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Thursday'
  //         : decodeJPData['data'][u]['day'] == 'Thursday') {
  //       getweeklyskipjp.thrusdaycontactnumbers.add(numbers);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Friday'
  //         : decodeJPData['data'][u]['day'] == 'Friday') {
  //       getweeklyskipjp.fridaycontactnumbers.add(numbers);
  //     }
  //     if (decodeJPData['data'][u]['day'] == null
  //         ? DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
  //                 .parse(decodeJPData['data'][u]['date'])) ==
  //             'Saturday'
  //         : decodeJPData['data'][u]['day'] == 'Saturday') {
  //       getweeklyskipjp.saturdaycontactnumbers.add(numbers);
  //     }
  //   }
  // }
}

class getweeklyskipjp {
  static List<String> sundaystorecodes = [];
  static List<String> mondaystorecodes = [];
  static List<String> tuesdaystorecodes = [];
  static List<String> wednesdaystorecodes = [];
  static List<String> thrusdaystorecodes = [];
  static List<String> fridaystorecodes = [];
  static List<String> saturdaystorecodes = [];

  static List<String> sundaystorenames = [];
  static List<String> mondaystorenames = [];
  static List<String> tuesdaystorenames = [];
  static List<String> wednesdaystorenames = [];
  static List<String> thrusdaystorenames = [];
  static List<String> fridaystorenames = [];
  static List<String> saturdaystorenames = [];

  static List<String> sundayaddress = [];
  static List<String> mondayaddress = [];
  static List<String> tuesdayaddress = [];
  static List<String> wednesdayaddress = [];
  static List<String> thrusdayaddress = [];
  static List<String> fridayaddress = [];
  static List<String> saturdayaddress = [];

  static List<int> sundaycontactnumbers = [];
  static List<int> mondaycontactnumbers = [];
  static List<int> tuesdaycontactnumbers = [];
  static List<int> wednesdaycontactnumbers = [];
  static List<int> thrusdaycontactnumbers = [];
  static List<int> fridaycontactnumbers = [];
  static List<int> saturdaycontactnumbers = [];
}
