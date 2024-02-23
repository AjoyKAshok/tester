import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/Fieldmanager/Add Store.dart';
import 'package:merchandising/api/FMapi/storedetailsapi.dart';
import 'package:merchandising/api/FMapi/relieverdet_api.dart';
import 'package:merchandising/Fieldmanager/add_reliever.dart';
import 'package:merchandising/utils/background.dart';

class RelieverDetails extends StatefulWidget {
  @override
  _RelieverDetailsState createState() => _RelieverDetailsState();
}

class _RelieverDetailsState extends State<RelieverDetails> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<dynamic> outletsdata;
  List<String> _filterList;
  List<String> _filterrelemp;
  List<String> _filterfrom;
  List<String> _filterto;
  List<String> _filterreason;

  @override
  void initState() {
    super.initState();
    outletsdata = Relieverdetdata.emp;
    // outletsdata.sort();
  }

  _RelieverDetailsState() {
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
          backgroundColor: pink,
          centerTitle: true,
          iconTheme: IconThemeData(color: orange),
          title: Column(
            children: [
              Text(
                "Reliever Details",
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
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AddReliever()));
                  },
                  backgroundColor: pink,
                  elevation: 8.0,
                  child: Icon(
                    Icons.add,
                    color: orange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(left: 20.0),
      width: double.infinity,
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(25.0)),
      child: new TextField(
        style: TextStyle(color: orange),
        controller: _searchview,
        cursorColor: orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          focusColor: orange,
          hintText: 'Search by Empid/Emp Name',
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
          // key: UniqueKey(),
          shrinkWrap: true,
          itemCount: Relieverdetdata.emp.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${Relieverdetdata.emp[index].toString().replaceAll("null", "")}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('Reliever Employee : ${Relieverdetdata.relemp[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('From : ${Relieverdetdata.fromdate[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('To : ${Relieverdetdata.todate[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Reason : ${Relieverdetdata.reason[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                  ],
                ));
          }),
    );
  }

  Widget _performSearch() {
    _filterList = [];
    _filterrelemp = [];
    _filterfrom = [];
    _filterto = [];
    _filterreason = [];
    for (int i = 0; i < Relieverdetdata.emp.length; i++) {
      var item = Relieverdetdata.emp[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterList.add(item);
        int index = Relieverdetdata.emp.indexOf(item);
        _filterrelemp.add(Relieverdetdata.relemp[index]);
        _filterfrom.add(Relieverdetdata.fromdate[index].toString());
        _filterto.add(Relieverdetdata.todate[index]);
        _filterreason.add(Relieverdetdata.reason[index]);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          // key: UniqueKey(),
          shrinkWrap: true,
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Employee : ${_filterList[index]}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('Reliever Employee: ${_filterrelemp[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('From : ${_filterfrom[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('To : ${_filterto[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Reason : ${_filterreason[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                  ],
                ));
          }),
    );
  }
}
