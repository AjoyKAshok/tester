import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'package:merchandising/utils/background.dart';

class HQTwo extends StatefulWidget {
  @override
  _HQTwoState createState() => _HQTwoState();
}

class _HQTwoState extends State<HQTwo> {
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Month Target Details",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "25-March-2019, 18.03",
                          style: TextStyle(
                            color: orange,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh eu- "
                          "ismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim"
                          "veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea "
                          "commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit "
                          "esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et ac- "
                          "cumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis "
                          "dolore te feugait nulla facilisi."
                          "\nLorem ipsum dolor sit amet, cons ectetuer adipiscing elit,sed diam nonummy nibh eu-"
                          "ismod tincidunt ut laoreet dolore magna aliquam erat volutpat.Ut wisi enim ad minim "
                          "veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea"
                          "commodo consequat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed "
                          "diam nonummy nibh eu- ismod tincidunt ut laoreet dolore magna aliquam erat volutpat. "
                          "Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis"
                          "nisl ut aliquip ex ea commodo consequat. "
                          "\nLorem ipsum dolor sit amet, cons ectetuer adipiscing elit, sed diam nonummy nibh "
                          "euismod tincidunt ut laoreet dolore magna aliquam erat volut- pat. Ut wisi enim ad minim "
                          "veniam, quis nostrud exerci tation ullamcorper suscipit lob- ortis nisl ut aliquip ex ea "
                          "commodo consequat.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed"
                          "diam nonummy nibh eu- ismod tincidunt ut laoreet dolore magna aliquam erat volutpat. "
                          "Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis"
                          "nisl ut aliquip ex ea commodo consequat. ,",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Type your text here",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.attach_file), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.send, color: orange),
                          onPressed: () {}),
                    ],
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
