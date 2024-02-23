import 'package:flutter/material.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/utils/background.dart';


class NotificationsPage extends StatefulWidget {
  static const routeName = '/Notifications';
  NotificationsPage();

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool unreadNotification = true;
  bool readNotification;
  @override
  void initState() {
    super.initState();
    readNotification = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Color(0XFF909090),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0XFF909090),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Stack(
        children: [
          BackGround(),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 9,
                        ),
                        Flexible(
                          child: ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, int index) {
                                return notificationCard(
                                  index,
                                  notifications[index].displayName,
                                  notifications[index].subject,
                                  notifications[index].shortDescription,
                                  notifications[index].notificationTime,
                                  notifications[index].unreadNotification,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationCard(
    int index,
    String displayName,
    String subject,
    String shortDescription,
    String notificationTime,
    bool unreadNotification,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            notifications[index].unreadNotification = false;
            unreadNotification = notifications[index].unreadNotification;
            print('Clicked on Notification');
          });
          print(unreadNotification);
        },
        child: Container(
          height: 106,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color:
                unreadNotification == true ? Color(0XFFEDFAFE) : Colors.white,
            // color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 14,
              top: 14,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 310,
                    top: 5,
                    right: 10,
                  ),
                  child: Container(
                    height: 6,
                    width: 6,
                    color: unreadNotification == true
                        ? Color(0XFFEE0000)
                        : Colors.white,
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: index % 4 == 0
                                ? Color(0XFFF76F8D)
                                : index % 4 == 1
                                    ? Color(0XFF1EC2C1)
                                    : index % 4 == 2
                                        ? Color(0XFF5589EA)
                                        : Color(0XFFF4B947),
                          ),
                          child: Center(
                              child: Text(
                            displayName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            shortDescription,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 290, bottom: 9),
                  child: Text(notificationTime),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
