import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/api/holidays.dart';
import 'package:merchandising/api/HRapi/addholiday.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';
import 'dart:async';
import 'package:merchandising/utils/background.dart';

class HoliDays extends StatefulWidget {
  @override
  _HoliDaysState createState() => _HoliDaysState();
}

class _HoliDaysState extends State<HoliDays> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        iconTheme: IconThemeData(color: orange),
        title: Text(
          "HoliDays",
          style: TextStyle(color: orange),
        ),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: Stack(
        children: [
          BackGround(),
          ListView.builder(
              itemCount: holidays.dates.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date :',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${holidays.dates[index]}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Description :',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${holidays.description[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          currentuser.roleid == 3
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AddHoliday()));
                      },
                      backgroundColor: pink,
                      elevation: 8.0,
                      child: Icon(
                        Icons.add,
                        color: orange,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class AddHoliday extends StatefulWidget {
  @override
  _AddHolidayState createState() => _AddHolidayState();
}

class _AddHolidayState extends State<AddHoliday> {
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        iconTheme: IconThemeData(color: orange),
        title: Text(
          "Add Holiday",
          style: TextStyle(color: orange),
        ),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: Stack(
        children: [
          BackGround(),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: pink,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StartDate(),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: descriptioncontroller,
                          cursorColor: grey,
                          decoration: new InputDecoration(
                            focusColor: grey,
                            hintText: "Type your Description here",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      addholidays.description = descriptioncontroller.text;
                      addholiday();
                      Flushbar(
                        messageText: Text(
                          "Holiday has been added",
                          style: TextStyle(color: iconscolor),
                        ),
                        backgroundColor: pink,
                        duration: Duration(seconds: 3),
                      )..show(context);

                      Timer(Duration(seconds: 4), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HRdashboard()));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Add Holiday'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StartDate extends StatefulWidget {
  @override
  _StartDateState createState() => _StartDateState();
}

class _StartDateState extends State<StartDate> {
  // ignore: non_constant_identifier_names
  DateTime StartDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: StartDate,
      firstDate: DateTime(2015, 8),
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
        StartDate = picked;
        addholidays.date = DateFormat("yyyy-MM-dd").format(StartDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Select Date",
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        Text(
          "${StartDate.toLocal()}".split(' ')[0],
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(CupertinoIcons.calendar),
          onPressed: () => _selectDate(context),
        ),
      ],
    );
  }
}
