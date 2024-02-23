// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:merchandising/Merchandiser/merchandiserscreens/PlanogramcheckPhase1.dart';
// import 'package:merchandising/model/Location_service.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:convert';
// import 'package:merchandising/main.dart';
// import 'package:merchandising/model/OutLet_BarChart.dart';
// import 'package:merchandising/ConstantMethods.dart';
// import 'package:merchandising/offlinedata/syncsendapi.dart';
// import 'package:merchandising/utils/DatabaseHelper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:merchandising/model/rememberme.dart';
// import 'package:merchandising/api/monthlyvisitschart.dart';
// import 'package:merchandising/offlinedata/sharedprefsdta.dart';
// import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
// import 'package:intl/intl.dart';

// bool splitsf = false;
// bool checkoutdatasubmitted = false;
// bool checkindatasubmitted = false;
// bool checkoutrequested = false;
// bool checkinrequested = false;
// int comid;
// Uri expectedvisitchart =
//     Uri.parse("http://157.245.55.88/api/outlet_expected_outlet_chart");
// Uri OutletSurvey = Uri.parse("http://157.245.55.88/api/add_outlet_survey");
// Uri deltimesheet = Uri.parse("http://157.245.55.88/api/delete_journeyplan");
// Uri ShareofshelfDetails =
//     Uri.parse("http://157.245.55.88/api/share_of_shelf_details");
// Uri PlanogramDetails = Uri.parse("http://157.245.55.88/api/Planogram_details");
// Uri getcompdetails = Uri.parse("http://157.245.55.88/api/competition_details");
// Uri VisibilityDetails =
//     Uri.parse("http://157.245.55.88/api/visibility_details");
// Uri AddVisibility = Uri.parse("http://157.245.55.88/api/add_visibility");
// Uri AddPlanogram = Uri.parse("http://157.245.55.88/api/add_planogram");
// Uri ChartUrl = Uri.parse("http://157.245.55.88/api/outlet_chart");
// Uri Loginurl = Uri.parse("http://157.245.55.88/api/login");
// Uri DBdailyurl = Uri.parse("http://157.245.55.88/api/dashboard_daily");
// Uri DBmonthlyurl = Uri.parse("http://157.245.55.88/api/dashboard_monthly");
// Uri OCurl = Uri.parse("http://157.245.55.88/api/outlet_details");
// Uri CICOurl = Uri.parse("http://157.245.55.88/api/check_in_out");
// Uri CheckInUrl = Uri.parse("http://157.245.55.88/api/check-in");
// Uri CheckOutUrl = Uri.parse("http://157.245.55.88/api/check-out");
// Uri attendancein = Uri.parse("http://157.245.55.88/api/attendance_in");
// Uri UpdateOutlet = Uri.parse("http://157.245.55.88/api/update_outlet");
// Uri TSurl = Uri.parse("http://157.245.55.88/api/timesheet_daily");
// Uri leaveurl = Uri.parse("http://157.245.55.88/api/leave_request");
// Uri empdataurl = Uri.parse("http://157.245.55.88/api/employee_details");
// Uri passwordchangeurl = Uri.parse("http://157.245.55.88/api/change_password");
// Uri taskdetailes = Uri.parse("http://157.245.55.88/api/outlet_task_details");
// Uri taskresponse =
//     Uri.parse("http://157.245.55.88/api/send_outlet_task_response");
// Uri LDurl = Uri.parse("http://157.245.55.88/api/leave_details");
// Uri JPSkippedurl = Uri.parse("http://157.245.55.88/api/today_skipped_journey");
// Uri JPVisitedurl =
//     Uri.parse("http://157.245.55.88/api/today_completed_journey");
// Uri JPurl = Uri.parse("http://157.245.55.88/api/today_planned_journey");
// Uri empdetailsurl =
//     Uri.parse("http://157.245.55.88/api/employee_details_for_report");
// Uri reportingdataurl =
//     Uri.parse("http://157.245.55.88/api/reporting_to_details");
// Uri addreportaurl = Uri.parse("http://157.245.55.88/api/add_reporting");
// Uri holidaysdataurl = Uri.parse("http://157.245.55.88/api/holidays_details");
// Uri addholidayurl = Uri.parse("http://157.245.55.88/api/add_holidays");
// Uri WJPPlannedurl = Uri.parse("http://157.245.55.88/api/week_planned_journey");
// Uri WJPSkippedurl = Uri.parse("http://157.245.55.88/api/week_skipped_journey");
// Uri WJPVisitedurl =
//     Uri.parse("http://157.245.55.88/api/week_completed_journey");
// Uri TSMurl = Uri.parse("http://157.245.55.88/api/timesheet_monthly");
// Uri TSSplitMurl =
//     Uri.parse("http://157.245.55.88/api/timesheet_monthly_split_time");
// Uri HRdburl = Uri.parse("http://157.245.55.88/api/hr_dashboard");
// Uri visitsurl = Uri.parse("http://157.245.55.88/api/outlet_chart");
// Uri MercNameList = Uri.parse(
//     "http://157.245.55.88/api/merchandiser_under_fieldmanager_details");
// Uri Storedetailsurl = Uri.parse("http://157.245.55.88/api/store_details");
// Uri AddStoreurl = Uri.parse("http://157.245.55.88/api/add_store");
// Uri StoreDetailsurl = Uri.parse("http://157.245.55.88/api/store_details");
// Uri FMDashBoardurl =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_dashboard");
// Uri AddOutletsurl = Uri.parse("http://157.245.55.88/api/add_outlet");
// Uri overallJPurl = Uri.parse("http://157.245.55.88/api/journey");
// Uri MercLeaveDetails =
//     Uri.parse("http://157.245.55.88/api/merchandiser_leave_details");
// Uri AddEmployee = Uri.parse("http://157.245.55.88/api/add_employee");
// Uri unschdulejp =
//     Uri.parse("http://157.245.55.88/api/add_unscheduled_journeyplan");
// Uri designation = Uri.parse("http://157.245.55.88/api/all_roles");
// Uri schdulejp = Uri.parse("http://157.245.55.88/api/add_scheduled_journeyplan");
// Uri Attendance = Uri.parse("http://157.245.55.88/api/attendance_monthly");
// Uri updateemp = Uri.parse("http://157.245.55.88/api/update_employee");
// Uri LeaveacceptReject =
//     Uri.parse("http://157.245.55.88/api/leave_accept_reject");
// Uri BrandDetails = Uri.parse("http://157.245.55.88/api/brand_details");
// Uri AddBrand = Uri.parse("http://157.245.55.88/api/add_brand");
// Uri CategoryDetails = Uri.parse("http://157.245.55.88/api/category_details");
// Uri AddCategory = Uri.parse("http://157.245.55.88/api/add_category");
// Uri AddProducts = Uri.parse("http://157.245.55.88/api/add_product");
// Uri productdetails = Uri.parse("http://157.245.55.88/api/product_details");
// Uri Addoutletbrandmap =
//     Uri.parse("http://157.245.55.88/api/add_outlet_brand_mapping");
// Uri outletbrandmapping =
//     Uri.parse("http://157.245.55.88/api/outlet_brand_mapping_details");
// Uri AvailabilityDetails =
//     Uri.parse("http://157.245.55.88/api/availability_details");
// Uri AddAvailability = Uri.parse("http://157.245.55.88/api/add_availability");
// Uri CompetitionDetails =
//     Uri.parse("http://157.245.55.88/api/competition_details");
// Uri AddCompetition = Uri.parse("http://157.245.55.88/api/add_competition");
// Uri Weekoffdetails = Uri.parse("http://157.245.55.88/api/week_off_details");
// Uri AddWeekoff = Uri.parse("http://157.245.55.88/api/add_week_off");
// Uri AddTaskList = Uri.parse("http://157.245.55.88/api/add_outlet_task");
// Uri GetTaskDetails = Uri.parse("http://157.245.55.88/api/outlet_task_details");
// Uri stockexpiryDetails =
//     Uri.parse("http://157.245.55.88/api/stock_product_details_new");
// Uri addedstockexpiryDetails =
//     Uri.parse("http://157.245.55.88/api/stock_expiry_details_new");
// Uri addexpiryDetail =
//     Uri.parse("http://157.245.55.88/api/add_stock_expiry_new");
// Uri addrefillDetail =
//     Uri.parse("http://157.245.55.88/api/store_refill_details");
// Uri AddShareofshelf = Uri.parse("http://157.245.55.88/api/add_share_of_shelf");
// Uri MercViewUpdtPromo = Uri.parse(
//     "http://157.245.55.88/api/merchandiser_view_updated_promotion__details");
// Uri MercAddPromotion =
//     Uri.parse("http://157.245.55.88/api/merchandiser_add_promotion__details");
// Uri PromoDetails =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_view_promotion_details");
// Uri AddPromotion =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_add_promotion");
// Uri AddPlanoFM =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_add_outlet_planogram");
// Uri AddOutletMap = Uri.parse(
//     "http://157.245.55.88/api/fieldmanager_add_outlet_category_mapping");
// Uri AddBrandOMap =
//     Uri.parse("http://157.245.55.88/api/outlet_brand_mapping_details");
// Uri addoutletshareofshelf =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_add_outlet_shareofself");
// Uri clientpromodataurl = Uri.parse(
//     "http://157.245.55.88/api/client_view_outlet_promotion_check_details");
// Uri NBLDetailsFMs =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_view_outlet_nbl_details");
// Uri clientoutletsurl =
//     Uri.parse("http://157.245.55.88/api/client_view_outlet_details");
// Uri clientexpiryinfo = Uri.parse(
//     "http://157.245.55.88/api/client_view_outlet_stock_expirey_details");
// Uri delcategorymapping =
//     Uri.parse("http://157.245.55.88/api/delete_outlet_products_mapping");
// Uri FMAddNBL =
//     Uri.parse("http://157.245.55.88/api/fieldmanager_add_outlet_nbl");
// Uri deactCL = Uri.parse("http://157.245.55.88/api/de_active_outlet_task");
// Uri actCL = Uri.parse("http://157.245.55.88/api/active_outlet_task");
// Uri MercBreak =
//     Uri.parse("http://157.245.55.88/api/outlet_journey_check_in_out");
// Uri NotiDet = Uri.parse("http://157.245.55.88/api/view_notification_details");
// Uri NotiViewAll =
//     Uri.parse("http://157.245.55.88/api/make_notification_all_viewed");
// Uri RelieverDet = Uri.parse("http://157.245.55.88/api/view_reliver_details");
// Uri searchReliever = Uri.parse("http://157.245.55.88/api/search_reliver");
// Uri AddReliever = Uri.parse("http://157.245.55.88/api/add_reliver");
// Uri NotiViewed = Uri.parse("http://157.245.55.88/api/make_notification_viewed");
// Uri TotalJnryTime =
//     Uri.parse("http://157.245.55.88/api/outlet_journey_time_details");
// Uri ForceCIReason = Uri.parse("http://157.245.55.88/api/add_force_checkin");
// Uri Uploadfile = Uri.parse("http://157.245.55.88/api/add_excel_report");
// Uri downloadfile = Uri.parse("http://157.245.55.88/api/excel_report_details");
// Uri Logout = Uri.parse("http://157.245.55.88/api/logout");
// Uri Merchlistundercde =
//     Uri.parse("http://157.245.55.88/api/merchandiser_under_cde_details");
// Uri CDEdashboard = Uri.parse("http://157.245.55.88/api/cde_dashboard");
// Uri CDEReportingDet =
//     Uri.parse("http://157.245.55.88/api/cde_reporting_to_details");
// Uri AddReportCDE = Uri.parse("http://157.245.55.88/api/add_cde");
// Uri CDEApproveTimeSheet =
//     Uri.parse("http://157.245.55.88/api/cde_timesheet_approval");
// Uri LeaveReportwithtype = Uri.parse("http://157.245.55.88/api/leave_request");
// Uri LeaveReportDetails =
//     Uri.parse("http://157.245.55.88/api/leave_details_view_by_fieldmanager");
// Uri FMViewOutletTaskDetails = Uri.parse(
//     "http://157.245.55.88/api/fieldmanager_view_outlet_task_response");
// Uri LeaveRuleDetails = Uri.parse("http://157.245.55.88/api/leave_rule_details");
// Uri LeaveRuleUpdtae = Uri.parse("http://157.245.55.88/api/update_leave_rule");
// Uri viewTestRefillDetails =
//     Uri.parse("http://157.245.55.88/api/view_refill_details");
// Uri versionCheck = Uri.parse("http://157.245.55.88/api/version-check");
// Uri splitShiftMarkerUrl = Uri.parse("http://157.245.55.88/api/split-shift");

