import 'package:flutter/material.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/noti_detapi.dart';
import 'package:merchandising/login_page.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/utils/background.dart';

bool isApicallProcess = false;

List<String> notification = [];
List<String> notimsg = [];
List<String> notitime = [];

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Row(
          children: [
            Text(
              'Notifications',
              style: TextStyle(color: orange),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: Stack(
        children: [
          BackGround(),
          ListView.builder(
              itemCount: notification.length == 0 ? 0 : 1,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                            Flexible(
                              child: Text(
                                '${notification[0]}',
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(notimsg[0]),
                            Text(notitime[0]),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

class NotificationDetails extends StatefulWidget {
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      opacity: 0.3,
      inAsyncCall: isApicallProcess,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: containerscolor,
          iconTheme: IconThemeData(color: orange),
          title: Row(
            children: [
              Text(
                'Notifications',
                style: TextStyle(color: orange),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  for (int i = 0; i < NotiDetData.title.length; i++) {
                    NotiViewedAll.notid.add(NotiDetData.id[i]);
                  }
                  setState(() {
                    isApicallProcess = true;
                  });

                  await notiviewall();

                  setState(() {
                    isApicallProcess = false;
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              FieldManagerDashBoard()));
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Viewed All",
                      style: TextStyle(fontSize: 16.0),
                    )),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Menu(),
        ),
        body: Stack(
          children: [
            BackGround(),
            Container(
              margin: EdgeInsets.all(10.0),
              child: ListView.builder(
                  key: UniqueKey(),
                  shrinkWrap: true,
                  itemCount: NotiDetData.title.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' ${NotiDetData.title[index]}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text(' ${NotiDetData.date[index]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    )),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        changecoloricon[index] = true;
                                      });

                                      NotificationViewed.id =
                                          NotiDetData.id[index];
                                      print(NotificationViewed.id);

                                      setState(() {
                                        isApicallProcess = true;
                                      });

                                      await notificationviewed();

                                      setState(() {
                                        isApicallProcess = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: changecoloricon[index] == true
                                          ? Colors.green
                                          : Colors.black54,
                                    )),
                              ],
                            ),
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
