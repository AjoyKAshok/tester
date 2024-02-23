import 'package:flutter/material.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/clients/clientoutlet_details.dart';
import '../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/merchandiserdashboard.dart';
import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:enough_mail/smtp/smtp_exception.dart';
import 'package:merchandising/utils/background.dart';
import '../../api/api_service2.dart';

String userName = 'ramananv@thethoughtfactory.ae';
String password = 'rv13@ttf';
String domain = 'thethoughtfactory.ae';
bool isPopServerSecure = true;
String smtpServerHost = 'mail.$domain';
int smtpServerPort = 587;
bool isSmtpServerSecure = false;

List<String> sharelog = [];

class VLogs extends StatefulWidget {
  @override
  _VLogsState createState() => _VLogsState();
}

class _VLogsState extends State<VLogs> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      opacity: 0.3,
      inAsyncCall: isApiCallProcess,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          iconTheme: IconThemeData(color: orange),
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log Details",
                    style: TextStyle(color: orange),
                  ),
                  EmpInfo()
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  sharelog = [];
                  for (int i = 0; i < logreportstatus.length; i++) {
                    sharelog.add(
                        "${logreport[i]}-on-${logtime[i]}-status-${logreportstatus[i]}\n");
                  }
                  await smtpExample(
                      'Log details for empid ${DBrequestdata.receivedempid}');
                  setState(() {
                    isApiCallProcess = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.00),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffFFDBC1),
                    borderRadius: BorderRadius.circular(10.00),
                  ),
                  child: Text(
                    'Share',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            BackGround(),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(color: pink,borderRadius: BorderRadius.circular(10)),
                  //   margin: EdgeInsets.fromLTRB(5.0,10,5.0,10.0),
                  //   padding: EdgeInsets.all(10.0),
                  //
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left:10.0),
                  //         child: Text("OnTap",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: orange),),
                  //       ),
                  //
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10.0),
                  //         child: Text("Time",style: TextStyle(fontSize:16.0,fontWeight: FontWeight.bold,color: orange),),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: logreportstatus.length,
                          reverse: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${logreport[index]}",
                                    softWrap: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Success : ${logreportstatus[index]}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spacer(),
                                        Text(
                                          logtime[index],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: Divider(
                                            thickness: 0.5,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> smtpExample(body) async {
  print(".......");
  final client = SmtpClient('thethoughtfactory.ae', isLogEnabled: true);
  print(".......:${client}");

  try {
    await client.connectToServer(smtpServerHost, smtpServerPort,
        isSecure: isSmtpServerSecure);
    try {
      await client.ehlo();
    } on HandshakeException catch (e) {
      print(e);
    }

    print(".......");
    if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
      try {
        await client.authenticate(userName, password, AuthMechanism.plain);
        print("..............");
      } catch (e) {
        print('SMTP failed with $e');
      }
      print('plain');
    } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
      await client.authenticate(userName, password, AuthMechanism.login);
      print('login');
    } else {
      return;
    }
    final builder = MessageBuilder.prepareMultipartAlternativeMessage();
    builder.from = [MailAddress('My name', 'ramananv@thethoughtfactory.ae')];
    builder.to = [MailAddress('Your name', 'vilvaroja@gmail.com')];
    builder.subject = body;
    builder.addTextPlain(sharelog.toString());
    // builder.addTextHtml('<p>hello <b>world</b></p>');
    final mimeMessage = builder.buildMimeMessage();
    final sendResponse = await client.sendMessage(mimeMessage);
    print('message sent: ${sendResponse.isOkStatus}');
  } on SmtpException catch (e) {
    print('SMTP failed with $e');
  }
}