// int ischatscreen;
// bool newmsgavaiable = false;
// var currenttimesheetid;
// var fieldmanagernameofcurrentmerch;
// var fieldmanagerofcurrentmerch;
// var currentmerchid;
// bool alreadycheckedina = false;
// bool fromloginscreen = false;

// Future logout() async {
//   try {
//     http.Response response = await http.post(
//       Logout,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//     );
//     print(response.body);
//   } on SocketException catch (_) {
//     return false;
//   }
// }

// String greetingMessage() {
//   var timeNow = DateTime.now().hour;

//   if (timeNow <= 12) {
//     return 'Good Morning';
//   } else if ((timeNow > 12) && (timeNow <= 16)) {
//     return 'Good Afternoon';
//   } else if ((timeNow > 16) && (timeNow < 20)) {
//     return 'Good Evening';
//   } else {
//     return 'Greetings';
//   }
// }

// bool loginfromloginpage = false;

// class loggedin {
//   static var email;
//   static var password;
// }

// int currentoutletid;
// //int Currenttimesheetid;
// Future loginapi() async {
//   var logindatajson;
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   logindatajson = prefs.getString('logindata');
//   print("logindata: $logindatajson");
//   if (logindatajson == null || currentlysyncing) {
//     loggedin.email =
//         loginfromloginpage ? loginrequestdata.inputemail : remembereddata.email;
//     loggedin.password = loginfromloginpage
//         ? loginrequestdata.inputpassword
//         : remembereddata.password;
//     Map loginData = {
//       'email': '${loggedin.email}',
//       'password': '${loggedin.password}',
//     };
//     print("loginData...$loginData");
//     try {
//       http.Response response = await http.post(Loginurl, body: loginData);
//       print("loginDataResponse...$response");
//       if (response.statusCode == 200) {
//         userpassword.password = loggedin.password;
//         print("LoginDone");
//         logindatajson = response.body;
//         await adduserdetails(logindatajson);
//         var decodeData = jsonDecode(logindatajson);
//         DBrequestdata.receivedtoken = decodeData['token'];
//         DBrequestdata.client = decodeData['client'];
//         DBrequestdata.receivedempid = decodeData['user']['emp_id'];
//         DBrequestdata.empname = decodeData['user']['name'];
//         DBrequestdata.emailid = decodeData['user']['email'];
//         currentuser.roleid = decodeData['user']['role_id'];
//         print(DBrequestdata.empname);
//         print(DBrequestdata.client);

