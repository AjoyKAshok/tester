import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merchandising/Merchandiser/merchandiserscreens/Journeyplan.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/PlanogramcheckPhase1.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/model/Location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:merchandising/main.dart';
import 'package:merchandising/model/OutLet_BarChart.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/offlinedata/syncsendapi.dart';
import 'package:merchandising/utils/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/model/rememberme.dart';
import 'package:merchandising/api/monthlyvisitschart.dart';
import 'package:merchandising/offlinedata/sharedprefsdta.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:intl/intl.dart';

bool splitsf = false;
bool checkoutdatasubmitted = false;
bool checkindatasubmitted = false;
bool checkoutrequested = false;
bool checkinrequested = false;
int comid;
Uri expectedvisitchart =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_expected_outlet_chart");
Uri OutletSurvey = Uri.parse("https://rms2.rhapsody.ae/api/add_outlet_survey");
Uri deltimesheet = Uri.parse("https://rms2.rhapsody.ae/api/delete_journeyplan");
Uri ShareofshelfDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/share_of_shelf_details");
Uri PlanogramDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/Planogram_details");
Uri getcompdetails =
    Uri.parse("https://rms2.rhapsody.ae/api/competition_details");
Uri VisibilityDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/visibility_details");
Uri AddVisibility = Uri.parse("https://rms2.rhapsody.ae/api/add_visibility");
Uri AddPlanogram = Uri.parse("https://rms2.rhapsody.ae/api/add_planogram");
Uri ChartUrl = Uri.parse("https://rms2.rhapsody.ae/api/outlet_chart");
Uri Loginurl = Uri.parse("https://rms2.rhapsody.ae/api/login");
Uri DBdailyurl = Uri.parse("https://rms2.rhapsody.ae/api/dashboard_daily");
Uri DBmonthlyurl = Uri.parse("https://rms2.rhapsody.ae/api/dashboard_monthly");
Uri OCurl = Uri.parse("https://rms2.rhapsody.ae/api/outlet_details");
Uri CICOurl = Uri.parse("https://rms2.rhapsody.ae/api/check_in_out");
Uri CheckInUrl = Uri.parse("https://rms2.rhapsody.ae/api/check-in");
Uri CheckOutUrl = Uri.parse("https://rms2.rhapsody.ae/api/check-out");
Uri attendancein = Uri.parse("https://rms2.rhapsody.ae/api/attendance_in");
Uri UpdateOutlet = Uri.parse("https://rms2.rhapsody.ae/api/update_outlet");
Uri TSurl = Uri.parse("https://rms2.rhapsody.ae/api/timesheet_daily");
Uri leaveurl = Uri.parse("https://rms2.rhapsody.ae/api/leave_request");
Uri empdataurl = Uri.parse("https://rms2.rhapsody.ae/api/employee_details");
Uri passwordchangeurl =
    Uri.parse("https://rms2.rhapsody.ae/api/change_password");
Uri taskdetailes =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_task_details");
Uri taskresponse =
    Uri.parse("https://rms2.rhapsody.ae/api/send_outlet_task_response");
Uri LDurl = Uri.parse("https://rms2.rhapsody.ae/api/leave_details");
Uri JPSkippedurl =
    Uri.parse("https://rms2.rhapsody.ae/api/today_skipped_journey");
Uri JPVisitedurl =
    Uri.parse("https://rms2.rhapsody.ae/api/today_completed_journey");
Uri JPurl = Uri.parse("https://rms2.rhapsody.ae/api/today_planned_journey");
Uri empdetailsurl =
    Uri.parse("https://rms2.rhapsody.ae/api/employee_details_for_report");
Uri reportingdataurl =
    Uri.parse("https://rms2.rhapsody.ae/api/reporting_to_details");
Uri addreportaurl = Uri.parse("https://rms2.rhapsody.ae/api/add_reporting");
Uri holidaysdataurl =
    Uri.parse("https://rms2.rhapsody.ae/api/holidays_details");
Uri addholidayurl = Uri.parse("https://rms2.rhapsody.ae/api/add_holidays");
Uri WJPPlannedurl =
    Uri.parse("https://rms2.rhapsody.ae/api/week_planned_journey");
Uri WJPSkippedurl =
    Uri.parse("https://rms2.rhapsody.ae/api/week_skipped_journey");
Uri WJPVisitedurl =
    Uri.parse("https://rms2.rhapsody.ae/api/week_completed_journey");
Uri TSMurl = Uri.parse("https://rms2.rhapsody.ae/api/timesheet_monthly");
Uri TSSplitMurl =
    Uri.parse("https://rms2.rhapsody.ae/api/timesheet_monthly_split_time");
Uri HRdburl = Uri.parse("https://rms2.rhapsody.ae/api/hr_dashboard");
Uri visitsurl = Uri.parse("https://rms2.rhapsody.ae/api/outlet_chart");
Uri MercNameList = Uri.parse(
    "https://rms2.rhapsody.ae/api/merchandiser_under_fieldmanager_details");
Uri Storedetailsurl = Uri.parse("https://rms2.rhapsody.ae/api/store_details");
Uri AddStoreurl = Uri.parse("https://rms2.rhapsody.ae/api/add_store");
Uri StoreDetailsurl = Uri.parse("https://rms2.rhapsody.ae/api/store_details");
Uri FMDashBoardurl =
    Uri.parse("https://rms2.rhapsody.ae/api/fieldmanager_dashboard");
Uri AddOutletsurl = Uri.parse("https://rms2.rhapsody.ae/api/add_outlet");
Uri overallJPurl = Uri.parse("https://rms2.rhapsody.ae/api/journey");
Uri MercLeaveDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/merchandiser_leave_details");
Uri AddEmployee = Uri.parse("https://rms2.rhapsody.ae/api/add_employee");
Uri unschdulejp =
    Uri.parse("https://rms2.rhapsody.ae/api/add_unscheduled_journeyplan");
Uri designation = Uri.parse("https://rms2.rhapsody.ae/api/all_roles");
Uri schdulejp =
    Uri.parse("https://rms2.rhapsody.ae/api/add_scheduled_journeyplan");
Uri Attendance = Uri.parse("https://rms2.rhapsody.ae/api/attendance_monthly");
Uri updateemp = Uri.parse("https://rms2.rhapsody.ae/api/update_employee");
Uri LeaveacceptReject =
    Uri.parse("https://rms2.rhapsody.ae/api/leave_accept_reject");
