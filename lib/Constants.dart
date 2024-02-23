class AppConstants {
  static const String appName = "RMS";
  static const String title = "Rhapsody merchandising solutions";
  static const String email_address = "Email Address";
  static const String password = "Password";
  static const String valid_email_error = "Email Id should be valid";
  static const String valid_password_error =
      "Password should be more than 6 characters";

  //HRdashboard
  static const String attendance_report = "Attendance\nReport";
  static const String employees = "Employees";
  static const String reporting = "Reporting";
  static const String attendance_summary = "Attendance Summary";
  static const String present = "Present";
  static const String absent = "Absent";
  static const String field_managers = "Field\nManagers";
  static const String total = "Total";
  static const String merchandisers = "Merchandisers";
  static const String total_leave_requests = "Total Leave Request's";
  static const String employee_leave_balance = "Employee Leave Balance";
  static const String holidays = "Holidays";
  static const String workingdays = "Working days";
  static const String leave_rules = "Leave Rules";
  static const String my_activity = "My Activity";
  static const String welcome_hr =
      " Welcome to the new HR\ninterface of RMS.'Hope to have a\ngreat day ahead!,";
  static const String total_available_leaves = "Total Available Leave's";
  static const String apply_leave = "Apply Leave";
  static const String my_attendance = "My Attendance";

  //FMDashboard
  static const String greetings = "Wishing You A Great Day Ahead 😀";
  static const String performance_indicator = "Performance Indicator";
  static const String total_outlets = "Total Outlets";
  static const String completed = "Completed";
  static const String pending = "Pending";
  static const String today_outlets = "Today Outlets";
  static const String outlets = "Outlets";
  static const String journey_plan = "Journey Plan";
  static const String over_all_journey_plan = "Over All Journey Plan";
  static const String reports = "Reports";
  static const String time_sheet = "Time Sheet";
  static const String activities = "Activities";
  static const String leave_response = "Leave Response";
  static const String leave_balance = "Leave\nBalance";
  static const String reliever = "Reliever";
  static const String cde_reporting = "CDE\nReporting";
  static const String welcome_fm =
      "Welcome to the new field manager\ninterface of RMS.'' Hope you have a\ngreat day ahead!";
  static const String welcome_cde =
      "Welcome to the new CDE interface\nof RMS.'' Hope you have a\ngreat day ahead!";

  //JourneyPlan
  static const String checkout_updated = "Checkout Updated";
  static const String checkout_error =
      "Error While Updating Checkout Please Try again.";
  static const String internet_to_refresh =
      "Active internet is required to Refresh Journey Plan";
  static const String map = "Map";
  static const String PLANNED = "PLANNED";
  static const String YET_TO_VISIT = "YET TO VISIT";
  static const String VISITED = "VISITED";
  static const String today_monthly_plan =
      "we have journey plan only for today and monthly only";
  static const String today_plan = "we have journey plan only for today";
  static const String no_active_plan =
      "you don\'t have any active journey plan\ncontact your manager for more info";
  static const String alert = "Alert";
  static const String split_shift =
      "It seems you have already finished this Outlet\nDo you want to do Split Shift?";
  static const String YES = "YES";
  static const String sync_msg =
      "please synchronize before start your journey plan";
  static const String unscheduled = "(unscheduled)";
  static const String contact_number = "Contact Number :";
  static const String distance = "Distance :";
  static const String KM = "KM";
  static const String done = "done";
  static const String refreshing = "Refreshing";
  static const String dont_turn_off =
      "Please don\'t turn off your data, or close the app";
  static const String make_sure_internet =
      "Make sure you had an active internet";

  //Customers Activities
  static const String outlet_survey = "Outlet Survey";
  static const String availability = "Availability";
  static const String visibility = "Visibility";
  static const String share_of_shelf = "Share of Shelf";
  static const String planogram = "Planogram";
  static const String promotion_check = "Promotion Check";
  static const String compitetor_info_capture = "Compitetor Info Capture";
  static const String expiry_info = "Expiry Info";
  static const String ok = "Ok";
  static const String Cancel = "Cancel";
  static const String Check_out = "Check out";

  //MerchandisersDashboard
  static const String working = "working";
  static const String roll_call = "Roll Call";
  static const String uniform_and_hygiene = "Uniform and Hygiene";
  static const String hand_held_unit_charge = "Hand Held Unit Charge";
  static const String transportation = "Transportation";
  static const String POSM = "POSM";
  static const String location = "Location";

}

class NotifcationData {
  String displayName;
  String subject;
  String shortDescription;
  String notificationTime;
  bool unreadNotification;

  NotifcationData({
    this.displayName,
    this.subject,
    this.shortDescription,
    this.notificationTime,
    this.unreadNotification,
  });
}