//         if (currentuser.roleid == 6) {
//           currentmerchid =
//               DBrequestdata.receivedempid = decodeData['user']['emp_id'];
//         }
//         return currentuser.roleid;
//       } else {
//         print(response.body);
//         print(response.statusCode);
//         String data = response.body;
//         var decodeData = jsonDecode(data);
//         DBrequestdata.message = decodeData['message'];
//         print("error");
//         print(response.body);
//         return currentuser.roleid;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//   } else {
//     userpassword.password = loggedin.password;
//     var decodeData = jsonDecode(logindatajson);
//     DBrequestdata.receivedtoken = decodeData['token'];
//     DBrequestdata.client = decodeData['client'];
//     DBrequestdata.receivedempid = decodeData['user']['emp_id'];
//     DBrequestdata.empname = decodeData['user']['name'];
//     DBrequestdata.emailid = decodeData['user']['email'];
//     currentuser.roleid = decodeData['user']['role_id'];
//     print(DBrequestdata.empname);

//     if (currentuser.roleid == 6) {
//       currentmerchid =
//           DBrequestdata.receivedempid = decodeData['user']['emp_id'];
//     }
//     return currentuser.roleid;
//   }
// }

// class loginrequestdata {
//   static var inputemail;
//   static var inputpassword;
// }

// class outletrequestdata {
//   static var outletidpressed;
// }

// class DBrequestdata {
//   static var receivedtoken;
//   static var receivedempid;
//   static var empname;
//   static var emailid;
//   static var message;
//   static var client;
// }

