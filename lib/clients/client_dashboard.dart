import 'package:merchandising/api/empdetailsapi.dart';
import 'package:merchandising/clients/FM_list.dart';
import 'package:merchandising/clients/clientoutlet_details.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/utils/background.dart';

import '../api/api_service2.dart';

class ClientDB extends StatefulWidget {
  @override
  _ClientDBState createState() => _ClientDBState();
}

class _ClientDBState extends State<ClientDB> {
  void initState() {
    if (fromloginscreen) {
      Future.delayed(const Duration(seconds: 2), () {
        showDialog(
            context: context,
            builder: (_) => StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor: pink, //alertboxcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Builder(
                      builder: (context) {
                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              greetingMessage(),
                              style: TextStyle(color: orange, fontSize: 20),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Text(
                              "Wish you have a great day ahead 😀",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DBrequestdata.empname,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: orange, fontSize: 14),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Image(
                                  height: 30,
                                  image: AssetImage('images/rmsLogo.png'),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  );
                }));
      });
      fromloginscreen = false;
    }
    //super.initState();
  }

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: pink,
            iconTheme: IconThemeData(color: orange),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: 30,
                  image: AssetImage('images/rmsLogo.png'),
                ),
                EmpInfo()
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
                    SizedBox(
                      height: 10,
                    ),
                    // GestureDetector(
                    //   onTap: () async{
                    //
                    //
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    //     height: 181,
                    //     width: double.infinity,
                    //     padding: EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       color: containerscolor,
                    //     ),
                    //     child: SingleChildScrollView(
                    //       child: Column(
                    //         children: [
                    //           Text("Performance Indicator", style: TextStyle(
                    //               fontSize: 16),),
                    //           SizedBox(height: 10,),
                    //           Table(
                    //             border: TableBorder.symmetric(
                    //               inside: BorderSide(color: Colors.grey),
                    //             ),
                    //             columnWidths: {
                    //               0: FractionColumnWidth(.35),
                    //             },
                    //             children: [
                    //               TableRow(
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(top: 14.0),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "Merchandisers",
                    //                         style: TextStyle(fontSize: 12),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Total",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Present",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Absent",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               TableRow(
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(top: 14.0),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "Total Outlets",
                    //                         style: TextStyle(fontSize: 12),
                    //                         textAlign: TextAlign.center,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Total",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Completed",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Pending",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               TableRow(
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(top: 14.0),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "Today Outlets",
                    //                         style: TextStyle(fontSize: 12),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Total",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Completed",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Column(
                    //                       mainAxisAlignment: MainAxisAlignment
                    //                           .spaceEvenly,
                    //                       children: [
                    //
                    //                         Text(
                    //                           "Pending",
                    //                           style: TextStyle(fontSize: 10),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: containerscolor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.shopping_cart,
                                      size: 35,
                                      color: iconscolor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Stores',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ClientOutletsdata()));
                          },
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: containerscolor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.building_2_fill,
                                      size: 35,
                                      color: iconscolor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Outlets',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: containerscolor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.bus,
                                      size: 35,
                                      color: iconscolor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Journey Plan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FieldManagersList()));
                          },
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: containerscolor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_chart,
                                      size: 35,
                                      color: iconscolor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Time Sheet',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: containerscolor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.barcode,
                                      size: 35,
                                      color: iconscolor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Products',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 3.2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: containerscolor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Reports',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 125,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width / 1.03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: containerscolor,
                      ),
                      child: Row(
                        children: [
                          Spacer(
                            flex: 2,
                          ),
                          Icon(
                            CupertinoIcons.sun_max,
                            color: Colors.black,
                            size: 50,
                          ),
                          Spacer(flex: 2),
                          Text(
                            'Welcome to the new Client interface\nof RMS. '
                            'Hope to have a great day ahead!',
                            style: new TextStyle(fontSize: 15),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      // setState(() {
                      //   isApiCallProcess = true;
                      // });
                      // await getmerchnamelist();
                      // setState(() {
                      //   isApiCallProcess = false;
                    },
                    backgroundColor: orange,
                    elevation: 10.0,
                    child: Icon(
                      CupertinoIcons.chat_bubble_2_fill,
                      color: pink,
                    ),
                  ),
                ),
              ),
              ClientNBL()
            ],
          ),
        ),
      ),
    );
  }
}

/**/

// TimeSheetdatadaily.timeid = currenttimesheetid;
// print('timesheet id : ${TimeSheetdatadaily.timeid}');
// setState(() {
//   isApiCallProcess = true;
// });
// await getTimeSheetdaily();
//
// setState(() {
//   isApiCallProcess = false;
// });

bool convenience = false;

bool hyperscarrefour = false;

bool expresscarrefour = false;

bool superandcoops = false;

bool luluhyperandexpress = false;

class ClientNBL extends StatefulWidget {
  @override
  _ClientNBLState createState() => _ClientNBLState();
}

