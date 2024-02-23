import 'package:flutter/material.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'package:merchandising/utils/background.dart';

class HQThree extends StatefulWidget {
  @override
  _HQThreeState createState() => _HQThreeState();
}

class _HQThreeState extends State<HQThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Row(
          children: [
            Text(
              'HQ Communication',
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
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Container(
                    height: 540,
                    width: 420,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 10, 300, 8),
                          child: Text(
                            "Subject",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 228),
                          child: Text(
                            "   Month Target Details",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 6, 2, 10),
                          decoration: BoxDecoration(color: Colors.grey[700]),
                          height: 0.8,
                          width: 385,
                        ),
                        Container(
                          width: 370,
                          height: 400,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextField(
                                maxLines: 15,
                                decoration: InputDecoration.collapsed(
                                    hintText: "type your message here..."),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            print("send button");
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xfff57c00),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text(
                                "SEND",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
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
}

class Raised extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {},
        child: Text("SEND"),
      ),
    );
  }
}