// Future DBRequestdaily() async {
//   var dbdailyresponse;
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   dbdailyresponse = prefs.getString('dbdailymerch');
//   print("dbdaily: $dbdailyresponse");
//   if (dbdailyresponse == null || currentlysyncing) {
//     Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
//     print(DBrequestData);
//     try {
//       http.Response DBresponse = await http.post(
//         DBdailyurl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//         },
//         body: jsonEncode(DBrequestData),
//       );
//       if (DBresponse.statusCode == 200) {
//         print(DBresponse.body);
//         print('dashboard daily done');
//         dbdailyresponse = DBresponse.body;
//         await adddailydashboardmerch(dbdailyresponse);
//         var decodeDBData = jsonDecode(dbdailyresponse);
//         DBResponsedatadaily.shedulevisits = decodeDBData['SheduleCalls'];
//         DBResponsedatadaily.unshedulevisits = decodeDBData['UnSheduleCalls'];
//         DBResponsedatadaily.ShedulevisitssDone =
//             decodeDBData['SheduleCallsDone'];
//         DBResponsedatadaily.UnShedulevisitsDone =
//             decodeDBData['UnSheduleCallsDone'];
//         DBResponsedatadaily.Attendance = decodeDBData['Attendance'];
//         DBResponsedatadaily.WorkingTime = decodeDBData['WorkingTime'];
//         DBResponsedatadaily.EffectiveTime = decodeDBData['EffectiveTime'];
//         DBResponsedatadaily.TravelTime = decodeDBData['TravelTime'];
//         DBResponsedatadaily.todayPlanpercentage =
//             decodeDBData['JourneyPlanpercentage'];
//         return DBResponsedatadaily.todayPlanpercentage;
//       }
//       if (DBresponse.statusCode != 200) {
//         print(DBresponse.statusCode);
//       }
//     } on SocketException catch (_) {
//       if (dbdailyresponse != null) {
//         var decodeDBData = jsonDecode(dbdailyresponse);
//         DBResponsedatadaily.shedulevisits = decodeDBData['SheduleCalls'];
//         DBResponsedatadaily.unshedulevisits = decodeDBData['UnSheduleCalls'];
//         DBResponsedatadaily.ShedulevisitssDone =
//             decodeDBData['SheduleCallsDone'];
//         DBResponsedatadaily.UnShedulevisitsDone =
//             decodeDBData['UnSheduleCallsDone'];
//         DBResponsedatadaily.Attendance = decodeDBData['Attendance'];
//         DBResponsedatadaily.WorkingTime = decodeDBData['WorkingTime'];
//         DBResponsedatadaily.EffectiveTime = decodeDBData['EffectiveTime'];
//         DBResponsedatadaily.TravelTime = decodeDBData['TravelTime'];
//         DBResponsedatadaily.todayPlanpercentage =
//             decodeDBData['JourneyPlanpercentage'];
//         return DBResponsedatadaily.todayPlanpercentage;
//       }
//       return false;
//     }
//   } else {
//     var decodeDBData = jsonDecode(dbdailyresponse);
//     DBResponsedatadaily.shedulevisits = decodeDBData['SheduleCalls'];
//     DBResponsedatadaily.unshedulevisits = decodeDBData['UnSheduleCalls'];
//     DBResponsedatadaily.ShedulevisitssDone = decodeDBData['SheduleCallsDone'];
//     DBResponsedatadaily.UnShedulevisitsDone =
//         decodeDBData['UnSheduleCallsDone'];
//     DBResponsedatadaily.Attendance = decodeDBData['Attendance'];
//     DBResponsedatadaily.WorkingTime = decodeDBData['WorkingTime'];
//     DBResponsedatadaily.EffectiveTime = decodeDBData['EffectiveTime'];
//     DBResponsedatadaily.TravelTime = decodeDBData['TravelTime'];
//     DBResponsedatadaily.todayPlanpercentage =
//         decodeDBData['JourneyPlanpercentage'];
//     return DBResponsedatadaily.todayPlanpercentage;
//   }
// }

// Future DBRequestmonthly() async {
//   var dbmonthly;
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   dbmonthly = prefs.getString('dbmontlymerch');
//   print(currentlysyncing);
//   if (dbmonthly == null || currentlysyncing) {
//     Map DBrequestData = {'emp_id': '${DBrequestdata.receivedempid}'};
//     try {
//       http.Response DBresponse = await http.post(
//         DBmonthlyurl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//         },
//         body: jsonEncode(DBrequestData),
//       );
//       print(DBresponse.body);
//       if (DBresponse.statusCode == 200) {
//         print('dashboard monthly done');
//         dbmonthly = DBresponse.body;
//         await adddailymonthlymerch(dbmonthly);
//         var decodeDBData = jsonDecode(dbmonthly);
//         DBResponsedatamonthly.shedulevisits = decodeDBData['SheduleCalls'];
//         DBResponsedatamonthly.unshedulevisits = decodeDBData['UnSheduleCalls'];
//         DBResponsedatamonthly.ShedulevisitssDone =
//             decodeDBData['SheduleCallsDone'];
//         DBResponsedatamonthly.UnShedulevisitsDone =
//             decodeDBData['UnSheduleCallsDone'];
//         DBResponsedatamonthly.Attendance = decodeDBData['Attendance'];
//         DBResponsedatamonthly.WorkingTime = decodeDBData['WorkingTime'];
//         DBResponsedatamonthly.EffectiveTime = decodeDBData['EffectiveTime'];
//         DBResponsedatamonthly.TravelTime = decodeDBData['TravelTime'];
//         DBResponsedatamonthly.monthPlanpercentage =
//             decodeDBData['JourneyPlanpercentage'];
//         DBResponsedatamonthly.leavebalance = decodeDBData['LeaveCount'];
//         remaining.leaves = DBResponsedatamonthly.leavebalance;
//         return DBResponsedatamonthly.leavebalance;
//       }
//       if (DBresponse.statusCode != 200) {
//         print(DBresponse.statusCode);
//       }
//     } on SocketException catch (_) {
//       if (dbmonthly != null) {
//         var decodeDBData = jsonDecode(dbmonthly);
//         DBResponsedatamonthly.shedulevisits = decodeDBData['SheduleCalls'];
//         DBResponsedatamonthly.unshedulevisits = decodeDBData['UnSheduleCalls'];
//         DBResponsedatamonthly.ShedulevisitssDone =
//             decodeDBData['SheduleCallsDone'];
//         DBResponsedatamonthly.UnShedulevisitsDone =
//             decodeDBData['UnSheduleCallsDone'];
//         DBResponsedatamonthly.Attendance = decodeDBData['Attendance'];
//         DBResponsedatamonthly.WorkingTime = decodeDBData['WorkingTime'];
//         DBResponsedatamonthly.EffectiveTime = decodeDBData['EffectiveTime'];
//         DBResponsedatamonthly.TravelTime = decodeDBData['TravelTime'];
//         DBResponsedatamonthly.monthPlanpercentage =
//             decodeDBData['JourneyPlanpercentage'];
//         DBResponsedatamonthly.leavebalance = decodeDBData['LeaveCount'];
//         remaining.leaves = DBResponsedatamonthly.leavebalance;
//         return DBResponsedatamonthly.leavebalance;
//       }
//       return false;
//     }
//   } else {
//     var decodeDBData = jsonDecode(dbmonthly);
//     DBResponsedatamonthly.shedulevisits = decodeDBData['SheduleCalls'];
//     DBResponsedatamonthly.unshedulevisits = decodeDBData['UnSheduleCalls'];
//     DBResponsedatamonthly.ShedulevisitssDone = decodeDBData['SheduleCallsDone'];
//     DBResponsedatamonthly.UnShedulevisitsDone =
//         decodeDBData['UnSheduleCallsDone'];
//     DBResponsedatamonthly.Attendance = decodeDBData['Attendance'];
//     DBResponsedatamonthly.WorkingTime = decodeDBData['WorkingTime'];
//     DBResponsedatamonthly.EffectiveTime = decodeDBData['EffectiveTime'];
//     DBResponsedatamonthly.TravelTime = decodeDBData['TravelTime'];
//     DBResponsedatamonthly.monthPlanpercentage =
//         decodeDBData['JourneyPlanpercentage'];
//     DBResponsedatamonthly.leavebalance = decodeDBData['LeaveCount'];
//     remaining.leaves = DBResponsedatamonthly.leavebalance;
//     return DBResponsedatamonthly.leavebalance;
//   }
// }

