import 'package:flutter/material.dart';

class TravelPlan extends StatefulWidget {
  TravelPlan();

  @override
  State<TravelPlan> createState() => _TravelPlanState();
}

class _TravelPlanState extends State<TravelPlan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
                  padding: EdgeInsets.only(                    
                    bottom: 12,
                    left: 20,
                  ),
                  child: Text('Travel Plan'),
                ),
        Padding(
          padding: const EdgeInsets.only(left: 21, right: 19),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 136,
            decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10,),
                  child: Container(
                    height: 116,
                    width: MediaQuery.of(context).size.width * .41,
                    decoration: BoxDecoration(
                      color: Color(0XFFFAFAFA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text('Completion'),
                        SizedBox(
                          height: 11,
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          child: Stack(
                            fit: StackFit.expand,
                            children: const [
                            CircularProgressIndicator(
                              value: 0.4,
                              backgroundColor: Color(0XFFEAECF0),
                              strokeWidth: 6,
                              
                            ),
                            Center(
                              child: Text('40%', style: TextStyle(fontSize: 12,),),
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10,right: 10),
                  child: Container(
                    height: 116,
                    width: MediaQuery.of(context).size.width * .41,
                    decoration: BoxDecoration(
                      color: Color(0XFFFAFAFA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text('Process'),
                        SizedBox(
                          height: 11,
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          child: Stack(
                            fit: StackFit.expand,
                            children: const [
                            CircularProgressIndicator(
                              value: 0.75,
                              color: Color(0XFFF4B947),
                              backgroundColor: Color(0XFFEAECF0),
                              strokeWidth: 6,
                              
                            ),
                            Center(
                              child: Text('75%', style: TextStyle(fontSize: 12,),),
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container makeDashboardItem(
    String title,
    String users,
    IconData icon,
    int colorCode,
    int subColorCode,
  ) {
    return Container(
      height: 95,
      width: 162,
      decoration: BoxDecoration(
        color: Color(colorCode),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          var _value = title;
          if (_value == 'Scheduled Visits') {
            // Navigator.of(context).pushNamed(ClientList.routeName);
          } else if (_value == 'Unscheduled Visits') {
          } else if (_value == "Scheduled Visits Done") {
          } else if (_value == 'Unscheduled Visits Done') {}
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      color: Color(subColorCode),
                      height: 26,
                      width: 26,
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 5,
                    ),
                    child: Text(
                      users,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 15,
                ),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
