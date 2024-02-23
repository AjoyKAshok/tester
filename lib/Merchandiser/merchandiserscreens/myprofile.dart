import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/empdetailsapi.dart';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/model/rememberme.dart';
import 'package:merchandising/utils/background.dart';

import '../../api/api_service2.dart';

class Myprofile extends StatefulWidget {
  @override
  _MyprofileState createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  @override
  void initState() {
    ischatscreen = 0;
    print('chatscreen fromprofile = $ischatscreen');
  }

  // TextEditingController currentpasswordcontroller = TextEditingController();
  // TextEditingController newpasswordcontroller = TextEditingController();
  // TextEditingController newpasswordv2controller = TextEditingController();
  // TextEditingController mobilenumbercontroller = TextEditingController();
  // GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Color(0XFF909090),
          ),
          // iconTheme: IconThemeData(color: orange),
          title: Row(
            children: [
              Text(
                'My Profile',
                style: TextStyle(color: Color(0XFF909090)),
              ),
            ],
          ),
        ),
        // drawer: Drawer(
        //   child: Menu(),
        // ),
        body: Stack(
          children: [
            BackGround(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 25, right: 20, bottom: 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .82,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      CircleAvatar(
                          backgroundColor: Color(0XFFE7E7E7),
                          radius: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.00),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Icon(
                                  Icons.person_outline_outlined,
                                  color: Color(0XFFE84201),
                                  size: 60,
                                ),
                                // Image(image: AssetImage('images/capture.png'))
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DBrequestdata.empname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          // Text("."),
                          Text(
                            DBrequestdata.receivedempid,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Color(0XFF909090)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Personal Info",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            margin: EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Full Name",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Text(':'),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child:
                                            Text(': ${DBrequestdata.empname}')),
                                    // Text(': ${DBrequestdata.empname}'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "E-mail :",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child:
                                            Text(': ${DBrequestdata.emailid}')),
                                    // Text(DBrequestdata.emailid),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Joining Date",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Text(
                                            ': ${myprofile.joiningdate}' ??
                                                "")),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Department :",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child: Text(
                                          ': ${myprofile.department}' ?? ""),
                                    ),
                                    // Text(myprofile.department??""),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nationality :",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child: Text(
                                          ': ${myprofile.nationality}' ?? ""),
                                    ),
                                    // Text(myprofile.nationality ?? ""),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Visa Company Info",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Text(
                                            '${myprofile.visacompanyname}' !=
                                                    null
                                                ? ': ${myprofile.visacompanyname}'
                                                : "")),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Visa Expiry date :",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Text(
                                            '${myprofile.visaexpirydate}' !=
                                                    null
                                                ? ': ${myprofile.visaexpirydate}'
                                                : "")),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Passport Expiry date :",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Text(
                                            '${myprofile.passportexpirydate}' !=
                                                    null
                                                ? ': ${myprofile.passportexpirydate}'
                                                : "")),
                                  ],
                                ),
                                /*   Row(
                                  children: [
                                    Text(
                                      "Employee Score :",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(myprofile.employeescore!=null?myprofile.employeescore.toString():""),
                                  ],
                                ), */
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Update Info",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 80,
                            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            margin: EdgeInsets.all(10.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mobile Number",
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Text(':'),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Text(
                                            ': ${myprofile.mobilenumber}' ??
                                                "")),
                                    // Text(': ${DBrequestdata.empname}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Change Password",
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Color(0XFFE84201),
                                      ),
                                      onTap: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) =>
                                              BottomModalSheet(),
                                        );
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (_) => AlertDialog(
                                        //           backgroundColor:
                                        //               alertboxcolor,
                                        //           shape: RoundedRectangleBorder(
                                        //               borderRadius:
                                        //                   BorderRadius.all(
                                        //                       Radius.circular(
                                        //                           10.0))),
                                        //           content: Builder(
                                        //             builder: (context) {
                                        //               // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                        //               return Form(
                                        //                 key: globalFormKey,
                                        //                 child: Column(
                                        //                   mainAxisSize:
                                        //                       MainAxisSize.min,
                                        //                   crossAxisAlignment:
                                        //                       CrossAxisAlignment
                                        //                           .start,
                                        //                   children: [
                                        //                     Text(
                                        //                       "Change Password",
                                        //                       style: TextStyle(
                                        //                           fontWeight:
                                        //                               FontWeight
                                        //                                   .bold),
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 10.00,
                                        //                     ),
                                        //                     Theme(
                                        //                       data: ThemeData(
                                        //                           primaryColor:
                                        //                               orange),
                                        //                       child:
                                        //                           TextFormField(
                                        //                         controller:
                                        //                             currentpasswordcontroller,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .text,
                                        //                         validator: (input) =>
                                        //                             input.length <
                                        //                                     6
                                        //                                 ? "Password should be more than 6 characters"
                                        //                                 : null,
                                        //                         obscureText:
                                        //                             true,
                                        //                         decoration:
                                        //                             new InputDecoration(
                                        //                           focusColor:
                                        //                               grey,
                                        //                           hintText:
                                        //                               "Current Password",
                                        //                           hintStyle:
                                        //                               TextStyle(
                                        //                             color: grey,
                                        //                           ),
                                        //                           prefixIcon:
                                        //                               Icon(
                                        //                             Icons.lock,
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                     Theme(
                                        //                       data: ThemeData(
                                        //                           primaryColor:
                                        //                               orange),
                                        //                       child:
                                        //                           TextFormField(
                                        //                         controller:
                                        //                             newpasswordcontroller,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .text,
                                        //                         validator: (input) =>
                                        //                             input.length <
                                        //                                     6
                                        //                                 ? "Password should be more than 6 characters"
                                        //                                 : null,
                                        //                         obscureText:
                                        //                             true,
                                        //                         decoration:
                                        //                             new InputDecoration(
                                        //                           focusColor:
                                        //                               grey,
                                        //                           hintText:
                                        //                               "New Password",
                                        //                           hintStyle:
                                        //                               TextStyle(
                                        //                             color: grey,
                                        //                           ),
                                        //                           prefixIcon:
                                        //                               Icon(
                                        //                             Icons.lock,
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                     Theme(
                                        //                       data: ThemeData(
                                        //                           primaryColor:
                                        //                               orange),
                                        //                       child:
                                        //                           TextFormField(
                                        //                         controller:
                                        //                             newpasswordv2controller,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .text,
                                        //                         validator: (input) =>
                                        //                             input.length <
                                        //                                     6
                                        //                                 ? "Password should be more than 6 characters"
                                        //                                 : null,
                                        //                         obscureText:
                                        //                             true,
                                        //                         decoration:
                                        //                             new InputDecoration(
                                        //                           focusColor:
                                        //                               grey,
                                        //                           hintText:
                                        //                               "Confirm new Password",
                                        //                           hintStyle:
                                        //                               TextStyle(
                                        //                             color: grey,
                                        //                           ),
                                        //                           prefixIcon:
                                        //                               Icon(
                                        //                             Icons.lock,
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 10.00,
                                        //                     ),
                                        //                     Row(
                                        //                       mainAxisAlignment:
                                        //                           MainAxisAlignment
                                        //                               .center,
                                        //                       children: [
                                        //                         GestureDetector(
                                        //                           onTap: () {
                                        //                             print(userpassword
                                        //                                 .password);
                                        //                             if (validateAndSave()) {
                                        //                               if (userpassword
                                        //                                       .password ==
                                        //                                   currentpasswordcontroller
                                        //                                       .text) {
                                        //                                 if (newpasswordcontroller.text ==
                                        //                                     newpasswordv2controller.text) {
                                        //                                   print(
                                        //                                       "send password to api");
                                        //                                   change.password =
                                        //                                       newpasswordcontroller.text;
                                        //                                   Navigator.pop(
                                        //                                       context,
                                        //                                       MaterialPageRoute(builder: (BuildContextcontext) => Myprofile()));
                                        //                                   Flushbar(
                                        //                                     message:
                                        //                                         "password Updated",
                                        //                                     duration:
                                        //                                         Duration(seconds: 3),
                                        //                                   )..show(
                                        //                                       context);
                                        //                                   changepassword();
                                        //                                   userpassword.password =
                                        //                                       newpasswordcontroller.text;
                                        //                                   currentpasswordcontroller
                                        //                                       .clear();
                                        //                                   newpasswordcontroller
                                        //                                       .clear();
                                        //                                   newpasswordv2controller
                                        //                                       .clear();
                                                                          // removeValues();
                                        //                                   print(
                                        //                                       userpassword.password);
                                        //                                 } else {
                                        //                                   Flushbar(
                                        //                                     message:
                                        //                                         "password's didn't match",
                                        //                                     duration:
                                        //                                         Duration(seconds: 3),
                                        //                                   )..show(
                                        //                                       context);
                                        //                                 }
                                        //                               } else {
                                        //                                 Flushbar(
                                        //                                   message:
                                        //                                       "current password was wrong",
                                        //                                   duration:
                                        //                                       Duration(seconds: 3),
                                        //                                 )..show(
                                        //                                     context);
                                        //                               }
                                        //                             }
                                        //                           },
                                        //                           child:
                                        //                               Container(
                                        //                             height: 40,
                                        //                             width: 70,
                                        //                             decoration:
                                        //                                 BoxDecoration(
                                        //                               color:
                                        //                                   orange,
                                        //                               borderRadius:
                                        //                                   BorderRadius.circular(
                                        //                                       5),
                                        //                             ),
                                        //                             margin: EdgeInsets.only(
                                        //                                 right:
                                        //                                     10.00),
                                        //                             child: Center(
                                        //                                 child: Text(
                                        //                               "Submit",
                                        //                               style: TextStyle(
                                        //                                   color:
                                        //                                       Colors.white),
                                        //                             )),
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               );
                                        //             },
                                        //           ),
                                        //         ));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class BottomModalSheet extends StatefulWidget {
  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    TextEditingController currentpasswordcontroller = TextEditingController();
    TextEditingController newpasswordcontroller = TextEditingController();
    TextEditingController newpasswordv2controller = TextEditingController();
    TextEditingController mobilenumbercontroller = TextEditingController();
    GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

    bool validateAndSave() {
      final form = globalFormKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    bool isCurrentFocused = false;
    bool isNewFocused = false;
    bool isConfirmFocused = false;

    return Container(
      height: MediaQuery.of(context).size.height * .5,
      child: Form(
        key: globalFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 15),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 20),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 19.00,
            ),
            Divider(),
            SizedBox(
              height: 13.00,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 19),
              child: Theme(
                data: ThemeData(primaryColor: orange),
                child: TextFormField(
                   cursorColor: Color(0XFF909090),
                  onChanged: (isFocussed) {
                    setState(() {
                      isCurrentFocused = isFocussed as bool;
                    });
                  },
                  controller: currentpasswordcontroller,
                  keyboardType: TextInputType.text,
                  validator: (input) => input.length < 6
                      ? "Password should be more than 6 characters"
                      : null,
                  obscureText: true,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0XFFE84201),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    labelText: 'Current Password',
                    labelStyle: TextStyle(color: Color(0XFF909090)),
                    focusColor: Colors.grey,
                    fillColor: Colors.white,
                    filled: true,

                    // focusColor: grey,
                    // hintText: "Current Password",
                    // hintStyle: TextStyle(
                    //   color: grey,
                    // ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: isCurrentFocused
                          ? Color(0XFFE84201)
                          : Color(0XFF909090),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 19),
              child: Theme(
                data: ThemeData(primaryColor: orange),
                child: TextFormField(
                   cursorColor: Color(0XFF909090),
                   onChanged: (isFocussed) {
                    setState(() {
                      isNewFocused = isFocussed as bool;
                    });
                  },
                  controller: newpasswordcontroller,
                  keyboardType: TextInputType.text,
                  validator: (input) => input.length < 6
                      ? "Password should be more than 6 characters"
                      : null,
                  obscureText: true,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0XFFE84201),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: Color(0XFF909090)),
                    focusColor: Colors.grey,
                    fillColor: Colors.white,
                    filled: true,
                    // focusColor: grey,
                    // hintText: "New Password",
                    // hintStyle: TextStyle(
                    //   color: grey,
                    // ),
                    prefixIcon: Icon(
                      Icons.lock,
                       color: isNewFocused
                          ? Color(0XFFE84201)
                          : Color(0XFF909090),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 19),
              child: Theme(
                data: ThemeData(primaryColor: grey),
                child: TextFormField(
                  cursorColor: Color(0XFF909090),
                  onChanged: (isFocussed) {
                    setState(() {
                      isConfirmFocused = isFocussed as bool;
                    });
                  },
                  controller: newpasswordv2controller,
                  keyboardType: TextInputType.text,
                  validator: (input) => input.length < 6
                      ? "Password should be more than 6 characters"
                      : null,
                  obscureText: true,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0XFFE84201),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    labelText: 'Confirm New Password',
                    labelStyle: TextStyle(color: Color(0XFF909090)),
                    focusColor: Colors.grey,
                    fillColor: Colors.white,
                    filled: true,
                    // focusColor: grey,
                    // hintText: "Confirm new Password",
                    // hintStyle: TextStyle(
                    //   color: grey,
                    // ),
                    prefixIcon: Icon(
                      Icons.lock,
                       color: isConfirmFocused
                          ? Color(0XFFE84201)
                          : Color(0XFF909090),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.00,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print(userpassword.password);
                    if (validateAndSave()) {
                      if (userpassword.password ==
                          currentpasswordcontroller.text) {
                        if (newpasswordcontroller.text ==
                            newpasswordv2controller.text) {
                          print("send password to api");
                          change.password = newpasswordcontroller.text;
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContextcontext) =>
                                      Myprofile()));
                          Flushbar(
                            message: "password Updated",
                            duration: Duration(seconds: 3),
                          )..show(context);
                          changepassword();
                          userpassword.password = newpasswordcontroller.text;
                          currentpasswordcontroller.clear();
                          newpasswordcontroller.clear();
                          newpasswordv2controller.clear();
                          removeValues();
                          print(userpassword.password);
                        } else {
                          Flushbar(
                            message: "password's didn't match",
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
                      } else {
                        Flushbar(
                          message: "current password was wrong",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 12),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFF88200), Color(0xFFE43700)]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.only(right: 10.00),
                      child: Center(
                          child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   height: MediaQuery.of(context).size.height * .39,
    //   decoration: const BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(20),
    //       topRight: Radius.circular(20),
    //     ),
    //   ),
    //   child: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.only(
    //                 left: 27,
    //                 top: 18,
    //               ),
    //               child: Text(
    //                 'Alert',
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(
    //                 right: 23,
    //                 top: 20,
    //               ),
    //               child: GestureDetector(
    //                   onTap: () {
    //                     print('Close Button Tapped');
    //                     Navigator.of(context).pop();
    //                   },
    //                   child: const Icon(
    //                     Icons.close,
    //                     size: 15,
    //                   )),
    //             ),
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 20,
    //         ),
    //         const Divider(
    //           thickness: 1,
    //           color: Color(0XFFC4C4C4),
    //         ),
    //         // SizedBox(
    //         //   height: 15,
    //         // ),
    //         Center(
    //           child: Container(
    //             height: 75,
    //             width: 90,
    //             child: Icon(
    //               Icons.warning_amber_rounded,
    //               size: 85,
    //               color: Color(0XFF909090),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),

    //         const SizedBox(
    //           height: 10,
    //         ),
    //         const Divider(
    //           thickness: 1,
    //         ),
    //         Center(
    //           child: const Padding(
    //             padding: EdgeInsets.only(
    //               left: 20,
    //               right: 20,
    //             ),
    //             child: Text(
    //                 'It seems that you are not at the customer location. Please try after reaching the customer location!!!'),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 27,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(
    //             left: 20,
    //             right: 20,
    //           ),
    //           child: GestureDetector(
    //             onTap: () {
    //               // isAllChecked
    //               //     ? print('All Checked')
    //               //     : print('All parameters are not checked');
    //             },
    //             child: GestureDetector(
    //               onTap: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Container(
    //                 height: 55,
    //                 width: MediaQuery.of(context).size.width,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(8),
    //                   gradient: LinearGradient(
    //                     begin: Alignment.topLeft,
    //                     end: Alignment.centerRight,
    //                     colors: [Color(0xFFF88200), Color(0xFFE43700)],
    //                   ),
    //                 ),
    //                 child: const Center(
    //                     child: Text(
    //                   'OK',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 )),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