// class DBResponsedatadaily {
//   static int shedulevisits;
//   static int unshedulevisits;
//   static int ShedulevisitssDone;
//   static int UnShedulevisitsDone;
//   static var Attendance;
//   static var WorkingTime;
//   static var EffectiveTime;
//   static var TravelTime;
//   static int todayPlanpercentage;
// }

// class DBResponsedatamonthly {
//   static int shedulevisits;
//   static int unshedulevisits;
//   static int ShedulevisitssDone;
//   static int UnShedulevisitsDone;
//   static var Attendance;
//   static var WorkingTime;
//   static var EffectiveTime;
//   static var TravelTime;
//   static int monthPlanpercentage;
//   static var leavebalance;
// }

// class chekinoutlet {
//   static var checkinoutletid;
//   static var checkinoutletname;
//   static var checkinlat;
//   static var checkinlong;
//   static var checkinarea;
//   static var checkincity;
//   static var checkinstate;
//   static var checkincountry;
//   static var checkinaddress;
//   static var contactnumber;
//   static var checkinoutlet;
//   static double currentdistance;
// }

// int currentoutletindex;
// List<String> outletvisitsdata = [];
// List<String> outletEvisitsdata = [];
// List<String> offlineoutletdeatiles = [];
// List<String> offlinevisibilitydata = [];
// List<String> offlineAvailabilityData = [];
// List<String> offlinesosdata = [];
// List<String> offlineplanodata = [];
// List<String> offlinepromodata = [];
// List<String> offlinechecklistdata = [];
// List<String> offlinenbldata = [];

// int outletselectedfordetails;

// Future outletOverAllJpWhencheckin(String outletid) async {
//   Map ODrequestDataforcheckin = {
//     "emp_id": "${DBrequestdata.receivedempid}",
//     'outlet_id': '$outletid',
//   };
//   print(
//       "outletOverAllJpWhencheckin....$outletid...ODrequestDataforcheckin..$ODrequestDataforcheckin");
//   try {
//     http.Response OCresponse = await http.post(
//       OCurl,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(ODrequestDataforcheckin),
//     );
//     if (OCresponse.statusCode == 200) {
//       String OCdata = OCresponse.body;
//       var decodeODData = jsonDecode(OCdata);
//       print("outletOverAllJpWhencheckinOCurl");
//       print(decodeODData);
//       chekinoutlet.checkinoutletid =
//           decodeODData['data'][0]['store'][0]["store_code"];

//       print(chekinoutlet.checkinoutletid);
//       chekinoutlet.checkinoutlet =
//           decodeODData['data'][0]['store'][0]["outlet_id"];
//       chekinoutlet.checkinoutletname =
//           decodeODData['data'][0]['store'][0]["store_name"];
//       print("store name....${chekinoutlet.checkinoutletname}");
//       chekinoutlet.checkinaddress =
//           decodeODData['data'][0]['store'][0]["address"];
//       chekinoutlet.contactnumber =
//           decodeODData['data'][0]['store'][0]["contact_number"];
//       chekinoutlet.checkinarea = decodeODData['data'][0]['outlet_area'];
//       chekinoutlet.checkincity = decodeODData['data'][0]['outlet_city'];
//       chekinoutlet.checkinstate = decodeODData['data'][0]['outlet_state'];
//       chekinoutlet.checkincountry = decodeODData['data'][0]['outlet_country'];
//       chekinoutlet.checkinlat = decodeODData['data'][0]['outlet_lat'];
//       chekinoutlet.checkinlong = decodeODData['data'][0]['outlet_long'];
//       chekinoutlet.currentdistance = Geolocator.distanceBetween(
//           lat,
//           long,
//           double.parse(chekinoutlet.checkinlat),
//           double.parse(chekinoutlet.checkinlong));

//       getchartOverAllJpdetails(outletid);
//       return expectectedvistschartOverAllJp(outletid);
//     }
//   } on SocketException catch (_) {
//     return false;
//   } on Exception catch (exception) {
//     print("Exception....$exception");
//     return false;
//   } catch (error) {
//     print("Exception....$error");
//     return false;
//   }
// }

// Future outletwhencheckin() async {
//   print("outletwhencheckin....$currentoutletindex");
//   print("outletwhencheckin...$currentoutletid");

//   // var outletid = outletrequestdata.outletidpressed;
//   // chartoutletid.outlet = outletrequestdata.outletidpressed;
//   // Map ODrequestDataforcheckin = {
//   //   "emp_id": "${DBrequestdata.receivedempid}",
//   //   'outlet_id': '$outletid',
//   // };
//   // print(ODrequestDataforcheckin);
//   // http.Response OCresponse = await http.post(OCurl,
//   //   headers: {
//   //     'Content-Type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//   //   },
//   //   body: jsonEncode(ODrequestDataforcheckin),
//   // );
//   //if (OCresponse.statusCode == 200) {

