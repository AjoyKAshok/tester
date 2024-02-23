import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/Fieldmanager/Add Store.dart';
import 'package:merchandising/api/FMapi/storedetailsapi.dart';
import 'package:merchandising/api/FMapi/promotion_detailsapi.dart';
import 'package:merchandising/Fieldmanager/addpromotion.dart';
import 'package:merchandising/utils/background.dart';

class PromoDetailsUI extends StatefulWidget {
  @override
  _PromoDetailsUIState createState() => _PromoDetailsUIState();
}

class _PromoDetailsUIState extends State<PromoDetailsUI> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<dynamic> outletsdata;
  List<String> _filterList;
  List<String> _filterproductname;
  List<String> _filterfromdate;
  List<String> _filtertodate;
  List<String> _filterstorename;

  @override
  void initState() {
    super.initState();
    outletsdata = PromoData.storename;
    outletsdata.sort();
  }

  _PromoDetailsUIState() {
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
          iconTheme: IconThemeData(color: orange),
          title: Text(
            "Promo Details",
            style: TextStyle(color: orange),
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
                  // _createSearchView(),
                  // SizedBox(height: 10.0,),
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
            //                     AddPromotion()));
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
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(25.0)),
      child: new TextField(
        style: TextStyle(color: orange),
        controller: _searchview,
        cursorColor: orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          focusColor: orange,
          hintText: 'Search by Outlet name/Code',
          hintStyle: TextStyle(color: orange),
          border: InputBorder.none,
          icon: Icon(
            CupertinoIcons.search,
            color: orange,
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
          itemCount: PromoData.description.length,
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
                    // Text('Store Name : ${PromoData.storename[index]}',
                    //     style: TextStyle(
                    //         fontSize: 15.0,fontWeight: FontWeight.bold
                    //     )),
                    // SizedBox(height: 5),
                    Text("Product Name : ${PromoData.productname[index]}",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('From Date : ${PromoData.fromdate[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('To Date : ${PromoData.todate[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Description : ${PromoData.description[index]}',
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
    _filterproductname = [];
    _filterfromdate = [];
    _filtertodate = [];
    _filterstorename = [];

    for (int i = 0; i < PromoData.description.length; i++) {
      var item = PromoData.description[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
        int index = PromoData.description.indexOf(item);
        _filterproductname.add(PromoData.productname[index].toString());
        _filterfromdate.add(PromoData.fromdate[index].toString());
        _filtertodate.add(PromoData.todate[index]);
        _filterstorename.add(PromoData.storename[index].toString());
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
                    Text('Store Name : ${_filterstorename[index]}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Product Name : ${_filterproductname[index]}",
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Start Date : ${_filterfromdate[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('End Date : ${_filtertodate[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Description : ${_filterList[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                  ],
                ));
          }),
    );
  }
}
