import 'dart:io';

import 'package:merchandising/Merchandiser/merchandiserscreens/merchdash.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/offlinedata/syncdata.dart';
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_launcher_icons/constants.dart';
import 'dart:convert';
import 'package:merchandising/ConstantMethods.dart';
import 'package:intl/intl.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/jpskippedapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/JPvisitedapi.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpplanned.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpskipped.dart';
import 'package:merchandising/api/Journeyplansapi/weekly/jpvisited.dart';
import 'package:merchandising/api/empdetailsapi.dart';
import 'package:merchandising/model/database.dart';
import 'package:merchandising/api/HRapi/empdetailsforreportapi.dart';
import 'package:merchandising/api/HRapi/empdetailsapi.dart';
// import '../api/api_service2.dart';

DateTime lastsyncedon;
DateTime lastsyncedendtime;
Duration difference;
List<Uri> urlstosync = [];
List<Map> bodytosync = [];
List<String> sucessmsgaftersync = [];

syncingreferencedata() async {
  print("syncingreferencedata....${onlinemode.value}");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  lastsyncedon = DateTime.parse(prefs.getString('lastsyncedondate'));
  // lastsyncedon = DateTime.now();
  if (lastsyncedon != null) {
    lastsyncedendtime = DateTime.parse(prefs.getString('lastsyncedonendtime'));
    difference = DateTime.now().difference(lastsyncedendtime);
    print("difference: ${difference.inMinutes}");
    print(
        "${DateFormat('yyyy-MM-dd').format(lastsyncedon)} = ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
  }

  if (currentlysyncing && onlinemode.value) {
    currentstep = 0;
    print("Syncing");

    var date = DateTime.now();
    var starttime = DateTime.now();
    loginfromloginpage = false;
    await loginapi();

    try {
      progress.value = 10;
      // SOSDetailsoffline();
    } on Exception catch (exception) {
    } catch (error) {
      progress.value = 10;
    }
    progress.value = 10;
    await getJourneyPlan();
    progress.value = 15;

    try {
      progress.value = 15;
      // PlanoDetailsoffline();

    } on Exception catch (exception) {
    } catch (error) {
      progress.value = 15;
    }

    progress.value = 20;

    await getallempdetails();
    progress.value = 25;
    await getempdetails();
    progress.value = 30;
    await getaddedexpiryproducts();
    progress.value = 35;
    await getstockexpiryproducts();
    progress.value = 39;

    // PromoDetailsoffline();
    progress.value = 41;

    await DBRequestdaily();
    progress.value = 45;
    await getalljpoutletsdata();

    /// COMMENTING OUT TO TEST
    // try {
    //   progress.value = 45;
    //   await getempdetailsforreport();
    // } on Exception catch (exception) {
    // } catch (error) {
    //   progress.value = 45;
    // }

    progress.value = 45;
    // CheckListDetailsoffline();
    progress.value = 55;
    await DBRequestmonthly();
    progress.value = 60;
    await getskippedJourneyPlan();
    progress.value = 68;
    // await
    // progress.value = 70;

    try {
      progress.value = 69;
      await VisibilityDetailsoffline();
    } on Exception catch (exception) {
    } catch (error) {
      progress.value = 69;
    }

    progress.value = 71;
    await getvisitedJourneyPlan();
    progress.value = 71;
    await getJourneyPlanweekly();
    progress.value = 71;
    await getSkipJourneyPlanweekly();
    progress.value = 80;
    await getVisitJourneyPlanweekly();
    progress.value = 84;
    await Expectedchartvisits();
    progress.value = 87;
    await chartvisits();
    progress.value = 92;

    progress.value = 96;
    // await NBLdetailsoffline();

    // progress.value = 95;
    progress.value = 99;

    currentlysyncing = false;
    var endtime = DateTime.now();
    await lastsynced(date, starttime, endtime);
    //progress.value = 100;
    print("sync Finished");
  } else {
    print("test_post");
    DBRequestmonthly();
    getaddedexpiryproducts();
    getempdetails();

    /// TESTING
    // getempdetailsforreport();
    getstockexpiryproducts();
   
    await DBRequestdaily();
    await callfrequentlytocheck();
    getempdetails();
    getallempdetails();
    getaddedexpiryproducts();
    getstockexpiryproducts();

    /// TESTING
    // getempdetailsforreport();
    getJourneyPlan();
    getskippedJourneyPlan();
    getvisitedJourneyPlan();
    getSkipJourneyPlanweekly();
    getVisitJourneyPlanweekly();
    getJourneyPlanweekly();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    offlineoutletdeatiles = prefs.getStringList('alljpoutlets') ?? [];
    outletvisitsdata = prefs.getStringList('alljpoutletschart') ?? [];
    outletEvisitsdata = prefs.getStringList('alljpoutletsEchart') ?? [];
    offlinevisibilitydata = prefs.getStringList('visibilitydetdata') ?? [];
    offlinesosdata = prefs.getStringList('shareofshelfdetdata') ?? [];
    offlineplanodata = prefs.getStringList('planodetaildata') ?? [];
    offlinepromodata = prefs.getStringList('promodetaildata') ?? [];
    offlinechecklistdata = prefs.getStringList('checklistdetaildata') ?? [];
    offlinenbldata = prefs.getStringList('nbldetaildata') ?? [];
    const time = const Duration(seconds: 120);
    Timer.periodic(time, (Timer t) => callfrequentlytocheck());
  }
}

getalljpoutletsdata() async {
  print("getalljpoutletsdata ..outlet_id..$outletid");
  offlineoutletdeatiles = [];

  print("offlineoutletdeatiles length:${gettodayjp.outletids.length}");
  for (int i = 0; i < gettodayjp.outletids.length; i++) {
    // progress.value++;
    int outletid = gettodayjp.outletids[i];
    Map ODrequestDataforcheckin = {
      "emp_id": "${DBrequestdata.receivedempid}",
      'outlet_id': '$outletid',
    };
    // print("getalljpoutletsdata ....$ODrequestDataforcheckin");

    try {
      http.Response OCresponse = await http.post(
        OCurl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(ODrequestDataforcheckin),
      );
      // print('Response from all outlets : ${OCresponse.body}');
      if (OCresponse.statusCode == 200) {
        // print('The Response Status Code : ${OCresponse.statusCode}');
        // if (i == 0) {
        //   await deleteTable_(alljpoutlets_table);
        // }
        offlineoutletdeatiles.add(OCresponse.body);
        // await saveListDataIntoDb(
        //     OCresponse.body.toString(), alljpoutlets_table);
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  await Addjpoutletsdetailesdata(offlineoutletdeatiles);
}

chartvisits() async {
  print('Fetching Chart Visits');
  outletvisitsdata = [];

  for (int i = 0; i < gettodayjp.outletids.length; i++) {
    int outletid = gettodayjp.outletids[i];
    Map ODrequestDataforcheckin = {
      'outlet_id': outletid,
    };

    try {
      http.Response OCResponse = await http.post(
        ChartUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(ODrequestDataforcheckin),
      );
      if (OCResponse.statusCode == 200) {
        // if (i == 0) {
        //   await deleteTable_(alljpoutletschart_table);
        // }
        outletvisitsdata.add(OCResponse.body);
        // await saveListDataIntoDb(
        //     OCResponse.body.toString(), alljpoutletschart_table);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  print('Finished Chart Visits');
  await Addjpoutletschartdetailesdata(outletvisitsdata);
}

Expectedchartvisits() async {
  print('Fetching Expected Visits');
  outletEvisitsdata = [];

  for (int i = 0; i < gettodayjp.outletids.length; i++) {
    int outletid = gettodayjp.outletids[i];
    Map ODrequestDataforcheckin = {
      'outlet_id': outletid,
    };
    print('The value: $ODrequestDataforcheckin');
    try {
      http.Response OCResponse = await http.post(
        expectedvisitchart,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(ODrequestDataforcheckin),
      );
      if (OCResponse.statusCode == 200) {
        // if (i == 0) {
        //   await deleteTable_(alljpoutletsEchart_table);
        // }
        outletEvisitsdata.add(OCResponse.body);
        print('The outlets: $outletEvisitsdata');

        // await saveListDataIntoDb(
        //     OCResponse.body.toString(), alljpoutletsEchart_table);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  print('Finished Expected Visits');
  await AddjpoutletsEchartdetailesdata(outletEvisitsdata);
}

availabilityDetailsoffline() async {
  offlineAvailabilityData = [];
  for (int i = 0; i < gettodayjp.id.length; i++) {
    int timesheetid = gettodayjp.id[i];
    Map body = {"time_sheet_id": "$timesheetid"};
    print("offlineAvailabilityData");
    try {
      http.Response OCResponse = await http.post(
        AvailabilityDetails,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(body),
      );
      if (OCResponse.statusCode == 200) {
        offlineAvailabilityData.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  print("offlineAvailabilityData...${offlineAvailabilityData.length}");
  await availabilitydetail(offlineAvailabilityData);
}

VisibilityDetailsoffline() async {
  offlinevisibilitydata = [];
  for (int i = 0; i < gettodayjp.id.length; i++) {
    int timesheetid = gettodayjp.id[i];
    Map body = {"time_sheet_id": "$timesheetid"};
    try {
      http.Response OCResponse = await http.post(
        VisibilityDetails,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(body),
      );
      if (OCResponse.statusCode == 200) {
        offlinevisibilitydata.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  await Visibilitydetail(offlinevisibilitydata);
}

SOSDetailsoffline() async {
  offlinesosdata = [];
  for (int i = 0; i < gettodayjp.id.length; i++) {
    progress.value++;
    int timesheetid = gettodayjp.id[i];
    Map body = {"time_sheet_id": "$timesheetid"};

    try {
      http.Response OCResponse = await http.post(
        ShareofshelfDetails,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(body),
      );
      print(OCResponse.body);
      if (OCResponse.statusCode == 200) {
        offlinesosdata.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  await sosdetail(offlinesosdata);
}

PlanoDetailsoffline() async {
  offlineplanodata = [];
  for (int i = 0; i < gettodayjp.id.length; i++) {
    int timesheetid = gettodayjp.id[i];
    Map body = {"time_sheet_id": "$timesheetid"};

    try {
      http.Response OCResponse = await http.post(
        PlanogramDetails,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(body),
      );
      print(OCResponse.body);
      if (OCResponse.statusCode == 200) {
        offlineplanodata.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  await planodetail(offlineplanodata);
}

PromoDetailsoffline() async {
  offlinepromodata = [];
  for (int i = 0; i < gettodayjp.outletids.length; i++) {
    progress.value++;
    int outletid = gettodayjp.outletids[i];
    Map body = {"outlet_id": "$outletid"};

    try {
      http.Response OCResponse = await http.post(
        PromoDetails,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(body),
      );

      if (OCResponse.statusCode == 200) {
        offlinepromodata.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  await promodetail(offlinepromodata);
}

CheckListDetailsoffline() async {
  offlinechecklistdata = [];
  for (int i = 0; i < gettodayjp.outletids.length; i++) {
    // progress.value++;
    int outletid = gettodayjp.outletids[i];
    Map body = {"outlet_id": "$outletid"};

    try {
      http.Response OCResponse = await http.post(
        taskdetailes,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(body),
      );

      if (OCResponse.statusCode == 200) {
        offlinechecklistdata.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  await checklistdetail(offlinechecklistdata);
}

NBLdetailsoffline() async {
  offlinenbldata = [];
  for (int i = 0; i < gettodayjp.outletids.length; i++) {
    int outletid = gettodayjp.outletids[i];
    Map ODrequestDataforcheckin = {
      'outlet_id': outletid,
    };

    try {
      http.Response OCResponse = await http.post(
        NBLDetailsFMs,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(ODrequestDataforcheckin),
      );
      if (OCResponse.statusCode == 200) {
        offlinenbldata.add(OCResponse.body);
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  await NBLdetail(offlinenbldata);
}