Uri BrandDetails = Uri.parse("https://rms2.rhapsody.ae/api/brand_details");
Uri AddBrand = Uri.parse("https://rms2.rhapsody.ae/api/add_brand");
Uri CategoryDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/category_details");
Uri AddCategory = Uri.parse("https://rms2.rhapsody.ae/api/add_category");
Uri AddProducts = Uri.parse("https://rms2.rhapsody.ae/api/add_product");
Uri productdetails = Uri.parse("https://rms2.rhapsody.ae/api/product_details");
Uri Addoutletbrandmap =
    Uri.parse("https://rms2.rhapsody.ae/api/add_outlet_brand_mapping");
Uri outletbrandmapping =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_brand_mapping_details");
Uri AvailabilityDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/availability_details");
Uri AddAvailability =
    Uri.parse("https://rms2.rhapsody.ae/api/add_availability");
Uri CompetitionDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/competition_details");
Uri AddCompetition = Uri.parse("https://rms2.rhapsody.ae/api/add_competition");
Uri Weekoffdetails = Uri.parse("https://rms2.rhapsody.ae/api/week_off_details");
Uri AddWeekoff = Uri.parse("https://rms2.rhapsody.ae/api/add_week_off");
Uri AddTaskList = Uri.parse("https://rms2.rhapsody.ae/api/add_outlet_task");
Uri GetTaskDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_task_details");
Uri stockexpiryDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/stock_product_details_new");
Uri addedstockexpiryDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/stock_expiry_details_new");
Uri addexpiryDetail =
    Uri.parse("https://rms2.rhapsody.ae/api/add_stock_expiry_new");
Uri AddShareofshelf =
    Uri.parse("https://rms2.rhapsody.ae/api/add_share_of_shelf");
Uri MercViewUpdtPromo = Uri.parse(
    "https://rms2.rhapsody.ae/api/merchandiser_view_updated_promotion__details");
Uri MercAddPromotion = Uri.parse(
    "https://rms2.rhapsody.ae/api/merchandiser_add_promotion__details");
Uri PromoDetails = Uri.parse(
    "https://rms2.rhapsody.ae/api/fieldmanager_view_promotion_details");
Uri AddPromotion =
    Uri.parse("https://rms2.rhapsody.ae/api/fieldmanager_add_promotion");
Uri AddPlanoFM =
    Uri.parse("https://rms2.rhapsody.ae/api/fieldmanager_add_outlet_planogram");
Uri AddOutletMap = Uri.parse(
    "https://rms2.rhapsody.ae/api/fieldmanager_add_outlet_category_mapping");
Uri AddBrandOMap =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_brand_mapping_details");
Uri addoutletshareofshelf = Uri.parse(
    "https://rms2.rhapsody.ae/api/fieldmanager_add_outlet_shareofself");
Uri clientpromodataurl = Uri.parse(
    "https://rms2.rhapsody.ae/api/client_view_outlet_promotion_check_details");
Uri NBLDetailsFMs = Uri.parse(
    "https://rms2.rhapsody.ae/api/fieldmanager_view_outlet_nbl_details");
Uri clientoutletsurl =
    Uri.parse("https://rms2.rhapsody.ae/api/client_view_outlet_details");
Uri clientexpiryinfo = Uri.parse(
    "https://rms2.rhapsody.ae/api/client_view_outlet_stock_expirey_details");
Uri delcategorymapping =
    Uri.parse("https://rms2.rhapsody.ae/api/delete_outlet_products_mapping");
Uri FMAddNBL =
    Uri.parse("https://rms2.rhapsody.ae/api/fieldmanager_add_outlet_nbl");
Uri deactCL = Uri.parse("https://rms2.rhapsody.ae/api/de_active_outlet_task");
Uri actCL = Uri.parse("https://rms2.rhapsody.ae/api/active_outlet_task");
Uri MercBreak =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_journey_check_in_out");
Uri NotiDet =
    Uri.parse("https://rms2.rhapsody.ae/api/view_notification_details");
Uri NotiViewAll =
    Uri.parse("https://rms2.rhapsody.ae/api/make_notification_all_viewed");
Uri RelieverDet =
    Uri.parse("https://rms2.rhapsody.ae/api/view_reliver_details");
Uri searchReliever = Uri.parse("https://rms2.rhapsody.ae/api/search_reliver");
Uri AddReliever = Uri.parse("https://rms2.rhapsody.ae/api/add_reliver");
Uri NotiViewed =
    Uri.parse("https://rms2.rhapsody.ae/api/make_notification_viewed");
Uri TotalJnryTime =
    Uri.parse("https://rms2.rhapsody.ae/api/outlet_journey_time_details");
Uri ForceCIReason = Uri.parse("https://rms2.rhapsody.ae/api/add_force_checkin");
Uri Uploadfile = Uri.parse("https://rms2.rhapsody.ae/api/add_excel_report");
Uri downloadfile =
    Uri.parse("https://rms2.rhapsody.ae/api/excel_report_details");
Uri Logout = Uri.parse("https://rms2.rhapsody.ae/api/logout");
Uri Merchlistundercde =
    Uri.parse("https://rms2.rhapsody.ae/api/merchandiser_under_cde_details");
Uri CDEdashboard = Uri.parse("https://rms2.rhapsody.ae/api/cde_dashboard");
Uri CDEReportingDet =
    Uri.parse("https://rms2.rhapsody.ae/api/cde_reporting_to_details");
Uri AddReportCDE = Uri.parse("https://rms2.rhapsody.ae/api/add_cde");
Uri CDEApproveTimeSheet =
    Uri.parse("https://rms2.rhapsody.ae/api/cde_timesheet_approval");
Uri LeaveReportwithtype =
    Uri.parse("https://rms2.rhapsody.ae/api/leave_request");
Uri LeaveReportDetails = Uri.parse(
    "https://rms2.rhapsody.ae/api/leave_details_view_by_fieldmanager");
Uri FMViewOutletTaskDetails = Uri.parse(
    "https://rms2.rhapsody.ae/api/fieldmanager_view_outlet_task_response");
Uri LeaveRuleDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/leave_rule_details");
Uri LeaveRuleUpdtae =
    Uri.parse("https://rms2.rhapsody.ae/api/update_leave_rule");

Uri viewRefillDetails =
    Uri.parse("https://rms2.rhapsody.ae/api/view_refill_details");
Uri addrefillDetail =
    Uri.parse("https://rms2.rhapsody.ae/api/store_refill_details");
Uri versionCheck = Uri.parse("https://rms2.rhapsody.ae/api/version-check");
Uri splitShiftMarkerUrl = Uri.parse("https://rms2.rhapsody.ae/api/split-shift");

int ischatscreen;
bool newmsgavaiable = false;
var currenttimesheetid;
var fieldmanagernameofcurrentmerch;
var fieldmanagerofcurrentmerch;
var currentmerchid;
bool alreadycheckedina = false;
bool fromloginscreen = false;

