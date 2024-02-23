import 'package:flutter/material.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/clients/client_dashboard.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/HR/HRdashboard.dart';

import '../Merchandiser/merchandiserscreens/merchdash.dart';

class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: MediaQuery.of(context).size.height / 6,
            image: AssetImage('images/rmsLogo.png'),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Version : RMS$appversionnumber"),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              if (currentuser.roleid == 6) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MerchDash()));
              } else if (currentuser.roleid == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HRdashboard()));
              } else if (currentuser.roleid == 5 || currentuser.roleid == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            FieldManagerDashBoard()));
              }
              else if(currentuser.roleid==7)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ClientDB()));
                }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "DashBoard",
                    style: TextStyle(color: pink, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