//   // chekinoutlet.checkinoutletid =null;
//   print("outlet when checkin");
//   print(currentoutletindex);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var offlineoutletdeatiles_ = await getListData(alljpoutlets_table);
//   if (offlineoutletdeatiles_ != null) {
//     print("not null");
//     // offlineoutletdeatiles = prefs.getStringList('alljpoutlets')??[];

//     offlineoutletdeatiles = offlineoutletdeatiles_;
//   }

//   try {
//     String OCdata = offlineoutletdeatiles[currentoutletindex];
//     print(
//         "offlineoutletdeatiles length... ${offlineoutletdeatiles.length}..$OCdata");
//     var decodeODData = jsonDecode(OCdata);
//     print(decodeODData);
//     chekinoutlet.checkinoutletid =
//         decodeODData['data'][0]['store'][0]["store_code"];

//     print(chekinoutlet.checkinoutletid);
//     chekinoutlet.checkinoutletname =
//         decodeODData['data'][0]['store'][0]["store_name"];
//     print("store name....${chekinoutlet.checkinoutletname}");
//     chekinoutlet.checkinaddress =
//         decodeODData['data'][0]['store'][0]["address"];
//     chekinoutlet.contactnumber =
//         decodeODData['data'][0]['store'][0]["contact_number"];
//     chekinoutlet.checkinarea = decodeODData['data'][0]['outlet_area'];
//     chekinoutlet.checkincity = decodeODData['data'][0]['outlet_city'];
//     chekinoutlet.checkinstate = decodeODData['data'][0]['outlet_state'];
//     chekinoutlet.checkincountry = decodeODData['data'][0]['outlet_country'];
//     chekinoutlet.checkinlat = decodeODData['data'][0]['outlet_lat'];
//     chekinoutlet.checkinlong = decodeODData['data'][0]['outlet_long'];
//     chekinoutlet.currentdistance = Geolocator.distanceBetween(
//         lat,
//         long,
//         double.parse(chekinoutlet.checkinlat),
//         double.parse(chekinoutlet.checkinlong));
//     getchartdetails();
//     print(
//         "lat....$lat..long..$long..${chekinoutlet.checkinlat}..${chekinoutlet.checkinlong}...${chekinoutlet.currentdistance}");
//     // print("expectectedvistschart....$expectectedvistschart");
//     return expectectedvistschart();
//   } on Exception catch (exception) {
//     print("Exception....$exception");
//     return false;
//   } catch (error) {
//     print("Exception....$error");
//     return false;
//   }
//   // }
//   //
//   // if (OCresponse.statusCode != 200) {
//   //   print(OCresponse.statusCode);
//   // }
// }

// class checkinoutdata {
//   static var checkinoutdataname;
//   static var checkintime;
//   static var checkouttime;
//   static var checkinlocation;
//   static var checkoutlocation;
//   static var checkid;
//   static var inStoreCheckout;
// }

// void addattendence() async {
//   print("addattendence");
//   Map data = {"emp_id": "${DBrequestdata.receivedempid}"};

//   try {
//     http.Response cicoresponse = await http.post(
//       attendancein,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(data),
//     );
//     print("online...addattendence");
//     print(cicoresponse.body);
//   } on SocketException catch (_) {
//     print("offline...addattendence");
//     adddataforsync(
//         "http://157.245.55.88/api/attendance_in", jsonEncode(data), "");
//   }
// }

// Future<bool> checkin() async {
//   checkinrequested = true;
//   checkindatasubmitted = true;
//   // var checkid = checkinoutdata.checkid;
//   var checkid = currenttimesheetid;
//   var checkintime = checkinoutdata.checkintime;
//   var checkinlocation = checkinoutdata.checkinlocation;
//   Map checkinoutresponse = {
//     "id": "$checkid",
//     // "checkin_time": "$checkintime",
//     "checkin_location": "$checkinlocation",
//   };

//   print("checkin...$checkinoutresponse");
//   try {
//     // CHANGED CICOUrl to CheckInUrl
//     http.Response cicoresponse = await http.post(
//       CheckInUrl,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(checkinoutresponse),
//     );
//     if (cicoresponse.statusCode == 200) {
//       print("online...checkin");
//       print('Response of checkin : ${cicoresponse.body}');
//       checkindatasubmitted = true;
//     } else {
//       checkindatasubmitted = false;
//     }
//   } on SocketException catch (_) {
//     print("offline checkin");
//     adddataforsync(
//         "http://157.245.55.88/api/check-in",
//         jsonEncode(checkinoutresponse),
//         "Checkin at $checkintime for the timesheet $checkid at $checkinlocation");
//     CreateLog(
//         "checked in $checkintime for the timesheet $checkid at $checkinlocation",
//         "true");
//   }
// }

// checkout() async {
//   checkoutrequested = true;
//   var checkid = currenttimesheetid;
//   var checkouttime = checkinoutdata.checkouttime;
//   var checkoutlocation = checkinoutdata.checkoutlocation;
//   var checkinlocation = checkinoutdata.checkinlocation;
//   // if (checkinlocation == checkoutlocation) {
//   //   var inStoreCheckout = true;
//   // }
//   Map checkinoutresponse = {
//     "id": "$checkid",
//     // "checkout_time": "$checkouttime",
//     "checkout_location": "$checkoutlocation",
//     "check_out_in_store": checkinlocation == checkoutlocation ? true : false,
//   };

//   print("checkout...$checkinoutresponse");

//   try {
//     // CHANGED CICOUrl to CheckOutUrl
//     http.Response cicoresponse = await http.post(
//       CheckOutUrl,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(checkinoutresponse),
//     );
//     if (cicoresponse.statusCode == 200) {
//       print("online...checkout");
//       print(cicoresponse.body);
//       checkoutdatasubmitted = true;
//       DBRequestdaily();
//       DBRequestmonthly();
//     } else {
//       print(cicoresponse.body);
//       checkoutdatasubmitted = false;
//     }
//   } on SocketException catch (_) {
//     print("offline checkout");
//     adddataforsync(
//         "http://157.245.55.88/api/check-out",
//         jsonEncode(checkinoutresponse),
//         "Checkout at $checkouttime for the timesheet $checkid at $checkoutlocation");
//     CreateLog(
//         "checked out $checkouttime for the timesheet $checkid at $checkoutlocation",
//         "true");
//     gettodayjp.isscheduled[currentoutletindex] == 1
//         ? DBResponsedatadaily.ShedulevisitssDone++
//         : DBResponsedatadaily.UnShedulevisitsDone++;
//     gettodayjp.isscheduled[currentoutletindex] == 1
//         ? DBResponsedatamonthly.ShedulevisitssDone++
//         : DBResponsedatamonthly.UnShedulevisitsDone++;
//     checkoutdatasubmitted = true;
//   }
// }