Future logout() async {
  try {
    http.Response response = await http.post(
      Logout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
    );
    print(response.body);
  } on SocketException catch (_) {
    return false;
  }
}

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'Good Morning';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Good Afternoon';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good Evening';
  } else {
    return 'Greetings';
  }
}

bool loginfromloginpage = false;

class loggedin {
  static var email;
  static var password;
}

int currentoutletid;
//int Currenttimesheetid;
Future loginapi() async {
  var logindatajson;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  logindatajson = prefs.getString('logindata');
  print("logindata: $logindatajson");
  if (logindatajson == null || currentlysyncing) {
    loggedin.email =
        loginfromloginpage ? loginrequestdata.inputemail : remembereddata.email;
    loggedin.password = loginfromloginpage
        ? loginrequestdata.inputpassword
        : remembereddata.password;
    Map loginData = {
      'email': '${loggedin.email}',
      'password': '${loggedin.password}',
    };
    print("loginData...$loginData");
    try {
      http.Response response = await http.post(Loginurl, body: loginData);
      print("loginDataResponse...${response.body}");
      if (response.statusCode == 200) {
        userpassword.password = loggedin.password;
        // print('Current Password Entered is ${userpassword.password}');
        print("LoginDone");
        logindatajson = response.body;
        await adduserdetails(logindatajson);
        var decodeData = jsonDecode(logindatajson);
        DBrequestdata.receivedtoken = decodeData['token'];
        DBrequestdata.client = decodeData['client'];
        DBrequestdata.receivedempid = decodeData['user']['emp_id'];
        DBrequestdata.empname = decodeData['user']['name'];
        DBrequestdata.emailid = decodeData['user']['email'];
        currentuser.roleid = decodeData['user']['role_id'];
        print(DBrequestdata.empname);
        print(DBrequestdata.client);

        if (currentuser.roleid == 6) {
          currentmerchid =
              DBrequestdata.receivedempid = decodeData['user']['emp_id'];
          print('The current merch id is: $currentmerchid');
        }
        return currentuser.roleid;
      } else {
        print(response.body);
        print(response.statusCode);
        String data = response.body;
        var decodeData = jsonDecode(data);
        DBrequestdata.message = decodeData['message'];
        print("error");
        print(response.body);
        return currentuser.roleid;
      }
    } on SocketException catch (_) {
      return false;
    }
  } else {
    userpassword.password = loggedin.password;
    var decodeData = jsonDecode(logindatajson);
    DBrequestdata.receivedtoken = decodeData['token'];
    DBrequestdata.client = decodeData['client'];
    DBrequestdata.receivedempid = decodeData['user']['emp_id'];
    DBrequestdata.empname = decodeData['user']['name'];
    DBrequestdata.emailid = decodeData['user']['email'];
    currentuser.roleid = decodeData['user']['role_id'];
    print(DBrequestdata.empname);

    if (currentuser.roleid == 6) {
      currentmerchid =
          DBrequestdata.receivedempid = decodeData['user']['emp_id'];
    }
    return currentuser.roleid;
  }
}

class loginrequestdata {
  static var inputemail;
  static var inputpassword;
}

class outletrequestdata {
  static var outletidpressed;
}

class DBrequestdata {
  static var receivedtoken;
  static var receivedempid;
  static var empname;
  static var emailid;
  static var message;
  static var client;
}

Future DBRequestdaily() async {
  var dbdailyresponse;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dbdailyresponse = prefs.getString('dbdailymerch');
  print("dbdaily: $dbdailyresponse");
  if (dbdailyresponse == null || currentlysyncing) {
    Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
    print(DBrequestData);
    try {
      http.Response DBresponse = await http.post(
        DBdailyurl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(DBrequestData),
      );
      if (DBresponse.statusCode == 200) {
        print("The response from DBRequest Daily : ${DBresponse.body}");
        print('dashboard daily done');
        dbdailyresponse = DBresponse.body;
        await adddailydashboardmerch(dbdailyresponse);
        var decodeDBData = jsonDecode(dbdailyresponse);
        DBResponsedatadaily.shedulevisits = decodeDBData['SheduleCalls'];
        DBResponsedatadaily.unshedulevisits = decodeDBData['UnSheduleCalls'];
        DBResponsedatadaily.ShedulevisitssDone =
            decodeDBData['SheduleCallsDone'];
        DBResponsedatadaily.UnShedulevisitsDone =
            decodeDBData['UnSheduleCallsDone'];
        DBResponsedatadaily.Attendance = decodeDBData['Attendance'];
        DBResponsedatadaily.WorkingTime = decodeDBData['WorkingTime'];
        DBResponsedatadaily.EffectiveTime = decodeDBData['EffectiveTime'];
        DBResponsedatadaily.TravelTime = decodeDBData['TravelTime'];
        DBResponsedatadaily.todayPlanpercentage =
            decodeDBData['JourneyPlanpercentage'];
        return DBResponsedatadaily.todayPlanpercentage;
      }
      if (DBresponse.statusCode != 200) {
        print(DBresponse.statusCode);
      }
    } on SocketException catch (_) {
      if (dbdailyresponse != null) {
        var decodeDBData = jsonDecode(dbdailyresponse);
        DBResponsedatadaily.shedulevisits = decodeDBData['SheduleCalls'];
        DBResponsedatadaily.unshedulevisits = decodeDBData['UnSheduleCalls'];
        DBResponsedatadaily.ShedulevisitssDone =
            decodeDBData['SheduleCallsDone'];
        DBResponsedatadaily.UnShedulevisitsDone =
            decodeDBData['UnSheduleCallsDone'];
        DBResponsedatadaily.Attendance = decodeDBData['Attendance'];
        DBResponsedatadaily.WorkingTime = decodeDBData['WorkingTime'];
        DBResponsedatadaily.EffectiveTime = decodeDBData['EffectiveTime'];
        DBResponsedatadaily.TravelTime = decodeDBData['TravelTime'];
        DBResponsedatadaily.todayPlanpercentage =
            decodeDBData['JourneyPlanpercentage'];
        return DBResponsedatadaily.todayPlanpercentage;
      }
      return false;
    }
  } else {
    var decodeDBData = jsonDecode(dbdailyresponse);
    DBResponsedatadaily.shedulevisits = decodeDBData['SheduleCalls'];
    DBResponsedatadaily.unshedulevisits = decodeDBData['UnSheduleCalls'];
    DBResponsedatadaily.ShedulevisitssDone = decodeDBData['SheduleCallsDone'];
    DBResponsedatadaily.UnShedulevisitsDone =
        decodeDBData['UnSheduleCallsDone'];
    DBResponsedatadaily.Attendance = decodeDBData['Attendance'];
    DBResponsedatadaily.WorkingTime = decodeDBData['WorkingTime'];
    DBResponsedatadaily.EffectiveTime = decodeDBData['EffectiveTime'];
    DBResponsedatadaily.TravelTime = decodeDBData['TravelTime'];
    DBResponsedatadaily.todayPlanpercentage =
        decodeDBData['JourneyPlanpercentage'];
    return DBResponsedatadaily.todayPlanpercentage;
  }
}

