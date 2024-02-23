import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/clientapi/outletreport.dart';
import 'package:merchandising/clients/reports.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/competition_details.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/api/clientapi/stockexpirydetailes.dart';
import 'package:merchandising/api/clientapi/clientpromodetailes.dart';
import 'package:merchandising/main.dart';
import 'package:merchandising/utils/background.dart';

import '../api/api_service2.dart';

bool isApiCallProcess = false;

class ClientOutletsdata extends StatefulWidget {
  @override
  _ClientOutletsdataState createState() => _ClientOutletsdataState();
}

class _ClientOutletsdataState extends State<ClientOutletsdata> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";

  List<int> _filterindex;

  _ClientOutletsdataState() {
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

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: pink,
            iconTheme: IconThemeData(color: orange),
            title: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Addedstockdataforclient();
                    },
                    child: Text(
                      currentuser.roleid == 7 ? "Outlet Details" : "Reports",
                      style: TextStyle(color: orange),
                    )),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: pink, borderRadius: BorderRadius.circular(100.0)),
      child: new TextField(
        style: TextStyle(color: orange),
        controller: _searchview,
        cursorColor: orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          focusColor: orange,
          hintText: 'Search by Outlet',
          hintStyle: TextStyle(color: orange),
          border: InputBorder.none,
          icon: Icon(
            CupertinoIcons.search,
            color: orange,
          ),
          suffixIcon: IconButton(
            onPressed: () {
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
          itemCount: ClientOutlets.outletname.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () async {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  indexclientselected = index;
                  currentoutletid = ClientOutlets.outletid[index];
                  currenttimesheetid = ClientOutlets.timesheetid[index];
                  print(
                      "current TSid for Report------->${currenttimesheetid}...${currentoutletid}");
                  await FMViewOTDet();
                  await getAvaiablitity();
                  // await getVisibility();
                  // await getCompetition();
                  await getPlanogramDetails();
                  // await getShareofshelf();
                  await Addedstockdataforclient();
                  // await getCompetition();
                  // await clientPromoData();
                  setState(() {
                    isApiCallProcess = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContextcontext) => ClientsReports()));
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
                        Text(
                            '${ClientOutlets.outletname[index].toString().replaceAll(",", "")} - ${ClientOutlets.storeCode[index]}',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                            'Date : ${ClientOutlets.lastvisiteddate[index].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Visit Type : ${ClientOutlets.isschedulevisit[index].toString() == "1" ? "Scheduled" : "UnScheduled"}'),
                        SizedBox(height: 5),
                        Text(
                            'CheckIn Time : ${ClientOutlets.checkintime[index].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'CheckOut Time : ${ClientOutlets.checkouttime[index].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Visited By : ${ClientOutlets.merchandiserid[index].toString()}'),
                      ],
                    )));
          }),
    );
  }

  Widget _performSearch() {
    _filterindex = [];
    for (int i = 0; i < ClientOutlets.outletname.length; i++) {
      var item = ClientOutlets.outletname[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterindex.add(i);
      }

      var item1 = ClientOutlets.storeCode[i];
      if (item1 != null) {
        if (item1.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
          _filterindex.add(i);
        }
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _filterindex.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () async {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  indexclientselected = _filterindex[index];
                  currentoutletid = ClientOutlets.outletid[_filterindex[index]];
                  currenttimesheetid =
                      ClientOutlets.timesheetid[_filterindex[index]];
                  print(
                      "current TSid for Report------->${currenttimesheetid}...${currentoutletid}");

                  await FMViewOTDet();
                  await getAvaiablitity();
                  // await getVisibility();
                  // await getCompetition();
                  await getPlanogramDetails();
                  // await getShareofshelf();
                  await Addedstockdataforclient();
                  // await getCompetition();
                  // await clientPromoData();
                  setState(() {
                    isApiCallProcess = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContextcontext) => ClientsReports()));
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
                        Text(
                            '${ClientOutlets.outletname[_filterindex[index]]} - ${ClientOutlets.storeCode[_filterindex[index]]}',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                            'Date : ${ClientOutlets.lastvisiteddate[_filterindex[index]].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Visit Type : ${ClientOutlets.isschedulevisit[_filterindex[index]].toString() == "1" ? "Scheduled" : "UnScheduled"}'),
                        SizedBox(height: 5),
                        Text(
                            'Checkin time : ${ClientOutlets.checkintime[_filterindex[index]].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Checkout time : ${ClientOutlets.checkouttime[_filterindex[index]].toString()}'),
                        SizedBox(height: 5),
                        Text(
                            'Visited by : ${ClientOutlets.merchandiserid[_filterindex[index]].toString()}'),
                      ],
                    )));
          }),
    );
  }
}
