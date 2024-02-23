import 'package:flutter/material.dart';
import 'SurveyTwo.dart';
import 'MenuContent.dart';
import '../../ConstantMethods.dart';
import 'package:merchandising/utils/background.dart';

class SurveyOne extends StatefulWidget {
  @override
  _SurveyOneState createState() => _SurveyOneState();
}

class _SurveyOneState extends State<SurveyOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Row(
          children: [
            Text(
              'Survey One',
              style: TextStyle(color: orange),
            ),
            Spacer(),
            SubmitButton(
              onpress: () {
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SurveyTwo()));
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
                  padding: EdgeInsets.all(10.00),
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      SurveyOneCheckBox(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  height: 290,
                  width: 420,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2.Option Selection Survey",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SurveyOneRadioButton(),
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

class SurveyOneRadioButton extends StatefulWidget {
  @override
  RadioButtonWidget createState() => RadioButtonWidget();
}

class RadioButtonWidget extends State {
  String radioItem = '';

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile(
          groupValue: radioItem,
          title: Text(
            'Survey Answer 1',
          ),
          value: 'survey 1',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text(
            'Survey Answer 2',
          ),
          value: 'survey 2',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text(
            'Survey Answer 3',
          ),
          value: 'survey 3',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          groupValue: radioItem,
          title: Text(
            'Survey Answer 4',
          ),
          value: 'survey 4',
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        Text(
          '$radioItem',
          style: TextStyle(fontSize: 0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class SurveyOneCheckBox extends StatefulWidget {
  @override
  _SurveyOneCheckBoxState createState() => _SurveyOneCheckBoxState();
}

class _SurveyOneCheckBoxState extends State<SurveyOneCheckBox> {
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;
  bool valuefourth = false;
  bool valuefifth = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("1.MultiSelection Survey",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: orange,
                      value: this.valuefirst,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefirst = value;
                        });
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuesecond = value;
                        });
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      value: this.valuethird,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuethird = value;
                        });
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      value: this.valuefourth,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefourth = value;
                        });
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      value: this.valuefifth,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefifth = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 260,
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Survey Answer 1',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Survey Answer 2',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Survey Answer 3',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Survey Answer 4',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Survey Answer 5',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
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
}