Future DBRequestmonthly() async {
  var dbmonthly;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dbmonthly = prefs.getString('dbmontlymerch');
  print(currentlysyncing);
  if (dbmonthly == null || currentlysyncing) {
    Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
    print('DB Monthly: $DBrequestData');
    try {
      http.Response DBresponse = await http.post(
        DBmonthlyurl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
        },
        body: jsonEncode(DBrequestData),
      );
      print(DBresponse.body);
      if (DBresponse.statusCode == 200) {
        print('dashboard monthly done');
        dbmonthly = DBresponse.body;
        await adddailymonthlymerch(dbmonthly);
        var decodeDBData = jsonDecode(dbmonthly);
        DBResponsedatamonthly.shedulevisits = decodeDBData['SheduleCalls'];
        DBResponsedatamonthly.unshedulevisits = decodeDBData['UnSheduleCalls'];
        DBResponsedatamonthly.ShedulevisitssDone =
            decodeDBData['SheduleCallsDone'];
        DBResponsedatamonthly.UnShedulevisitsDone =
            decodeDBData['UnSheduleCallsDone'];
        DBResponsedatamonthly.Attendance = decodeDBData['Attendance'];
        DBResponsedatamonthly.WorkingTime = decodeDBData['WorkingTime'];
        DBResponsedatamonthly.EffectiveTime = decodeDBData['EffectiveTime'];
        DBResponsedatamonthly.TravelTime = decodeDBData['TravelTime'];
        DBResponsedatamonthly.monthPlanpercentage =
            decodeDBData['JourneyPlanpercentage'];
        DBResponsedatamonthly.leavebalance = decodeDBData['LeaveCount'];
        remaining.leaves = DBResponsedatamonthly.leavebalance;
        return DBResponsedatamonthly.leavebalance;
      }
      if (DBresponse.statusCode != 200) {
        print(DBresponse.statusCode);
      }
    } on SocketException catch (_) {
      if (dbmonthly != null) {
        var decodeDBData = jsonDecode(dbmonthly);
        DBResponsedatamonthly.shedulevisits = decodeDBData['SheduleCalls'];
        DBResponsedatamonthly.unshedulevisits = decodeDBData['UnSheduleCalls'];
        DBResponsedatamonthly.ShedulevisitssDone =
            decodeDBData['SheduleCallsDone'];
        DBResponsedatamonthly.UnShedulevisitsDone =
            decodeDBData['UnSheduleCallsDone'];
        DBResponsedatamonthly.Attendance = decodeDBData['Attendance'];
        DBResponsedatamonthly.WorkingTime = decodeDBData['WorkingTime'];
        DBResponsedatamonthly.EffectiveTime = decodeDBData['EffectiveTime'];
        DBResponsedatamonthly.TravelTime = decodeDBData['TravelTime'];
        DBResponsedatamonthly.monthPlanpercentage =
            decodeDBData['JourneyPlanpercentage'];
        DBResponsedatamonthly.leavebalance = decodeDBData['LeaveCount'];
        remaining.leaves = DBResponsedatamonthly.leavebalance;
        return DBResponsedatamonthly.leavebalance;
      }
      return false;
    }
  } else {
    var decodeDBData = jsonDecode(dbmonthly);
    DBResponsedatamonthly.shedulevisits = decodeDBData['SheduleCalls'];
    DBResponsedatamonthly.unshedulevisits = decodeDBData['UnSheduleCalls'];
    DBResponsedatamonthly.ShedulevisitssDone = decodeDBData['SheduleCallsDone'];
    DBResponsedatamonthly.UnShedulevisitsDone =
        decodeDBData['UnSheduleCallsDone'];
    DBResponsedatamonthly.Attendance = decodeDBData['Attendance'];
    DBResponsedatamonthly.WorkingTime = decodeDBData['WorkingTime'];
    DBResponsedatamonthly.EffectiveTime = decodeDBData['EffectiveTime'];
    DBResponsedatamonthly.TravelTime = decodeDBData['TravelTime'];
    DBResponsedatamonthly.monthPlanpercentage =
        decodeDBData['JourneyPlanpercentage'];
    DBResponsedatamonthly.leavebalance = decodeDBData['LeaveCount'];
    remaining.leaves = DBResponsedatamonthly.leavebalance;
    return DBResponsedatamonthly.leavebalance;
  }
}

class DBResponsedatadaily {
  static int shedulevisits;
  static int unshedulevisits;
  static int ShedulevisitssDone;
  static int UnShedulevisitsDone;
  static var Attendance;
  static var WorkingTime;
  static var EffectiveTime;
  static var TravelTime;
  static int todayPlanpercentage;
}

class DBResponsedatamonthly {
  static int shedulevisits;
  static int unshedulevisits;
  static int ShedulevisitssDone;
  static int UnShedulevisitsDone;
  static var Attendance;
  static var WorkingTime;
  static var EffectiveTime;
  static var TravelTime;
  static int monthPlanpercentage;
  static var leavebalance;
}

class chekinoutlet {
  static var checkinoutletid;
  static var checkinoutletname;
  static var checkinlat;
  static var checkinlong;
  // static var checkoutlat;
  // static var checkoutlong;
  static var checkinarea;
  static var checkincity;
  static var checkinstate;
  static var checkincountry;
  static var checkinaddress;
  static var contactnumber;
  static var checkinoutlet;
  static double currentdistance;
}

int currentoutletindex;
List<String> outletvisitsdata = [];
List<String> outletEvisitsdata = [];
List<String> offlineoutletdeatiles = [];
List<String> offlinevisibilitydata = [];
List<String> offlineAvailabilityData = [];
List<String> offlinesosdata = [];
List<String> offlineplanodata = [];
List<String> offlinepromodata = [];
List<String> offlinechecklistdata = [];
List<String> offlinenbldata = [];

int outletselectedfordetails;