// Future leaverequest() async {
//   var leavetype = leave.type;
//   var startdate = leave.startdate;
//   var enddate = leave.enddate;
//   var reason = leave.reason;
//   var image = leave.image;
//   Map leaverequestbody = {
//     'emp_id': '${DBrequestdata.receivedempid}',
//     "leavetype": "$leavetype",
//     "leavestartdate": "$startdate",
//     "leaveenddate": "$enddate",
//     "reason": "$reason",
//     "image": "data:image/jpg;base64,$image",
//   };
//   print(leaverequestbody);
//   try {
//     http.Response leaveresponse = await http.post(
//       leaveurl,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(leaverequestbody),
//     );
//     print(leaveresponse.statusCode);
//     if (leaveresponse.statusCode == 200) {
//       print(jsonDecode(leaveresponse.body));
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
// }

// class leave {
//   static var type;
//   static var startdate;
//   static var enddate;
//   static var reason;
//   static var image;
// }

// class userpassword {
//   static var password;
// }

// Future changepassword() async {
//   var newpassword = change.password;
//   Map requestchangepassword = {
//     'emp_id': '${DBrequestdata.receivedempid}',
//     "password": "$newpassword"
//   };
//   try {
//     http.Response changedpasswordresponse = await http.post(
//       passwordchangeurl,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(requestchangepassword),
//     );
//     print(requestchangepassword);
//     print(changedpasswordresponse.statusCode);
//     if (changedpasswordresponse.statusCode == 200) {
//       print(jsonDecode(changedpasswordresponse.body));
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
// }

// // var Selectedoutletatcheckin = 273 ;
// Future getTaskList() async {
//   Map taskbody = {
//     "outlet_id": currentoutletid,
//   };
//   print(jsonEncode(taskbody));
//   try {
//     http.Response response = await http.post(
//       taskdetailes,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(taskbody),
//     );
//     print(response.body);
//     if (response.statusCode == 200) {
//       task.list = [];
//       task.id = [];
//       task.iscompleted = [];
//       String tasklistbody = response.body;
//       print("getTaskList...online...$tasklistbody");
//       await saveActivitiesDataIntoDB(currenttimesheetid.toString(),
//           tasklistbody, checklistdetaildata_table);
//       var decodeODData = jsonDecode(tasklistbody);
//       for (int i = 0; i < decodeODData['data'].length; i++) {
//         task.list.add(decodeODData['data'][i]['task_list']);
//         task.id.add(decodeODData['data'][i]['id']);
//         task.iscompleted.add(decodeODData['data'][i]['is_completed']);
//       }
//     }
//   } on SocketException catch (_) {
//     print("getTaskList");
//     String checklistdata = await getActivityData(
//         checklistdetaildata_table, currenttimesheetid.toString());

//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     task.list = [];
//     if (checklistdata != null) {
//       print("getTaskList...offline...$checklistdata");
//       task.list = [];
//       task.id = [];
//       task.iscompleted = [];
//       print(
//           "offlinechecklistdata leeength ...${offlinechecklistdata.length}....index...$currentoutletindex");
//       print("not null");
//       // offlinechecklistdata = prefs.getStringList('checklistdetaildata')??[];
//       // String data = offlinechecklistdata[currentoutletindex];
//       var decodeODData = jsonDecode(checklistdata);
//       for (int i = 0; i < decodeODData['data'].length; i++) {
//         task.list.add(decodeODData['data'][i]['task_list']);
//         task.id.add(decodeODData['data'][i]['id']);
//         task.iscompleted.add(decodeODData['data'][i]['is_completed']);
//       }

//       // }
//       print('task data : ${task.list.length}');
//     }
//   }
// }

// Future getTaskListFM() async {
//   Map taskbody = {
//     "outlet_id": currentoutletid,
//   };
//   print(jsonEncode(taskbody));
//   try {
//     http.Response response = await http.post(
//       taskdetailes,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(taskbody),
//     );
//     print(response.body);
//     if (response.statusCode == 200) {
//       taskFM.list = [];
//       taskFM.id = [];
//       taskFM.iscompleted = [];
//       String data = response.body;
//       var decodeODData = jsonDecode(data);
//       for (int i = 0; i < decodeODData['data'].length; i++) {
//         taskFM.list.add(decodeODData['data'][i]['task_list']);
//         taskFM.id.add(decodeODData['data'][i]['id']);
//         taskFM.iscompleted.add(decodeODData['data'][i]['is_completed']);
//       }
//       // }
//       print('task data : ${task.list}');
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
// }

// class taskFM {
//   static List<String> list = [];
//   static List<int> id = [];
//   static List<int> iscompleted = [];
//   static List<String> imgurl = [];
// }

// Future sendtaskresponse(bool connection) async {
//   Map taskbody = {
//     "timesheet_id": currenttimesheetid,
//     "task_id": task.id,
//     "is_completed": task.iscompleted,
//     "img_url": task.imgurl,
//   };
//   print(jsonEncode(taskbody));

//   try {
//     http.Response response = await http.post(
//       taskresponse,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(taskbody),
//     );
//     print("online...checklist");
//     print(response.body);
//   } on SocketException catch (_) {
//     print("offline sendtaskresponse");
//     adddataforsync(
//         "http://157.245.55.88/api/send_outlet_task_response",
//         jsonEncode(taskbody),
//         "Check List added for the timesheet id $currenttimesheetid");
//   }
// }

// class change {
//   static var password;
// }

