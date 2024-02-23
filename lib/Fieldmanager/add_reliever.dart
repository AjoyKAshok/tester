import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/Fieldmanager/product_details.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/FMapi/relieverdet_api.dart';
import 'package:merchandising/utils/background.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:merchandising/api/FMapi/outlet brand mappingapi.dart';
import 'package:merchandising/api/FMapi/add_promoapi.dart';

import 'package:merchandising/api/FMapi/promotion_detailsapi.dart';
import 'package:merchandising/Fieldmanager/products.dart';
import 'package:merchandising/api/FMapi/product_detailsapi.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:convert';
import 'dart:io';

List<String> receivedrelemp = [];
String SelectedRelemp;

class AddReliever extends StatefulWidget {
  @override
  _AddRelieverState createState() => _AddRelieverState();
}

String SelectedEmp;
String Res_Emp;

List<String> Empnamelist = merchnamelist.firstname;

class _AddRelieverState extends State<AddReliever> {
  TextEditingController reason = TextEditingController();
  GlobalKey<FormState> addreliever = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SelectedRelemp=null;
    SelectedEmp=null;
    receivedrelemp = [];

  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: containerscolor,
          iconTheme: IconThemeData(color: orange),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Reliever',
                style: TextStyle(color: orange),
              ),
              EmpInfo()
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
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: addreliever,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            child: SearchableDropdown.single(
                              underline: SizedBox(),
                              isExpanded: true,
                              iconEnabledColor: orange,
                              iconSize: 25.0,
                              value: SelectedEmp,
                              onChanged: (newVal) {
                                setState(() {
                                  SelectedEmp = newVal;
                                  print(newVal);
                                });
                              },
                              items: merchnamelist.firstname.map((String val) {
                                return new DropdownMenuItem<String>(
                                  value: val,
                                  child: new Text(val),
                                );
                              }).toList(),
                              hint: Text(
                                "Select Merchandiser",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          StartDate(),
                          EndDate(),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if(SelectedEmp!=null)
                                    {
                                      Res_Emp = "";
                                      final names = SelectedEmp;
                                      print(names + 'name');
                                      var parts = names.split('(');
                                      var prefix = "";
                                      if (parts != null) prefix = parts[1].trim();

                                      if (prefix != null && prefix.length > 0) {
                                        Res_Emp =
                                            prefix.substring(0, prefix.length - 1);
                                      }
                                      SearchReliever.empid = Res_Emp;
                                      // SearchReliever.empid = 'RMS${SelectedEmp.replaceAll(new RegExp(r'[^0-9]'), '')}';
                                      SearchReliever.from =
                                          Startdate.toString().substring(0, 10);
                                      SearchReliever.to =
                                          ENDdate.toString().substring(0, 10);

                                      setState(() {
                                        isApiCallProcess = true;
                                      });

                                      receivedrelemp = await searchreliever();
                                      print("Reliever Ava:${receivedrelemp}");

                                      if (receivedrelemp == null) {
                                        Flushbar(
                                          messageText: Text(
                                            "No Merchandisers Available",
                                            style: TextStyle(color: iconscolor),
                                          ),
                                          backgroundColor: pink,
                                          duration: Duration(seconds: 3),
                                        )..show(context);
                                      }

                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                    }
                                  else
                                    {
                                      Flushbar(
                                        message: SelectedEmp == null
                                            ? "Merchandiser cannot be empty":"",

                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }


                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: orange,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Search Reliever",
                                      style: TextStyle(color: pink),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          receivedrelemp != null
                              ? Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      width: double.infinity,
                                      child: SearchableDropdown.single(
                                        underline: SizedBox(),
                                        isExpanded: true,
                                        iconEnabledColor: orange,
                                        iconSize: 25.0,
                                        value: SelectedRelemp,
                                        onChanged: (newVal) {
                                          setState(() {
                                            SelectedRelemp = newVal;
                                          });
                                        },
                                        items: receivedrelemp.map((String val) {
                                          return new DropdownMenuItem<String>(
                                            value: val,
                                            child: new Text(val),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "Select Reliever Merchandiser",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, top: 10.0),
                                      padding: EdgeInsets.only(left: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        maxLines: 3,
                                        controller: reason,
                                        cursorColor: grey,
                                        // validator: (input) => !input.isNotEmpty
                                        //     ? "Reason Should not be empty"
                                        //     : null,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusColor: orange,
                                          hintText: "Reason*",
                                          hintStyle: TextStyle(
                                            color: grey,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (reason.text.trim().length<=0) {
                                            Flushbar(
                                              message:  "Reason cannot be empty",

                                              duration: Duration(seconds: 3),
                                            )..show(context);
                                          }
                                          else if(SelectedRelemp== null)
                                            {
                                              Flushbar(
                                                message:  "Please choose Reliever Merchandiser",

                                                duration: Duration(seconds: 3),
                                              )..show(context);
                                            }
                                          else {
                                            setState(() {
                                              isApiCallProcess = true;
                                            });
                                            AddrelieverData.empid =
                                            'RMS${SelectedEmp.replaceAll(
                                                new RegExp(r'[^0-9]'), '')}';
                                            AddrelieverData.relempid =
                                            'RMS${SelectedRelemp.replaceAll(
                                                new RegExp(r'[^0-9]'), '')}';
                                            AddrelieverData.from =
                                                Startdate.toString()
                                                    .substring(0, 10);
                                            AddrelieverData.to =
                                                ENDdate.toString()
                                                    .substring(0, 10);
                                            AddrelieverData.reason =
                                                reason.text;
                                            setState(() {
                                              isApiCallProcess = true;
                                            });

                                            await addrelieveremp();

                                            setState(() {
                                              isApiCallProcess = false;
                                            });


                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (
                                                        BuildContext context) =>
                                                        FieldManagerDashBoard()));

                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: orange,
                                            borderRadius:
                                                BorderRadius.circular(10.00),
                                          ),
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                color: pink, fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateform() {
    final form = addreliever.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

DateTime tomoroww = DateTime.now();

DateTime Startdate = DateTime.now();

class StartDate extends StatefulWidget {
  @override
  _StartDateState createState() => _StartDateState();
}

class _StartDateState extends State<StartDate> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: tomoroww,
      firstDate: tomoroww,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: orange,
              onPrimary: Colors.white,
              surface: orange,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != StartDate)
      setState(() {
        Startdate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Startdate = DateTime.now();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Text(
            "From Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${Startdate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}

DateTime ENDdate = DateTime.now().add(Duration(days: 1));

class EndDate extends StatefulWidget {
  @override
  _EndDateState createState() => _EndDateState();
}

class _EndDateState extends State<EndDate> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: tomoroww,
      firstDate: tomoroww,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: orange,
              onPrimary: Colors.white,
              surface: orange,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != EndDate)
      setState(() {
        ENDdate = picked;
      });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ENDdate = DateTime.now().add(Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Text(
            "To Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${ENDdate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}