Future outletOverAllJpWhencheckin(String outletid) async {
  Map ODrequestDataforcheckin = {
    "emp_id": "${DBrequestdata.receivedempid}",
    'outlet_id': '$outletid',
  };
  print(
      "outletOverAllJpWhencheckin....$outletid...ODrequestDataforcheckin..$ODrequestDataforcheckin");
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
    if (OCresponse.statusCode == 200) {
      String OCdata = OCresponse.body;
      var decodeODData = jsonDecode(OCdata);
      print("outletOverAllJpWhencheckinOCurl");
      print(decodeODData);
      chekinoutlet.checkinoutletid =
          decodeODData['data'][0]['store'][0]["store_code"];

      print(chekinoutlet.checkinoutletid);
      chekinoutlet.checkinoutletname =
          decodeODData['data'][0]['store'][0]["store_name"];
      print("store name....${chekinoutlet.checkinoutletname}");
      chekinoutlet.checkinaddress =
          decodeODData['data'][0]['store'][0]["address"];
      chekinoutlet.contactnumber =
          decodeODData['data'][0]['store'][0]["contact_number"];
      chekinoutlet.checkinarea = decodeODData['data'][0]['outlet_area'];
      chekinoutlet.checkincity = decodeODData['data'][0]['outlet_city'];
      chekinoutlet.checkinstate = decodeODData['data'][0]['outlet_state'];
      chekinoutlet.checkincountry = decodeODData['data'][0]['outlet_country'];
      chekinoutlet.checkinlat = decodeODData['data'][0]['outlet_lat'];
      chekinoutlet.checkinlong = decodeODData['data'][0]['outlet_long'];
      chekinoutlet.currentdistance = Geolocator.distanceBetween(
          lat,
          long,
          double.parse(chekinoutlet.checkinlat),
          double.parse(chekinoutlet.checkinlong));

      getchartOverAllJpdetails(outletid);
      return expectectedvistschartOverAllJp(outletid);
    }
  } on SocketException catch (_) {
    return false;
  } on Exception catch (exception) {
    print("Exception....$exception");
    return false;
  } catch (error) {
    print("Exception....$error");
    return false;
  }
}

Future outletwhencheckin() async {
  print("outletwhencheckin....$currentoutletindex");
  print("outletwhencheckin...$currentoutletid");

  // var outletid = outletrequestdata.outletidpressed;
  // chartoutletid.outlet = outletrequestdata.outletidpressed;
  // Map ODrequestDataforcheckin = {
  //   "emp_id": "${DBrequestdata.receivedempid}",
  //   'outlet_id': '$outletid',
  // };
  // print(ODrequestDataforcheckin);
  // http.Response OCresponse = await http.post(OCurl,
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
  //   },
  //   body: jsonEncode(ODrequestDataforcheckin),
  // );
  //if (OCresponse.statusCode == 200) {

  // chekinoutlet.checkinoutletid =null;
  print("outlet when checkin");
  print(currentoutletindex);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // var offlineoutletdeatiles_ = await getListData(alljpoutlets_table);
  /// FOLLOWING ONE LINE OF CODE IS PART OF MODIFIED CODE - TO REVERT BACK UNCOMMENT THE ABOVE ONE LINE OF CODE.
  ///
  var offlineoutletdeatiles_ = await getJourneyPlan();
  if (offlineoutletdeatiles_ != null) {
    print("not null");
    // offlineoutletdeatiles = prefs.getStringList('alljpoutlets')??[];

    offlineoutletdeatiles = offlineoutletdeatiles_;
    print('Checking : $offlineoutletdeatiles');
  } else {
    print('Waiting for data');
  }

  try {
    String OCdata = offlineoutletdeatiles[currentoutletindex];
    // String OCdata = offlineoutletdeatiles[0];

    print(
        "offlineoutletdeatiles length... ${offlineoutletdeatiles.length}..$OCdata");
    var decodeODData = jsonDecode(OCdata);
    print(decodeODData);
    chekinoutlet.checkinoutletid =
        decodeODData['data'][0]['store'][0]["store_code"];

    print(chekinoutlet.checkinoutletid);
    chekinoutlet.checkinoutletname =
        decodeODData['data'][0]['store'][0]["store_name"];
    print("store name....${chekinoutlet.checkinoutletname}");
    chekinoutlet.checkinaddress =
        decodeODData['data'][0]['store'][0]["address"];
    chekinoutlet.contactnumber =
        decodeODData['data'][0]['store'][0]["contact_number"];
    chekinoutlet.checkinarea = decodeODData['data'][0]['outlet_area'];
    chekinoutlet.checkincity = decodeODData['data'][0]['outlet_city'];
    chekinoutlet.checkinstate = decodeODData['data'][0]['outlet_state'];
    chekinoutlet.checkincountry = decodeODData['data'][0]['outlet_country'];
    chekinoutlet.checkinlat = decodeODData['data'][0]['outlet_lat'];
    chekinoutlet.checkinlong = decodeODData['data'][0]['outlet_long'];
    chekinoutlet.currentdistance = Geolocator.distanceBetween(
        lat,
        long,
        double.parse(chekinoutlet.checkinlat),
        double.parse(chekinoutlet.checkinlong));
    await getchartdetails();
    print(
        "lat....$lat..long..$long..${chekinoutlet.checkinlat}..${chekinoutlet.checkinlong}...${chekinoutlet.currentdistance}");
    expectectedvistschart();
    // print("expectectedvistschart....$expectectedvistschart");
    // return expectectedvistschart;
  } on Exception catch (exception) {
    print("Exception....$exception");
    return false;
  } catch (error) {
    print("Exception....$error");
    return false;
  }
  // }
  //
  // if (OCresponse.statusCode != 200) {
  //   print(OCresponse.statusCode);
  // }
}

Future outletwhencheckout() async {
  print("outletwhencheckout....$currentoutletindex");
  print("outletwhencheckout...$currentoutletid");

  print("outlet when checkout");
  print(currentoutletindex);

  var offlineoutletdeatiles_ = await getJourneyPlan();
  if (offlineoutletdeatiles_ != null) {
    print("not null");

    offlineoutletdeatiles = offlineoutletdeatiles_;
    print('Checking : $offlineoutletdeatiles');
  } else {
    print('Waiting for data');
  }

  try {
    String OCdata = offlineoutletdeatiles[currentoutletindex];

    print(
        "offlineoutletdeatiles length... ${offlineoutletdeatiles.length}..$OCdata");
    var decodeODData = jsonDecode(OCdata);
    print(decodeODData);
    chekinoutlet.checkinoutletid =
        decodeODData['data'][0]['store'][0]["store_code"];

    print(chekinoutlet.checkinoutletid);
    chekinoutlet.checkinoutletname =
        decodeODData['data'][0]['store'][0]["store_name"];
    print("store name....${chekinoutlet.checkinoutletname}");
    chekinoutlet.checkinaddress =
        decodeODData['data'][0]['store'][0]["address"];
    chekinoutlet.contactnumber =
        decodeODData['data'][0]['store'][0]["contact_number"];
    chekinoutlet.checkinarea = decodeODData['data'][0]['outlet_area'];
    chekinoutlet.checkincity = decodeODData['data'][0]['outlet_city'];
    chekinoutlet.checkinstate = decodeODData['data'][0]['outlet_state'];
    chekinoutlet.checkincountry = decodeODData['data'][0]['outlet_country'];
    chekinoutlet.checkinlat = decodeODData['data'][0]['outlet_lat'];
    chekinoutlet.checkinlong = decodeODData['data'][0]['outlet_long'];
    chekinoutlet.currentdistance = Geolocator.distanceBetween(
        lat,
        long,
        double.parse(chekinoutlet.checkinlat),
        double.parse(chekinoutlet.checkinlong));
    await getchartdetails();
    print(
        "lat....$lat..long..$long..${chekinoutlet.checkinlat}..${chekinoutlet.checkinlong}...${chekinoutlet.currentdistance}");
    print("expectectedvistschart....$expectectedvistschart");
    return expectectedvistschart();
  } on Exception catch (exception) {
    print("Exception....$exception");
    return false;
  } catch (error) {
    print("Exception....$error");
    return false;
  }
}

