import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';

//import 'file:///C:/Users/ramkumar/StudioProjects/RHAPSODY-MERCHANDISING-SERVICES/lib/model/chatscreen.dart';
import 'package:merchandising/model/chatscreen.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/utils/background.dart';
import 'allEmployeechatscreen.dart';

// import 'package:merchandising/model/goupchatscreen.dart';
class ChatUsersformerch extends StatefulWidget {
  @override
  _ChatUsersformerchState createState() => _ChatUsersformerchState();
}

class _ChatUsersformerchState extends State<ChatUsersformerch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        centerTitle: false,
        // iconTheme: IconThemeData(color: orange),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Color(0XFF909090),
        ),
        title: Column(
          children: [
            Text(
              "HQ Communication",
              style: TextStyle(color: Color(0XFF909090)),
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                  //  Navigator.of(context).pushNamed(ChatScreen.routeName);
                  },
                  child: chatContainer(
                    'RMS Team',
                    'All',
                    0XFFF76F8D,
                    0XFF1EC2C1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    // print('Clicked on 1st');
                  },
                  child: chatContainer(
                    'Field Manager',
                    'Sailesh Bhandari',
                    0XFFF76F8D,
                    0XFF1EC2C1,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             // ignore: non_constant_identifier_names
              //             builder: (BuildContextcontext) => AllChatScreen()));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20, right: 20.0, top: 25),
              //     child: Container(
              //         padding: EdgeInsets.all(10.0),
              //         margin: EdgeInsets.fromLTRB(10.0, 0, 10, 10),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.all(Radius.circular(10))),
              //         width: double.infinity,
              //         child: Row(
              //           children: [
              //             Icon(Icons.chat_bubble_outline_sharp),
              //             SizedBox(width: 6),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text('Rhapsody Merchandising Services',
              //                     style: TextStyle(fontSize: 16.0, color: Colors.black)),
              //                 SizedBox(
              //                   height: 5,
              //                 ),
              //                 Row(
              //                   children: [
              //                     Icon(Icons.group_sharp),
              //                     SizedBox(width: 5),
              //                     Text('All',
              //                         style: TextStyle(fontSize: 14.0, color: grey)),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ],
              //         )),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       ischatscreen = 1;
              //       newmsgavaiable = false;
              //       chat.receiver = fieldmanagerofcurrentmerch;
              //     });
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (BuildContext context) => ChatScreen()));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              //     child: Container(
              //         padding: EdgeInsets.all(10.0),
              //         margin: EdgeInsets.fromLTRB(10.0, 0, 10, 10),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.all(Radius.circular(10))),
              //         width: double.infinity,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text('Field Manager',
              //                 style: TextStyle(fontSize: 16.0, color: Colors.black)),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text('participants : $fieldmanagernameofcurrentmerch',
              //                 style: TextStyle(fontSize: 14.0, color: grey)),
              //           ],
              //         )),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chatContainer(
    String title,
    String memberName,
    int arrowColorCode,
    int iconColorCode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 108,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            var _value = title;
            if(_value == 'RMS Team') {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          // ignore: non_constant_identifier_names
                          builder: (BuildContextcontext) => AllChatScreen()));
            }
            else {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ChatScreen()));
            }
          },
          // child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 15,
                ),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                    color: Color(0XFFFFF2F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 36,
                    color: Color(0XFFF76F8D),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.group_sharp),
                        Text(memberName),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .30,
              ),
              Icon(Icons.arrow_forward_ios_outlined, color: Color(0XFFE84201)),
            ],
          ),

          // ),
        ),
      ),
    );
  }
}