List<NotifcationData> notifications = [
  NotifcationData(
    displayName: "AJ",
    subject: "RMS",
    shortDescription: "The Merchandising Solution",
    notificationTime: "18:20:12",
    unreadNotification: true,
    
  ),
  NotifcationData(
    displayName: "AJ",
    subject: "Halo CRM",
    shortDescription: "Constant companion of Etisalat",
    notificationTime: "18:20:12",
    unreadNotification: true,
  ),
  NotifcationData(
    displayName: "AJ",
    subject: "eBazaar",
    shortDescription: "The Online Store",
    notificationTime: "18:20:12",
    unreadNotification: true,
  ),
  NotifcationData(
    displayName: "AJ",
    subject: "Van Sales",
    shortDescription: "All Details in ONE App",
    notificationTime: "18:20:12",
    unreadNotification: true,
  ),
  NotifcationData(
    displayName: "AJ",
    subject: "RMS",
    shortDescription: "The Merchandising Solution",
    notificationTime: "18:20:12",
    unreadNotification: true,
  ),
 
  NotifcationData(
    displayName: "AJ",
    subject: "RMS",
    shortDescription: "The Merchandising Solution",
    notificationTime: "18:20:12",
    unreadNotification: true,
  ),
];


class LeaveInfo {
  String leaveReason;
  String leaveFromDate;
  String leaveToDate;
  String leaveType;
  String leaveStatus;
  int colorCode;
  LeaveInfo({
    this.leaveReason,
    this.leaveFromDate,
    this.leaveToDate,
    this.leaveType,
    this.leaveStatus,
    this.colorCode,
  });
}

List<LeaveInfo> leave = [
  LeaveInfo(
    leaveReason: "Personal Reasons",
    leaveFromDate: "2022-09-27",
    leaveToDate: "2022-09-29",
    leaveType: "Loss of Pay",
    leaveStatus: "Rejected",
    colorCode: 0XFFE43700,
  ),
  LeaveInfo(
    leaveReason: "Severe Cough and Cold",
    leaveFromDate: "2022-09-27",
    leaveToDate: "2022-09-29",
    leaveType: "Sick Leave",
    leaveStatus: "Accepted",
    colorCode: 0XFF00984F,
  ),
  LeaveInfo(
    leaveReason: "Personal Reasons",
    leaveFromDate: "2022-09-27",
    leaveToDate: "2022-09-29",
    leaveType: "Loss of Pay",
    leaveStatus: "Pending",
    colorCode: 0XFFFFB017,
  ),
  LeaveInfo(
    leaveReason: "Personal Reasons",
    leaveFromDate: "2022-09-27",
    leaveToDate: "2022-09-29",
    leaveType: "Loss of Pay",
    leaveStatus: "Rejected",
    colorCode: 0XFFE43700,
  ),
  LeaveInfo(
    leaveReason: "Personal Reasons",
    leaveFromDate: "2022-09-27",
    leaveToDate: "2022-09-29",
    leaveType: "Loss of Pay",
    leaveStatus: "Accepted",
    colorCode: 0XFF00984F,
  ),
  LeaveInfo(
    leaveReason: "Personal Reasons",
    leaveFromDate: "2022-09-27",
    leaveToDate: "2022-09-29",
    leaveType: "Loss of Pay",
    leaveStatus: "Accepted",
    colorCode: 0XFF00984F,
  ),
];

class TimeSheetData {
  String displayDate;
  String outletName;
  String checkInTime;
  String checkOutTime;

  TimeSheetData({
    this.displayDate,
    this.outletName,
    this.checkInTime,
    this.checkOutTime,
  });
}

List<TimeSheetData> timeData = [
  TimeSheetData(
    displayDate: "January 25",
    outletName: "YAS Mall",
    checkInTime: "17:52:34",
    checkOutTime: "18:20:12",
  ),
  TimeSheetData(
    displayDate: "January 25",
    outletName: "Marina Mall",
    checkInTime: "17:52:34",
    checkOutTime: "18:20:12",
  ),
  TimeSheetData(
    displayDate: "January 25",
    outletName: "Dubai Mall",
    checkInTime: "17:52:34",
    checkOutTime: "18:20:12",
  ),
  TimeSheetData(
    displayDate: "January 25",
    outletName: "Emirates Mall",
    checkInTime: "17:52:34",
    checkOutTime: "18:20:12",
  ),
  TimeSheetData(
    displayDate: "January 25",
    outletName: "Lulu Hypermarket",
    checkInTime: "17:52:34",
    checkOutTime: "18:20:12",
  ),
  TimeSheetData(
    displayDate: "January 25",
    outletName: "Al Quoz Mall",
    checkInTime: "17:52:34",
    checkOutTime: "18:20:12",
  ),
];