class checkinoutdata {
  static var checkinoutdataname;
  static var checkintime;
  static var checkouttime;
  static var checkinlocation;
  static var checkoutlocation;
  static var checkid;
}

void addattendence() async {
  print("addattendence");
  Map data = {"emp_id": "${DBrequestdata.receivedempid}"};

  try {
    http.Response cicoresponse = await http.post(
      attendancein,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(data),
    );
    print("online...addattendence");
    print(cicoresponse.body);
  } on SocketException catch (_) {
    print("offline...addattendence");
    adddataforsync(
        "https://rms2.rhapsody.ae/api/attendance_in", jsonEncode(data), "");
  }
}

Future<bool> checkin() async {
  checkinrequested = true;
  checkindatasubmitted = true;
  // var checkid = checkinoutdata.checkid;
  var checkid = currenttimesheetid;
  var checkintime = checkinoutdata.checkintime;
  var checkinlocation = checkinoutdata.checkinlocation;
  Map checkinoutresponse = {
    "id": "$checkid",
    // "checkin_time": "$checkintime",
    "checkin_location": "$checkinlocation",
  };

  print("checkin...$checkinoutresponse");
  print(
      'Checking the Check in time while checking in : ${checkinoutdata.checkintime}');
  print(
      'Checking the Check out time while checking in : ${checkinoutdata.checkouttime}');
  try {
    http.Response cicoresponse = await http.post(
      CheckInUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(checkinoutresponse),
    );
    if (cicoresponse.statusCode == 200) {
      print("online...checkin");
      print(cicoresponse.body);
      checkindatasubmitted = true;
    } else {
      checkindatasubmitted = false;
    }
  } on SocketException catch (_) {
    print("offline checkin");
    adddataforsync(
        "https://rms2.rhapsody.ae/api/check-in",
        jsonEncode(checkinoutresponse),
        "Checkin at $checkintime for the timesheet $checkid at $checkinlocation");
    CreateLog(
        "checked in $checkintime for the timesheet $checkid at $checkinlocation",
        "true");
  }
}
// THIS CHECKOUT FUNCTION IS COMMENTED OUT AS WE HAVE MOVED THE CHECKOUT FUNCTION TO THE CUSTOMER ACTIVITIES PAGE TO CHECK IF TIMEOUT OPTION CAN BE IMPLEMENTED.
// Future<void> checkout() async {
//   try {
//     await Future.delayed(Duration(seconds: 1), () async {
//       checkoutrequested = true;
//       var checkid = currenttimesheetid;
//       var checkouttime = checkinoutdata.checkouttime;
//       var checkoutlocation = checkinoutdata.checkoutlocation;
//       Map checkinoutresponse = {
//         "id": "$checkid",
//         "checkout_time": "$checkouttime",
//         "checkout_location": "$checkoutlocation",
//       };

//       print("Tester checkout...$checkinoutresponse");
//       print(
//           'Checking the Check in time while checking out : ${checkinoutdata.checkintime}');
//       print(
//           'Checking the Check out time while checking out : ${checkinoutdata.checkouttime}');
//       http.Response cicoresponse = await http.post(
//         CICOurl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//         },
//         body: jsonEncode(checkinoutresponse),
//       );
//       // .timeout(Duration(seconds: 3));

//       if (cicoresponse.statusCode == 200) {
//         print("online...checkout");
//         print(cicoresponse.body);
//         checkoutdatasubmitted = true;
//         DBRequestdaily();
//         DBRequestmonthly();
//       } else {
//         print(cicoresponse.body);
//         checkoutdatasubmitted = false;
//       }
//     });
//   } catch (e) {
//     // Timeout exception handling
//     showDialog(
//       // context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Checkout Timeout'),
//           content: Text(
//               'The checkout operation is taking longer than expected. Do you want to continue waiting or cancel?'),
//           actions: [
//             TextButton(
//               child: Text('Wait'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Continue waiting or perform any other action
//               },
//             ),
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Navigate to a particular page or perform any other action
//                                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => JourneyPlanPage()),);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

Future<void> checkout() async {
  checkoutrequested = true;
  var checkid = currenttimesheetid;
  var checkouttime = checkinoutdata.checkouttime;
  var checkoutlocation = checkinoutdata.checkoutlocation;
  // var checkoutlocation =
  //     "Sector, Dubai, United Arab Emirates(25.171166,55.4246143)";
  var checkinlocation = checkinoutdata.checkinlocation;
  print('Check In Location from Checkout Button: $checkinlocation');
  Map checkinoutresponse = {
    "id": "$checkid",
    // "checkout_time": "$checkouttime",
    "checkout_location": "$checkoutlocation",
    "check_out_in_store": checkinlocation == checkoutlocation ? true : false,
  };

  print("checkout...$checkinoutresponse");
  print(
      'Checking the Check in time while checking out : ${checkinoutdata.checkintime}');
  print(
      'Checking the Check out time while checking out : ${checkinoutdata.checkouttime}');

  try {
    http.Response cicoresponse = await http.post(
      CheckOutUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(checkinoutresponse),
    );

    if (cicoresponse.statusCode == 200) {
      print("online...checkout");
      print('The Check Out Response Body: ${cicoresponse.body}');
      checkoutdatasubmitted = true;
      DBRequestdaily();
      DBRequestmonthly();
    } else {
      print(cicoresponse.body);
      checkoutdatasubmitted = false;
    }
    // } on TimeoutException catch (_) {
    //   // Handle timeout: Show an alert box to the user
    //   print('Time Out Exception Called...');
    //   // BuildContext context;
    //   showDialog(
    //     // context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Checkout Timeout !!!'),
    //         content: Text(
    //             'The checkout operation is taking too long. Do you want to continue waiting or cancel and move to another page?'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //             },
    //             child: Text('Wait'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //               // Navigate to a particular page when checkout is canceled
    //               Navigator.of(context).pushReplacement(
    //                 MaterialPageRoute(builder: (context) => DashBoard()),
    //               );
    //             },
    //             child: Text('Cancel and Move'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
  } on SocketException catch (_) {
    print("offline checkout");
    adddataforsync(
        "https://rms2.rhapsody.ae/api/check-out",
        jsonEncode(checkinoutresponse),
        "Checkout at $checkouttime for the timesheet $checkid at $checkoutlocation");
    CreateLog(
        "checked out $checkouttime for the timesheet $checkid at $checkoutlocation",
        "true");
    gettodayjp.isscheduled[currentoutletindex] == 1
        ? DBResponsedatadaily.ShedulevisitssDone++
        : DBResponsedatadaily.UnShedulevisitsDone++;
    gettodayjp.isscheduled[currentoutletindex] == 1
        ? DBResponsedatamonthly.ShedulevisitssDone++
        : DBResponsedatamonthly.UnShedulevisitsDone++;
    checkoutdatasubmitted = true;
  }
}

