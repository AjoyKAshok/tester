import 'package:flutter/material.dart';
import 'package:merchandising/utils/background.dart';

import '../../Constants.dart';


class LeaveStatus extends StatefulWidget {
  static const routeName = '/LeaveStatus';
  LeaveStatus();

  @override
  State<LeaveStatus> createState() => _LeaveStatusState();
}

class _LeaveStatusState extends State<LeaveStatus> {
  int rejectedColorCode = 0XFFE43700;
  int acceptedColorCode = 0XFF00984F;
  int pendingColorCode = 0XFFFFB017;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Color(0XFF909090),
        ),
        title: const Text(
          'Leave Status',
          style: TextStyle(
            color: Color(0XFF909090),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFFE43700),
        onPressed: () {},
        child: Icon(Icons.add, size: 40,),
      ),
      body: Stack(
        children: [
          BackGround(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, int index) {
                            return leaveCard(
                                index,
                                leave[index].leaveReason,
                                leave[index].leaveFromDate,
                                leave[index].leaveToDate,
                                leave[index].leaveType,
                                leave[index].leaveStatus,
                                leave[index].leaveStatus == 'Rejected'
                                    ? rejectedColorCode
                                    : leave[index].leaveStatus == 'Accepted'
                                        ? acceptedColorCode
                                        : pendingColorCode);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveCard(
    int index,
    String leaveReason,
    String leaveFromDate,
    String leaveToDate,
    String leaveType,
    String leaveStatus,
    int colorCode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 106,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 14,
            top: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reason: ${leave[index].leaveReason}'),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Color(colorCode),
                  ),
                  Text(leaveFromDate),
                  SizedBox(
                    width: 3,
                  ),
                  Text('To'),
                  SizedBox(
                    width: 3,
                  ),
                  Text(leaveToDate),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Leave Type'),
                      Text(leaveType),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Column(
                      children: [
                        Text('Status'),
                        Text(leaveStatus, style: TextStyle(color: Color(colorCode),),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
