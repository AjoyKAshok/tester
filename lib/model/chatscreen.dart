import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/Fieldmanager/merchandiserslist.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Visibility.dart';
import 'package:merchandising/utils/background.dart';
import '../Merchandiser/merchandiserscreens/MenuContent.dart';
import '../ConstantMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/model/notifications.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:merchandising/api/FMapi/merchnamelistapi.dart';
import '../api/api_service2.dart';

class chat {
  static String receiver;
}

bool firstopen = true;
bool selected = false;
List<bool> selectedpeople;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController typedmsg = TextEditingController();
  String fmName;

  @override
  void initState() {
    super.initState();
    // fmName = fieldmanagerofcurrentmerch;
  }

  @override
  Widget build(BuildContext context) {
    fmName = fieldmanagernameofcurrentmerch;
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          centerTitle: false,
          // iconTheme: IconThemeData(color: orange),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Color(0XFF909090),
          ),
          title: Row(
            
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0XFFFFF2F5)),
                child: Icon(
                  Icons.chat_bubble_outline_outlined,
                  color: Color(0XFFF76F8D),
                ),
              ),
              SizedBox(width: 6 ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Field Manager',
                    style: TextStyle(color: Color(0XFF909090), fontSize: 14, fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    fmName,
                    style: TextStyle(color: Color(0XFF909090), fontSize: 12,),
                  ),
                  // EmpInfo()
                ],
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
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                '${DBrequestdata.receivedempid}.${chat.receiver}')
                            .orderBy('time', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            data.messages = [];
                            for (var message in snapshot.data.docs) {
                              final messagetext = message.get('text');
                              final messagesender = message.get('sender');
                              final time = message.get('time');
                              print("chatscreen : $ischatscreen");
                              if (ischatscreen == 0 &&
                                  firstopen == false &&
                                  messagesender !=
                                      '${DBrequestdata.receivedempid}') {
                                newmsgavaiable = true;
                                notification.add(
                                    'New message from $fieldmanagernameofcurrentmerch');
                                notitime.add(
                                    '${DateFormat("h:mma").format(DateTime.now())}');
                                notimsg.add(messagetext);
                              }
                              if (firstopen) {
                                firstopen = false;
                              }
                              ischatscreen == 0
                                  ? newmsgavaiable = true
                                  : newmsgavaiable = false;
                              final messageWidget = messagesender ==
                                      '${DBrequestdata.receivedempid}'
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            if (currentuser.roleid == 5) {
                                              print(messagetext);
                                            }
                                          },
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0, bottom: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Material(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0)),
                                                    elevation: 5.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        '$messagetext',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontSize: 16, color: Color(0XFF505050)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        8.0, 8.0, 8.0, 0),
                                                    child: Text(
                                                      DateFormat("h:mma")
                                                          .format(
                                                              DateTime.parse(
                                                                  time)),
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Color(0XFF909090)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            if (currentuser.roleid == 5) {
                                              selectedpeople = [];
                                              for (int i = 0;
                                                  i < merchnamelist.name.length;
                                                  i++) {
                                                selectedpeople.add(false);
                                              }
                                              print(messagetext);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (_) => StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  alertboxcolor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              content: Builder(
                                                                builder:
                                                                    (context) {
                                                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        'Forward Message',
                                                                        style: TextStyle(
                                                                            color:
                                                                                orange,
                                                                            fontSize:
                                                                                20),
                                                                      ),
                                                                      Divider(
                                                                        color: Colors
                                                                            .black,
                                                                        thickness:
                                                                            0.8,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            300,
                                                                        width:
                                                                            300,
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child: new ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: merchnamelist.name.length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width / 1.7,
                                                                                          child: Text(
                                                                                            merchnamelist.name[index],
                                                                                            style: TextStyle(fontSize: 16),
                                                                                            textAlign: TextAlign.start,
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            setState(() {
                                                                                              selectedpeople[index] == false ? selectedpeople[index] = true : selectedpeople[index] = false;
                                                                                            });
                                                                                          },
                                                                                          child: Icon(
                                                                                            selectedpeople[index] == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill,
                                                                                            color: selectedpeople[index] == true ? orange : Colors.grey,
                                                                                            size: 30,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              }),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          for (int i = 0;
                                                                              i < selectedpeople.length;
                                                                              i++) {
                                                                            if (selectedpeople[i]) {
                                                                              print(merchnamelist.employeeid[i]);
                                                                              var receiver = merchnamelist.employeeid[i];
                                                                              FirebaseFirestore.instance.collection('$receiver.${DBrequestdata.receivedempid}').add({
                                                                                'text': messagetext,
                                                                                'sender': '${DBrequestdata.receivedempid}',
                                                                                'time': '${DateTime.now()}',
                                                                              });
                                                                              await FirebaseFirestore.instance.collection('${DBrequestdata.receivedempid}.$receiver').add({
                                                                                'text': messagetext,
                                                                                'sender': '${DBrequestdata.receivedempid}',
                                                                                'time': '${DateTime.now()}',
                                                                              });
                                                                            }
                                                                          }
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              80,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                orange,
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          child:
                                                                              Center(child: Text('Forward', style: TextStyle(color: Colors.white))),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          }));
                                            }
                                          },
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, bottom: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Material(
                                                    color: selected
                                                        ? grey
                                                        : Colors.deepOrange[600],
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0)),
                                                    elevation: 5.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        '$messagetext',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontSize: 16, color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        8.0, 8.0, 8.0, 0),
                                                    child: Text(
                                                      DateFormat("h:mma")
                                                          .format(
                                                              DateTime.parse(
                                                                  time)),
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Color(0XFF909090)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                              data.messages.add(messageWidget);
                            }
                          }
                          return Expanded(
                            child: ListView(
                              reverse: true,
                              children: data.messages,
                            ),
                          );
                        }),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: orange),
                              controller: typedmsg,
                              cursorColor: orange,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                focusColor: orange,
                                hintText: 'Type your message here...',
                                hintStyle: TextStyle(color: Color(0XFF909090)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (typedmsg.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection(
                                        '${chat.receiver}.${DBrequestdata.receivedempid}')
                                    .add({
                                  'text': typedmsg.text,
                                  'sender': '${DBrequestdata.receivedempid}',
                                  'time': '${DateTime.now()}',
                                });
                                await FirebaseFirestore.instance
                                    .collection(
                                        '${DBrequestdata.receivedempid}.${chat.receiver}')
                                    .add({
                                  'text': typedmsg.text,
                                  'sender': '${DBrequestdata.receivedempid}',
                                  'time': '${DateTime.now()}',
                                });
                                typedmsg.clear();
                              }
                            },
                            child: Icon(
                              Icons.send,
                              color: Color(0XFF909090),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: double.infinity,
                //   margin: EdgeInsets.all(10.0),
                //   padding: EdgeInsets.fromLTRB(20.0, 10, 10.0, 10.0),
                //   decoration: BoxDecoration(
                //     color: pink,
                //     borderRadius: BorderRadius.circular(100.0),
                //   ),
                //   child: Text(
                //     'TO : $fieldmanagernameofcurrentmerch',
                //     style: TextStyle(fontSize: 16, color: orange),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class data {
  static List<Row> messages;
}
