import 'package:flutter/material.dart';
import 'package:merchandising/api/api_service.dart';

class PerformanceIndicators extends StatefulWidget {
  final valSelected;

  PerformanceIndicators(
    this.valSelected,
  );

  @override
  State<PerformanceIndicators> createState() => _PerformanceIndicatorsState();
}

class _PerformanceIndicatorsState extends State<PerformanceIndicators> {
  String selectedValue;

  String uCount;
  @override
  void initState() {
    super.initState();
    setState(() {
      uCount = widget.valSelected;
    print('The User Count is : $uCount');
    });
    // print('Selected Value : $selectedValue');
  }

  // String getUserCount(selectedValue) {
  //   selectedValue == 'MTB'
  //       ? setState(() {
  //           uCount = '${DBResponsedatamonthly.shedulevisits}';
  //           print('MTB User Count : $uCount');
  //         })
  //       : setState(() {
  //           uCount = '${DBResponsedatadaily.shedulevisits}';
  //           print('Today User Count : $uCount');
  //         });

  //   return uCount;
  // }

  // String userCount = uCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 208,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 11),
                  child: Row(
                    children: [
                      Expanded(
                        child: makeDashboardItem('Scheduled Visits', uCount,
                            Icons.phone, 0XFFF76F8D, 0XFFFFC6D3),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: makeDashboardItem('Unscheduled Visits', '47',
                            Icons.warning, 0XFF1EC2C1, 0XFF77F4F4),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 11),
                  child: Row(
                    children: [
                      Expanded(
                        child: makeDashboardItem('Scheduled Visits Done', '81',
                            Icons.call_made_outlined, 0XFF5589EA, 0XFF5589EA),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: makeDashboardItem(
                            'Unscheduled Visits Done',
                            '19',
                            Icons.call_made_outlined,
                            0XFFF4B947,
                            0XFFF9B636),
                      ),
                    ],
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
    String userCount,
    IconData icon,
    int colorCode,
    int subColorCode,
  ) {
    // String countUser;
    // countUser = getUserCount(selectedValue);
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
                      userCount,
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
