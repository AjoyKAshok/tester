import 'package:flutter/material.dart';
import 'package:merchandising/Constants.dart';
import 'package:merchandising/utils/background.dart';


class TimeSheetDetail extends StatefulWidget {
  static const routeName = '/TimeSheetDetails';
  TimeSheetDetail();

  @override
  State<TimeSheetDetail> createState() => _TimeSheetDetailState();
}

class _TimeSheetDetailState extends State<TimeSheetDetail> {
  bool isYearToDateSelected = true;
  bool isMonthToDateSelected = false;
  bool isTodaySelected = false;
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
          'Time Sheet',
          style: TextStyle(
            color: Color(0XFF909090),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Stack(
        children: [
          const BackGround(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 34,
                      right: 34,
                      top: 21,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Color(0XFF909090),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Roja Ramanan',
                                style: TextStyle(
                                  color: Color(0XFF505050),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 144,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Merchandiser Id',
                                style: TextStyle(
                                  color: Color(0XFF909090),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Emp7325',
                                style: TextStyle(
                                  color: Color(0XFF505050),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 15,
                    right: 20,
                  ),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isYearToDateSelected = true;
                                      isMonthToDateSelected = false;
                                      isTodaySelected = false;
                                    });
                                  },
                                  child: Text(
                                    'Year to Date',
                                    style: TextStyle(
                                      color: isYearToDateSelected
                                          ? Color(0XFFE84201)
                                          : Color(0XFF909090),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 80,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: isYearToDateSelected == true
                                      ? const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                              Color(0xFFF88200),
                                              Color(0xFFE43700)
                                            ])
                                      : const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                              Color(0xFFFFFFFF),
                                              Color(0xFFFFFFFF)
                                            ]),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isYearToDateSelected = false;
                                      isMonthToDateSelected = true;
                                      isTodaySelected = false;
                                    });
                                    // Navigator.of(context).pushReplacementNamed(
                                    //     YetToVisitStores.routeName);
                                  },
                                  child: Text(
                                    'Month to Date',
                                    style: TextStyle(
                                      color: isMonthToDateSelected
                                          ? Color(0XFFE84201)
                                          : Color(0XFF909090),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 80,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: isMonthToDateSelected == true
                                      ? const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                              Color(0xFFF88200),
                                              Color(0xFFE43700)
                                            ])
                                      : const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                              Color(0xFFFFFFFF),
                                              Color(0xFFFFFFFF)
                                            ]),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isYearToDateSelected = false;
                                      isMonthToDateSelected = false;
                                      isTodaySelected = true;
                                    });
                                  },
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                      color: isTodaySelected
                                          ? Color(0XFFE84201)
                                          : Color(0XFF909090),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 80,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: isTodaySelected == true
                                      ? const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                              Color(0xFFF88200),
                                              Color(0xFFE43700)
                                            ])
                                      : const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                              Color(0xFFFFFFFF),
                                              Color(0xFFFFFFFF)
                                            ]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                     
                    ),
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.only(left: 20, right: 20.0),
                   child: Container(
                    height: MediaQuery.of(context).size.height,
                     child: Column(
                       children: [
                         SizedBox(
                        height: 9,
                      ),
                         Flexible(
                           child: ListView.builder(
                                    itemCount: 6,
                                    itemBuilder: (context, int index) {
                                      return timeCard(
                                        index,
                                        timeData[index].displayDate,
                                        timeData[index].outletName,
                                        timeData[index].checkInTime,
                                        timeData[index].checkOutTime,
                                      );
                                    }),
                         ),
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

  Widget timeCard(
    int index,
    String displayDate,
    String outletName,
    String checkInTime,
    String checkOutTime,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 106,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 14,
            top: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${timeData[index].displayDate}'),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Outlet',),
                      Text(outletName),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check In',),
                      Text(checkInTime),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Check Out',),
                        Text(checkOutTime),
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
