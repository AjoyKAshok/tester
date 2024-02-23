import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/utils/background.dart';

import '../ConstantMethods.dart';
import '../ProgressHUD.dart';

class AddNotification extends StatefulWidget {
  // AddNotification({Key? key}) : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> addnotification = GlobalKey<FormState>();
  bool isApiCallProcess = false;
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
            children: [
              Text(
                'Add Notification',
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
                      key: addnotification,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                            padding: EdgeInsets.only(left: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.white,
                            ),
                            child: TextFormField(
                              maxLines: 3,
                              controller: description,
                              cursorColor: grey,
                              // validator: (input) => !input.isNotEmpty
                              //     ? "Description not be empty"
                              //     : null,
                              decoration: new InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusColor: orange,
                                hintText: "Description",
                                fillColor: Colors.white,
                                filled: true,
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
    // 
    if(description.text.trim().length<=0)
      {
      Flushbar(
      message: "Notification should not be empty",
      duration: Duration(seconds: 3),
      )..show(context);

      }
    else
    {

      setState(() {
      isApiCallProcess = true;
      });

    
    // AddPromo.description = description.text;
    // await addpromodetails();

    setState(() {
    isApiCallProcess = false;
    });
      Navigator.pop(context);
    Flushbar(
    message: "Notification has been added",
    duration: Duration(seconds: 3),
    )..show(context);

    
    }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(10.00),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
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
    final form = addnotification.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

