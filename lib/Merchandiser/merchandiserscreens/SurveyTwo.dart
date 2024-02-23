import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'Customers Activities.dart';
import 'package:merchandising/utils/background.dart';

class SurveyTwo extends StatefulWidget {
  @override
  _SurveyTwoState createState() => _SurveyTwoState();
}

class _SurveyTwoState extends State<SurveyTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Row(
          children: [
            Text(
              'Survey Two',
              style: TextStyle(color: orange),
            ),
            Spacer(),
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
                  margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  padding: EdgeInsets.all(8.0),
                  height: 150,
                  width: 420,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: SurveyTwoCheckBox(),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  height: 120,
                  width: 420,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "4.Multiline Survey",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  padding: EdgeInsets.only(left: 10, top: 10),
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "5.Single Line Survey",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      SurveyTwoDropDown(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  padding: EdgeInsets.all(8.0),
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "6.Image Survey",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.photo_camera_solid,
                              size: 50,
                            ),
                          ),
                          Spacer(flex: 3),
                          Text("Image Description",
                              style: TextStyle(color: Colors.grey[500])),
                          Spacer(flex: 2),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  padding: EdgeInsets.only(left: 10, top: 10),
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "7.Rating Survey",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Spacer(flex: 1),
                          //StarDisplay(),
                          Spacer(flex: 15),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  padding: EdgeInsets.all(8.0),
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "8.Video Survey",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.videocam_circle,
                              size: 60,
                            ),
                          ),
                          Spacer(flex: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Video Description",
                                style: TextStyle(color: Colors.grey[500])),
                          ),
                          Spacer(flex: 2),
                        ],
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

class SurveyTwoCheckBox extends StatefulWidget {
  @override
  _SurveyTwoCheckBoxState createState() => _SurveyTwoCheckBoxState();
}

class _SurveyTwoCheckBoxState extends State<SurveyTwoCheckBox> {
  bool valuefirst = false;
  bool valuesecond = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text("3.Yes or No Survey",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      checkColor: Colors.greenAccent,
                      activeColor: orange,
                      value: this.valuefirst,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefirst = value;
                          this.valuefirst = true;
                          this.valuesecond = false;
                        });
                      },
                    ),
                  ),
                  Text("Yes"),
                ],
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      checkColor: Colors.greenAccent,
                      activeColor: orange,
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuesecond = value;
                          this.valuesecond = true;
                          this.valuefirst = false;
                        });
                      },
                    ),
                  ),
                  Text("No"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SurveyTwoDropDown extends StatefulWidget {
  @override
  _SurveyTwoDropDownState createState() => _SurveyTwoDropDownState();
}

class _SurveyTwoDropDownState extends State<SurveyTwoDropDown> {
  int dropDownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text('Select Survey 1'),
            ),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('Select Survey 2'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Select Survey 3'),
          ),
        ],
      ),
    );
  }
}

/*class StarDisplay extends StatefulWidget {
  @override
  _StarDisplayState createState() => _StarDisplayState();
}

class _StarDisplayState extends State<StarDisplay> {
  double rating = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothStarRating(
          allowHalfRating:false,
          onRatingChanged:(value){
            setState(() {
              rating= value;
            });
          },
          starCount:5,
          rating: rating,
            size: 25.0,
            color: Color(0xfffdd835),
          borderColor:Color(0xfffdd835),
          spacing: 0.0,
        )
      ],
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
}*/
