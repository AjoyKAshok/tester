import 'package:flutter/material.dart';
import '../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'MenuContent.dart';
import 'Customers Activities.dart';
import 'package:merchandising/utils/background.dart';

class PlanogramCheckPhase3 extends StatefulWidget {
  @override
  _PlanogramCheckPhase3State createState() => _PlanogramCheckPhase3State();
}

class _PlanogramCheckPhase3State extends State<PlanogramCheckPhase3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Row(
          children: [
            Text(
              'Planogram Check',
              style: TextStyle(color: orange),
            ),
            Spacer(),
            SubmitButton(),
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
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 40,
                  padding: EdgeInsets.all(10.00),
                  decoration: BoxDecoration(
                      color: pink, borderRadius: BorderRadius.circular(10.0)),
                  child: Expanded(
                    child: Theme(
                      data: ThemeData(primaryColor: orange),
                      child: TextField(
                        cursorColor: orange,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.black,
                          hintText: 'Search by Customer Code/Name',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  padding: EdgeInsets.all(8.0),
                  height: 50,
                  width: 415,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Item Code & Description",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      Spacer(flex: 2),
                      Text(
                        "Qty",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      Spacer(flex: 1),
                      Text(
                        "Expiry Date",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                CustomPlanogramThree(
                  containercolor: Color(0xFFFFF3E0),
                  text1: "[534725]",
                  text2: "Tang Orange Instant Drink Mix 500Gm",
                ),
                CustomPlanogramThree(
                    containercolor: Colors.white,
                    text1: "[534578]",
                    text2: " Tang Orange Instant Drink Mix 750Gm"),
                CustomPlanogramThree(
                  containercolor: Color(0xFFFFF3E0),
                  text1: "  [534714]",
                  text2: "Tang Orange Instant Drink Mix  1 Kg",
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: CustomPlanogramThree(
                    containercolor: Colors.white,
                    text1: " [534757]",
                    text2: " Tang Lemon Instant Drink Mix 500Gm",
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

class CustomPlanogramThree extends StatelessWidget {
  CustomPlanogramThree({this.text1, this.text2, this.containercolor});

  final text1;
  final text2;
  final containercolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containercolor,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 70,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 175.0),
                child: Text(
                  text1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                text2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(flex: 2),
          Text(
            "5",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(flex: 1),
          Text(
            "26-12-2020",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CustomerActivities()));
      },
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