Future leaverequest() async {
  var leavetype = leave.type;
  var startdate = leave.startdate;
  var enddate = leave.enddate;
  var reason = leave.reason;
  var image = leave.image;
  Map leaverequestbody = {
    'emp_id': '${DBrequestdata.receivedempid}',
    "leavetype": "$leavetype",
    "leavestartdate": "$startdate",
    "leaveenddate": "$enddate",
    "reason": "$reason",
    "image": "data:image/jpg;base64,$image",
  };
  print(leaverequestbody);
  try {
    http.Response leaveresponse = await http.post(
      leaveurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(leaverequestbody),
    );
    print(leaveresponse.statusCode);
    if (leaveresponse.statusCode == 200) {
      print(jsonDecode(leaveresponse.body));
    }
  } on SocketException catch (_) {
    return false;
  }
}

class leave {
  static var type;
  static var startdate;
  static var enddate;
  static var reason;
  static var image;
}

class userpassword {
  static var password;
}

Future changepassword() async {
  var newpassword = change.password;
  Map requestchangepassword = {
    'emp_id': '${DBrequestdata.receivedempid}',
    "password": "$newpassword"
  };
  try {
    http.Response changedpasswordresponse = await http.post(
      passwordchangeurl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(requestchangepassword),
    );
    print(requestchangepassword);
    print(changedpasswordresponse.statusCode);
    if (changedpasswordresponse.statusCode == 200) {
      print(jsonDecode(changedpasswordresponse.body));
    }
  } on SocketException catch (_) {
    return false;
  }
}

// var Selectedoutletatcheckin = 273 ;
Future getTaskList() async {
  Map taskbody = {
    "outlet_id": currentoutletid,
  };
  print(jsonEncode(taskbody));
  try {
    http.Response response = await http.post(
      taskdetailes,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(taskbody),
    );
    print(response.body);
    if (response.statusCode == 200) {
      task.list = [];
      task.id = [];
      task.iscompleted = [];
      String tasklistbody = response.body;
      print("getTaskList...online...$tasklistbody");
      await saveActivitiesDataIntoDB(currenttimesheetid.toString(),
          tasklistbody, checklistdetaildata_table);
      var decodeODData = jsonDecode(tasklistbody);
      for (int i = 0; i < decodeODData['data'].length; i++) {
        task.list.add(decodeODData['data'][i]['task_list']);
        task.id.add(decodeODData['data'][i]['id']);
        task.iscompleted.add(decodeODData['data'][i]['is_completed']);
      }
    }
  } on SocketException catch (_) {
    print("getTaskList");
    String checklistdata = await getActivityData(
        checklistdetaildata_table, currenttimesheetid.toString());

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    task.list = [];
    if (checklistdata != null) {
      print("getTaskList...offline...$checklistdata");
      task.list = [];
      task.id = [];
      task.iscompleted = [];
      print(
          "offlinechecklistdata leeength ...${offlinechecklistdata.length}....index...$currentoutletindex");
      print("not null");
      // offlinechecklistdata = prefs.getStringList('checklistdetaildata')??[];
      // String data = offlinechecklistdata[currentoutletindex];
      var decodeODData = jsonDecode(checklistdata);
      for (int i = 0; i < decodeODData['data'].length; i++) {
        task.list.add(decodeODData['data'][i]['task_list']);
        task.id.add(decodeODData['data'][i]['id']);
        task.iscompleted.add(decodeODData['data'][i]['is_completed']);
      }

      // }
      print('task data : ${task.list.length}');
    }
  }
}

Future getTaskListFM() async {
  Map taskbody = {
    "outlet_id": currentoutletid,
  };
  print(jsonEncode(taskbody));
  try {
    http.Response response = await http.post(
      taskdetailes,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(taskbody),
    );
    print(response.body);
    if (response.statusCode == 200) {
      taskFM.list = [];
      taskFM.id = [];
      taskFM.iscompleted = [];
      String data = response.body;
      var decodeODData = jsonDecode(data);
      for (int i = 0; i < decodeODData['data'].length; i++) {
        taskFM.list.add(decodeODData['data'][i]['task_list']);
        taskFM.id.add(decodeODData['data'][i]['id']);
        taskFM.iscompleted.add(decodeODData['data'][i]['is_completed']);
      }
      // }
      print('task data : ${task.list}');
    }
  } on SocketException catch (_) {
    return false;
  }
}

class taskFM {
  static List<String> list = [];
  static List<int> id = [];
  static List<int> iscompleted = [];
  static List<String> imgurl = [];
}

Future sendtaskresponse(bool connection) async {
  Map taskbody = {
    "timesheet_id": currenttimesheetid,
    "task_id": task.id,
    "is_completed": task.iscompleted,
    "img_url": task.imgurl,
  };
  print(jsonEncode(taskbody));

  try {
    http.Response response = await http.post(
      taskresponse,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(taskbody),
    );
    print("online...checklist");
    print(response.body);
  } on SocketException catch (_) {
    print("offline sendtaskresponse");
    adddataforsync(
        "https://rms2.rhapsody.ae/api/send_outlet_task_response",
        jsonEncode(taskbody),
        "Check List added for the timesheet id $currenttimesheetid");
  }
}

class change {
  static var password;
}