// class task {
//   static List<String> list = [];
//   static List<int> id = [];
//   static List<int> iscompleted = [];
//   static List<String> imgurl = [];
// }

// Future merchbreak() async {
//   Map breaktime = {
//     "type": "Split Shift",
//     "timesheet_id": currenttimesheetid,
//     "checkin_time": splitbreak.citime,
//     "checkout_time": splitbreak.cotime,
//     "journey_time_id": "",
//   };
//   print("merchbreak...${jsonEncode(breaktime)}");

//   try {
//     http.Response response = await http.post(
//       MercBreak,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(breaktime),
//     );
//     print("online...merchbreak");
//     print(response.body);
//   } on SocketException catch (_) {
//     print("offline merchbreak");
//     adddataforsync(
//       "http://157.245.55.88/api/outlet_journey_check_in_out",
//       jsonEncode(breaktime),
//       splitbreak.citime != ""
//           ? "Split Shift checkin at ${splitbreak.citime} for the timesheet id $currenttimesheetid"
//           : "Split Shift checkout at ${splitbreak.cotime} for the timesheet id $currenttimesheetid",
//     );
//     CreateLog(
//         splitbreak.citime != ""
//             ? "Split shift checked in by ${splitbreak.citime} for the timesheet $currenttimesheetid "
//             : splitbreak.cotime != null
//                 ? "Split shift checked out by ${splitbreak.cotime} for the timesheet $currenttimesheetid "
//                 : " ",
//         "true");
//   }
// }

// class splitbreak {
//   static var type;
//   static var citime;
//   static var cotime;
//   static var jtimeid;
//   // static var splitOutlet;
// }

// Future<void> getTotalJnyTime() async {
//   Map DBrequestData = {
//     'timesheet_id': currenttimesheetid,
//   };
//   print("TSid Tapped:${DBrequestData}");
//   try {
//     http.Response SDResponse = await http.post(
//       TotalJnryTime,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(DBrequestData),
//     );
//     if (SDResponse.statusCode == 200) {
//       print("get Total Journey Plan Done");
//       String stores = SDResponse.body;
//       var decodestores = jsonDecode(stores);

//       TotalJnyTime.id = [];
//       TotalJnyTime.checkin = [];
//       TotalJnyTime.checkout = [];

//       for (int u = 0; u < decodestores['data'].length; u++) {
//         indexofjurneytimeid = u;
//         if (decodestores['data'][u]['type'] == "Split Shift") {
//           TotalJnyTime.id.add(decodestores['data'][u]['id']);
//           TotalJnyTime.checkin.add(decodestores['data'][u]['checkin_time']);
//         }
//         if (decodestores['data'][u]['checkout_time'] == null) {
//           TotalJnyTime.checkout.add("Session ended without checkout by user");
//         }
//         if (decodestores['data'][u]['checkin_time'] != null &&
//             decodestores['data'][u]['checkout_time'] == null) {
//           TotalJnyTime.status.add("pending");
//         } else {
//           TotalJnyTime.checkout.add(decodestores['data'][u]['checkout_time']);
//         }
//         print(TotalJnyTime.status);
//       }
//     }
//     if (SDResponse.statusCode != 200) {
//       print(SDResponse.statusCode);
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
// }

// class TotalJnyTime {
//   static List<int> id = [];
//   static List<String> checkin = [];
//   static List<String> checkout = [];
//   static List<String> type = [];
//   static List<String> status = [];
// }

// int indexofjurneytimeid;

// bool normalcheckin = false;

// Future addforeccheckin() async {
//   Map forceci = {
//     "time_sheet_id": currenttimesheetid,
//     "checkin_type": normalcheckin ? "normal" : "force",
//     "reason":
//         "${forcecheck.reason} at ${DateFormat('HH:mm:ss').format(DateTime.now())} from $appversionnumber",
//   };
//   print('Request Body for Force Check In: $forceci');
//   try {
//     http.Response response = await http.post(
//       ForceCIReason,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(forceci),
//     );
//     print("online...addforeccheckin...$forceci");
//     print(response.body);
//   } on SocketException catch (_) {
//     print("offline addforeccheckin");
//     adddataforsync(
//         "http://157.245.55.88/api/add_force_checkin",
//         jsonEncode(forceci),
//         "Checkin type ${forcecheck.reason} for the timesheet $currenttimesheetid");
//     await Adddatatoserver(requireurlstosync, requirebodytosync, message);
//   }
// }

// class forcecheck {
//   static var id;
//   static var checktype;
//   static var reason;
// }

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
//     adddataforsync("http://157.245.55.88/api/add_outlet_survey",
//         jsonEncode(outsvy), "outlet survey data");
//   }
// }

// class OutletSurveySubmit {
//   static var availability;
//   static var visibility;
//   static var sos;
//   static var promotioncheck;
//   static var planogram;
//   static var competitor;
//   static var stockexpiry;
// }

// Future<void> FMViewOTDet() async {
//   Map taskbodyfm = {
//     "timesheet_id": currenttimesheetid,
//   };
//   print(jsonEncode(taskbodyfm));
//   try {
//     http.Response fmviewTD = await http.post(
//       FMViewOutletTaskDetails,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
//       },
//       body: jsonEncode(taskbodyfm),
//     );
//     print(fmviewTD.body);
//     if (fmviewTD.statusCode == 200) {
//       fmviewtaskdata.url = [];
//       fmviewtaskdata.list = [];
//       print("fm view task details done");

//       String data = fmviewTD.body;
//       var decodeODData = jsonDecode(data);
//       for (int u = 0; u < decodeODData['data'].length; u++) {
//         print("check1");

//         if ((decodeODData['data'][u]['img_url']) != null) {
//           print("check2");
//           fmviewtaskdata.url.add(
//               "http://157.245.55.88/task_file/${decodeODData['data'][u]['img_url']}");
//           fmviewtaskdata.list.add(decodeODData['data'][u]['task_list']);
//         }
//       }
//       print('task data : ${task.list}');
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
// }

// class fmviewtaskdata {
//   static List<dynamic> url = [];
//   static List<String> list = [];
// }
