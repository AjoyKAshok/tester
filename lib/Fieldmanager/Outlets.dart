import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'addoutlets.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/FMapi/addoutletapi.dart';
import 'package:merchandising/Fieldmanager/addoutlets.dart';
import 'package:merchandising/utils/background.dart';

bool isApiCallProcess = false;

class Oulets extends StatefulWidget {
  @override
  _OuletsState createState() => _OuletsState();
}

class _OuletsState extends State<Oulets> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";

  List<String> _filterList;
  List<String> _filterArea;
  List<String> _filterLat;
  List<String> _filterLong;
  List<String> _filterCity;
  List<String> _filterState;
  List<String> _filterCountry;
  List<String> _filterCode;
  List<String> _filterContactnum;
  List<String> _filterLocation;
  List<int> _filteroutletid;

  _OuletsState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: pink,
          iconTheme: IconThemeData(color: orange),
          title: Column(
            children: [
              Text(
                "Outlet Details",
                style: TextStyle(color: orange),
              ),
              EmpInfo()
            ],
          ),
        ),
        // drawer: Drawer(
        //   child: Menu(),
        // ),
        body: Stack(
          children: [
            BackGround(),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10, 10, 0),
              child: new Column(
                children: <Widget>[
                  _createSearchView(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _firstSearch ? _createListView() : _performSearch(),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Container(
            //     margin: EdgeInsets.all(15.0),
            //     child: FloatingActionButton(
            //       onPressed: (){
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (BuildContext
            //                 context) =>
            //                     AddOutlets()));
            //       },
            //       backgroundColor: pink,
            //       elevation: 8.0,
            //       child: Icon(Icons.add,color: orange,),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(left: 20.0),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: pink, borderRadius: BorderRadius.circular(100.0)),
      child: new TextField(

        style: TextStyle(color: orange),
        controller: _searchview,
        cursorColor: orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          focusColor: orange,
          hintText: 'Search by Outlet Name/Code',
          hintStyle: TextStyle(color: orange),
          border: InputBorder.none,
          icon: Icon(

            CupertinoIcons.search,

            color: orange,
          ),
          suffixIcon: IconButton(
            onPressed: (){
              _searchview.clear();
            },
            icon: Icon(
              CupertinoIcons.clear_circled_solid,
              color: orange,
            ),
          ),
          isCollapsed: true,
        ),
      ),
    );
  }

  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: outletdata.outletname.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onLongPress: () {
                  updateoutlet.outletid = outletdata.outletid[index];

                  updatingoutlet.outletname ='[${outletdata.code[index]}] ${outletdata.outletname[index]}';
                   updatingoutlet.name = outletdata.outletname[index];

                updatingoutlet.area = outletdata.outletarea[index];

            updatingoutlet.city =outletdata.outletcity[index];
            updatingoutlet.state = outletdata.outletstate[index];
            updatingoutlet.country = outletdata.outletcountry[index];
            updatingoutlet.lat = outletdata.outletlat[index];
            updatingoutlet.long = outletdata.outletlong[index];


                  print(updateoutlet.outletid);
                  showDialog(
                      context: context,
                      builder: (_) =>
                          StatefulBuilder(builder: (context, setState) {
                            return ProgressHUD(
                                inAsyncCall: isApiCallProcess,
                                opacity: 0.3,
                                child: AlertDialog(
                                  backgroundColor: alertboxcolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  content: Builder(
                                    builder: (context) {
                                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                      return Container(
                                        child: SizedBox(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Alert",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 15.00,
                                              ),
                                              Text(
                                                  "Do you want to edit this outlet details?",
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              SizedBox(
                                                height: 25.00,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        isApiCallProcess = true;
                                                      });
                                                      updateoutlet.outletedit =
                                                          true;
                                                      // await getupdatingoutletdata();
                                                      setState(() {
                                                        isApiCallProcess =
                                                            false;
                                                      });
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AddOutlets()));
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                        color: orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          right: 10.00),
                                                      child: Center(
                                                          child: Text("yes")),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ));
                          }));
                },
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${outletdata.outletname[index]}',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('${outletdata.address[index]}'),
                        SizedBox(height: 5),
                        Text(
                            'Latitude : ${outletdata.outletlat[index].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Longitude : ${outletdata.outletlong[index].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Contact Number : ${outletdata.contactnumber[index].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Location : ${outletdata.outletarea[index]},${outletdata.outletcity[index]},${outletdata.outletstate[index]},${outletdata.outletcountry[index]}',
                            style: TextStyle(
                              fontSize: 14.0,
                            )),
                      ],
                    )));
          }),
    );
  }

  Widget _performSearch() {
    _filterList = [];
    _filterArea = [];
    _filterLat = [];
    _filterLong = [];
    _filterContactnum = [];
    _filteroutletid = [];
    _filterCity = [];
    _filterState = [];
    _filterCountry = [];
    _filterCode=[];

    _filterLocation = [];
    for (int i = 0; i < outletdata.outletname.length; i++) {
      var item = outletdata.outletname[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterList.add(item);
        int index = outletdata.outletname.indexOf(item);
        _filterArea.add(outletdata.address[index]);
        _filteroutletid.add(outletdata.outletid[index]);
        _filterLat.add(outletdata.outletlat[index]);
        _filterLong.add(outletdata.outletlong[index]);
        _filterCode.add(outletdata.code[index]);
        _filterCity.add(outletdata.outletcity[index]);
        _filterState.add(outletdata.outletstate[index]);
        _filterCountry.add(outletdata.outletcountry[index]);
        _filterContactnum.add(outletdata.contactnumber[index].toString());
        _filterLocation.add(
          '${outletdata.outletarea[index]},${outletdata.outletcity[index]},${outletdata.outletstate[index]},${outletdata.outletcountry[index]}',
        );
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () {
                updateoutlet.outletid = _filteroutletid[index];

                updatingoutlet.outletname ='[${_filterCode[index]}] ${_filterList[index]}';
                updatingoutlet.name = _filterList[index];

                updatingoutlet.area = _filterArea[index];

                updatingoutlet.city =_filterCity[index];
                updatingoutlet.state = _filterState[index];
                updatingoutlet.country = _filterCountry[index];
                updatingoutlet.lat = _filterLat[index];
                updatingoutlet.long = _filterLong[index];

                print(updateoutlet.outletid);
                showDialog(
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, setState) {
                          return ProgressHUD(
                              inAsyncCall: isApiCallProcess,
                              opacity: 0.3,
                              child: AlertDialog(
                                backgroundColor: alertboxcolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                content: Builder(
                                  builder: (context) {
                                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                    return Container(
                                      child: SizedBox(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Alert",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 15.00,
                                            ),
                                            Text(
                                                "Do you want to edit this outlet details?",
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 25.00,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      isApiCallProcess = true;
                                                    });
                                                    updateoutlet.outletedit =
                                                        true;
                                                    // await getupdatingoutletdata();
                                                    setState(() {
                                                      isApiCallProcess = false;
                                                    });
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AddOutlets()));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.00),
                                                    child: Center(
                                                        child: Text("yes")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ));
                        }));
              },
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_filterList[index]}',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('${_filterArea[index]}'),
                      SizedBox(height: 5),
                      Text('Latitude : ${_filterLat[index].toString()}'),
                      SizedBox(height: 5),
                      Text('Longitude : ${_filterLong[index].toString()}'),
                      SizedBox(height: 5),
                      Text(
                          'Contact Number : ${_filterContactnum[index].toString()}'),
                      SizedBox(height: 5),
                      Text('Location : ${_filterLocation[index]}',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ],
                  )),
            );
          }),
    );
  }
}
