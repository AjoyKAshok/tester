import 'package:flutter/material.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/leavestatus.dart';
import 'package:merchandising/utils/hqcommunication.dart';

class ActivityPerformance extends StatefulWidget {
  ActivityPerformance();

  @override
  State<ActivityPerformance> createState() => _ActivityPerformanceState();
}

class _ActivityPerformanceState extends State<ActivityPerformance> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 12.0,
            bottom: 12,
            left: 20,
          ),
          child: Text('Activity Performance'),
        ),
        Container(
          height: 208,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 19),
                  child: Container(
                    height: 108,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Container(
                                height: 8,
                                width: 8,
                                color: Color(0XFF1EC2C1),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Primary',
                                style: TextStyle(
                                  color: Color(0XFF909090),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 19,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Container(
                                height: 8,
                                width: 8,
                                color: Color(0XFFEAECF0),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Secondary',
                                style: TextStyle(
                                  color: Color(0XFF909090),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 11),
                          child: Text(
                            'Planned',
                            style: TextStyle(
                              color: Color(0XFF909090),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: LinearProgressIndicator(
                              value: 0.54,
                              backgroundColor: Color(0xffeaecf0),
                              color: Color(0XFF1EC2C1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 11),
                          child: Text(
                            'Actual',
                            style: TextStyle(
                              color: Color(0XFF909090),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: LinearProgressIndicator(
                              value: 0.74,
                              backgroundColor: Color(0xffeaecf0),
                              color: Color(0XFF1EC2C1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 21,
                      ),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 21.0,
                          ),
                          child: makeDashboardItem('Available Leaves', '24',
                              Icons.person, 0XFFE84201, 0XFFFFF3EE),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 17,
                      ),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 21.0,
                          ),
                          child: makeDashboardItem('HQ Communication', '24',
                              Icons.chat_rounded, 0XFFE84201, 0XFFFFF3EE),
                        ),
                      ),
                    ),
                  ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          var _value = title;
          if (_value == 'Available Leaves') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (buildContext) => LeaveStatus()));
          } else if (_value == 'HQ Communication') {
           Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (buildContext) => HQCommunication()));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
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
                        color: Color(colorCode),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      users,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
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
                  // style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