class task {
  static List<String> list = [];
  static List<int> id = [];
  static List<int> iscompleted = [];
  static List<String> imgurl = [];
}

Future merchbreak() async {
  Map breaktime = {
    "type": "Split Shift",
    "timesheet_id": currenttimesheetid,
    "checkin_time": splitbreak.citime,
    "checkout_time": splitbreak.cotime,
    "journey_time_id": "",
  };
  print("merchbreak...${jsonEncode(breaktime)}");

  try {
    http.Response response = await http.post(
      MercBreak,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(breaktime),
    );
    print("online...merchbreak");
    print(response.body);
  } on SocketException catch (_) {
    print("offline merchbreak");
    adddataforsync(
      "https://rms2.rhapsody.ae/api/outlet_journey_check_in_out",
      jsonEncode(breaktime),
      splitbreak.citime != ""
          ? "Split Shift checkin at ${splitbreak.citime} for the timesheet id $currenttimesheetid"
          : "Split Shift checkout at ${splitbreak.cotime} for the timesheet id $currenttimesheetid",
    );
    CreateLog(
        splitbreak.citime != ""
            ? "Split shift checked in by ${splitbreak.citime} for the timesheet $currenttimesheetid "
            : splitbreak.cotime != null
                ? "Split shift checked out by ${splitbreak.cotime} for the timesheet $currenttimesheetid "
                : " ",
        "true");
  }
}

class splitbreak {
  static var type;
  static var citime;
  static var cotime;
  static var jtimeid;
}

Future<void> getTotalJnyTime() async {
  Map DBrequestData = {
    'timesheet_id': currenttimesheetid,
  };
  print("TSid Tapped:${DBrequestData}");
  try {
    http.Response SDResponse = await http.post(
      TotalJnryTime,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(DBrequestData),
    );
    if (SDResponse.statusCode == 200) {
      print("get Total Journey Plan Done");
      String stores = SDResponse.body;
      var decodestores = jsonDecode(stores);

      TotalJnyTime.id = [];
      TotalJnyTime.checkin = [];
      TotalJnyTime.checkout = [];

      for (int u = 0; u < decodestores['data'].length; u++) {
        indexofjurneytimeid = u;
        if (decodestores['data'][u]['type'] == "Split Shift") {
          TotalJnyTime.id.add(decodestores['data'][u]['id']);
          TotalJnyTime.checkin.add(decodestores['data'][u]['checkin_time']);
        }
        if (decodestores['data'][u]['checkout_time'] == null) {
          TotalJnyTime.checkout.add("Session ended without checkout by user");
        }
        if (decodestores['data'][u]['checkin_time'] != null &&
            decodestores['data'][u]['checkout_time'] == null) {
          TotalJnyTime.status.add("pending");
        } else {
          TotalJnyTime.checkout.add(decodestores['data'][u]['checkout_time']);
        }
        print(TotalJnyTime.status);
      }
    }
    if (SDResponse.statusCode != 200) {
      print(SDResponse.statusCode);
    }
  } on SocketException catch (_) {
    return false;
  }
}

class TotalJnyTime {
  static List<int> id = [];
  static List<String> checkin = [];
  static List<String> checkout = [];
  static List<String> type = [];
  static List<String> status = [];
}

int indexofjurneytimeid;

bool normalcheckin = false;

Future addforeccheckin() async {
  Map forceci = {
    "time_sheet_id": currenttimesheetid,
    "checkin_type": normalcheckin ? "normal" : "force",
    "reason":
        "${forcecheck.reason} at ${DateFormat('HH:mm:ss').format(DateTime.now())} from $appversionnumber",
  };

  try {
    http.Response response = await http.post(
      ForceCIReason,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(forceci),
    );
    print("online...addforeccheckin...$forceci");
    print(response.body);
  } on SocketException catch (_) {
    print("offline addforeccheckin");
    adddataforsync(
        "https://rms2.rhapsody.ae/api/add_force_checkin",
        jsonEncode(forceci),
        "Checkin type ${forcecheck.reason} for the timesheet $currenttimesheetid");
    await Adddatatoserver(requireurlstosync, requirebodytosync, message);
  }
}

class forcecheck {
  static var id;
  static var checktype;
  static var reason;
}
// THE FEATURE IS NOT USED FOR THE TIME BEING HENCE COMMENTED OUT.
// Future outletsurvey() async {
//   Map outsvy = {
//     "timesheet_id": currenttimesheetid,
//     "employee_id": '${DBrequestdata.receivedempid}',
//     "availability": OutletSurveySubmit.availability,
//     "visibility": OutletSurveySubmit.visibility,
//     "shareofself": OutletSurveySubmit.sos,
//     "promotioncheck": OutletSurveySubmit.promotioncheck,
//     "planogramcheck": OutletSurveySubmit.planogram,
//     "compitetorinfo": OutletSurveySubmit.competitor,
//     "stockexpiry": OutletSurveySubmit.stockexpiry,
//   };

//   try {
//     http.Response response = await http.post(
//       OutletSurvey,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(outsvy),
//     );
//     print(response.body);
//     print("online...outletsurvey");
//   } on SocketException catch (_) {
//     print("offline outletsurvey");
//     adddataforsync("https://rms2.rhapsody.ae/api/add_outlet_survey",
//         jsonEncode(outsvy), "outlet survey data");
//   }
// }

class OutletSurveySubmit {
  static var availability;
  static var visibility;
  static var sos;
  static var promotioncheck;
  static var planogram;
  static var competitor;
  static var stockexpiry;
}

Future<void> FMViewOTDet() async {
  Map taskbodyfm = {
    "timesheet_id": currenttimesheetid,
  };
  print(jsonEncode(taskbodyfm));
  try {
    http.Response fmviewTD = await http.post(
      FMViewOutletTaskDetails,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
      },
      body: jsonEncode(taskbodyfm),
    );
    print(fmviewTD.body);
    if (fmviewTD.statusCode == 200) {
      fmviewtaskdata.url = [];
      fmviewtaskdata.list = [];
      print("fm view task details done");

      String data = fmviewTD.body;
      var decodeODData = jsonDecode(data);
      for (int u = 0; u < decodeODData['data'].length; u++) {
        print("check1");

        if ((decodeODData['data'][u]['img_url']) != null) {
          print("check2");
          fmviewtaskdata.url.add(
              "https://rms2.rhapsody.ae/task_file/${decodeODData['data'][u]['img_url']}");
          fmviewtaskdata.list.add(decodeODData['data'][u]['task_list']);
        }
      }
      print('task data : ${task.list}');
    }
  } on SocketException catch (_) {
    return false;
  }
}

class fmviewtaskdata {
  static List<dynamic> url = [];
  static List<String> list = [];
}
