import 'package:shared_preferences/shared_preferences.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:intl/intl.dart';
import '../api/api_service2.dart';

addLogindetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('useremail', "${loginrequestdata.inputemail}");
  prefs.setString('userpassword', "${loginrequestdata.inputpassword}");
  print("detailes added");
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("useremail");
  prefs.remove("userpassword");
  prefs.remove("checkintime");
}

removeValuess() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("checkintime");
}

class remembereddata {
  static String email;
  static String password;
}

chackdata() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool CheckValue = prefs.containsKey('useremail');
  print(CheckValue);
}
