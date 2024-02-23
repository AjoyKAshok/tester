import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'Customers Activities.dart';
import 'package:merchandising/utils/background.dart';

class CompetitionCheckTwo extends StatefulWidget {
  @override
  _CompetitionCheckTwoState createState() => _CompetitionCheckTwoState();
}

class _CompetitionCheckTwoState extends State<CompetitionCheckTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Row(
          children: [
            Text(
              'Competition Check',
              style: TextStyle(color: orange),
            ),
            Spacer(),
            SubmitButton(
              onpress: () {
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CustomerActivities()));
                }
              },
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
                OutletDetails(),
                Container(
                  width: 420,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8),
                              height: 40,
                              width: 415,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFF3E0),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TabBar(
                                labelColor: Colors.deepOrange,
                                unselectedLabelColor: Colors.black,
                                indicatorColor: Colors.deepOrange,
                                tabs: [
                                  Tab(text: 'PROMOTION'),
                                  Tab(text: 'VISIBILTY'),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 1,
                              width: double.infinity,
                              margin: EdgeInsets.all(10),
                              child: TabBarView(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: CompetionCheckOneTab(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                        child: Text(
                                      "Tab 2 Display",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

class CompetionCheckOneTab extends StatefulWidget {
  @override
  _CompetionCheckOneTabState createState() => _CompetionCheckOneTabState();
}

class _CompetionCheckOneTabState extends State<CompetionCheckOneTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 30,
              width: 130,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Color(0XFFF57C00),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: Center(
                  child: Text(
                "Competitor Info",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          width: 410,
          decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Company Name"),
              CompetionCheckOneDropDown(),
              Text("Brand Name"),
              CompetionCheckOneDropDown(),
              Text("Visibility Type"),
              CompetionCheckOneDropDown(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Capture Image"),
                  SizedBox(width: 200),
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.photo_camera_solid,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompetionCheckOneDropDown extends StatefulWidget {
  @override
  _CompetionCheckOneDropDownState createState() =>
      _CompetionCheckOneDropDownState();
}

class _CompetionCheckOneDropDownState extends State<CompetionCheckOneDropDown> {
  int dropDownValue = 0;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton(
        dropdownColor: Colors.white,
        value: dropDownValue,
        onChanged: (int newVal) {
          setState(() {
            dropDownValue = newVal;
          });
        },
        items: [
          DropdownMenuItem(
            value: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Text('Select Here'),
            ),
          ),
          DropdownMenuItem(
            value: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Text('Select Company'),
            ),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Select Brand'),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text('Select Visibility Type'),
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({@required this.onpress});

  final onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.only(right: 10.00),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xffFFDBC1),
          borderRadius: BorderRadius.circular(10.00),
        ),
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