class _ClientNBLState extends State<ClientNBL> {
  Offset count = Offset(20.0, 20.0);
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: count.dx,
        top: count.dy,
        child: Draggable(
            feedback: Container(
                child: FloatingActionButton(
              onPressed: () {},
              child: Text(
                "NBL",
                style: TextStyle(color: pink),
              ),
              backgroundColor: grey,
            )),
            child: FloatingActionButton(
              child: Text(
                "NBL",
                style: TextStyle(color: pink),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder:
                        (_) => StatefulBuilder(builder: (context, setState) {
                              return AlertDialog(
                                backgroundColor: alertboxcolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                content: Builder(
                                  builder: (context) {
                                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      //margin: EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'NBL',
                                                  style: TextStyle(
                                                      color: orange,
                                                      fontSize: 20),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                return ProgressHUD(
                                                                  inAsyncCall:
                                                                      isApiCallProcess,
                                                                  opacity: 0.3,
                                                                  child:
                                                                      AlertDialog(
                                                                    backgroundColor:
                                                                        alertboxcolor,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.0))),
                                                                    content:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Text(
                                                                              'Select NBL',
                                                                              style: TextStyle(color: orange, fontSize: 20),
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.black,
                                                                              thickness: 0.8,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  convenience = true;
                                                                                  hyperscarrefour = false;
                                                                                  expresscarrefour = false;
                                                                                  superandcoops = false;
                                                                                  luluhyperandexpress = false;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Text(
                                                                                        'UAE Convenience',
                                                                                        style: TextStyle(fontSize: 16),
                                                                                      ),
                                                                                      Spacer(),
                                                                                      Icon(
                                                                                        convenience == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill,
                                                                                        color: convenience == true ? orange : Colors.grey,
                                                                                        size: 30,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  convenience = false;
                                                                                  hyperscarrefour = true;
                                                                                  expresscarrefour = false;
                                                                                  superandcoops = false;
                                                                                  luluhyperandexpress = false;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Text('Hypers Carrefour', style: TextStyle(fontSize: 16)),
                                                                                      Spacer(),
                                                                                      Icon(hyperscarrefour == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill, color: hyperscarrefour == true ? orange : Colors.grey, size: 30),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  convenience = false;
                                                                                  hyperscarrefour = false;
                                                                                  expresscarrefour = true;
                                                                                  superandcoops = false;
                                                                                  luluhyperandexpress = false;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Text('Express Carrefour', style: TextStyle(fontSize: 16)),
                                                                                      Spacer(),
                                                                                      Icon(expresscarrefour == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill, color: expresscarrefour == true ? orange : Colors.grey, size: 30),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  convenience = false;
                                                                                  hyperscarrefour = false;
                                                                                  expresscarrefour = false;
                                                                                  superandcoops = true;
                                                                                  luluhyperandexpress = false;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Text('Supers & Coops', style: TextStyle(fontSize: 16)),
                                                                                      Spacer(),
                                                                                      Icon(superandcoops == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill, color: superandcoops == true ? orange : Colors.grey, size: 30),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  convenience = false;
                                                                                  hyperscarrefour = false;
                                                                                  expresscarrefour = false;
                                                                                  superandcoops = false;
                                                                                  luluhyperandexpress = true;
                                                                                });
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Text('Lulu Hypers & Express', style: TextStyle(fontSize: 16)),
                                                                                      Spacer(),
                                                                                      Icon(luluhyperandexpress == true ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill, color: luluhyperandexpress == true ? orange : Colors.grey, size: 30),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  if (convenience) {
                                                                                    nblfile = "https://test.rhapsody.ae/nbl_file/1624532995.P7 2021 UAE Premium Supers Canvas.pdf";
                                                                                  }
                                                                                  if (hyperscarrefour) {
                                                                                    nblfile = "https://test.rhapsody.ae/nbl_file/1623766927.P5 2021 UAE Carrefour Hypers Canvas.pdf";
                                                                                  }
                                                                                  if (expresscarrefour) {
                                                                                    nblfile = "https://test.rhapsody.ae/nbl_file/1624527112.P5 2020 UAE Carrefour Express Canvas (1).pdf";
                                                                                  }
                                                                                  if (superandcoops) {
                                                                                    nblfile = "https://test.rhapsody.ae/nbl_file/1624513945.P5 2021 UAE Supers & Coops.pdf";
                                                                                  }
                                                                                  if (luluhyperandexpress) {
                                                                                    nblfile = "https://test.rhapsody.ae/nbl_file/1624724674.P5 2021 UAE Lulu Hypers & Express Canvas.pdf";
                                                                                  }
                                                                                });

                                                                                print(nblfile);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                height: 30,
                                                                                width: 70,
                                                                                decoration: BoxDecoration(
                                                                                  color: orange,
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: Center(child: Text('ok', style: TextStyle(color: Colors.white))),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              }));

                                                      //Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.filter,
                                                        color: orange,
                                                        size: 25)),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 0.8,
                                            ),
                                            loaded
                                                ? SizedBox()
                                                : Text("Loadiing..."),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }));
              },
              backgroundColor: orange,
            ),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              setState(() {
                count = details.offset;
              });
            }));
  }

  bool loaded = false;
}
