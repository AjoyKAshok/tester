import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/Fieldmanager/Add Store.dart';
import 'package:merchandising/api/FMapi/storedetailsapi.dart';
import 'package:merchandising/utils/background.dart';

class StoreDetails extends StatefulWidget {
  @override
  _StoreDetailsState createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<dynamic> outletsdata;
  List<String> _filterList;
  List<String> _filterCode;
  List<String> _filterContact;
  List<String> _filterAddress;

  @override
  void initState() {
    super.initState();
    outletsdata = storesdata.storename;
    outletsdata.sort();
  }

  _StoreDetailsState() {
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Store Details",
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
            //                     AddStores()));
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
          hintText: 'Search by Store Name/Code',
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
          key: UniqueKey(),
          shrinkWrap: true,
          itemCount: storesdata.storeaddress.length,
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
                    Text('Store Name : ${storesdata.storename[index]}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    //SizedBox(height: 5),
                    // Text("Store Code : ${storesdata.storecode[index]}",
                    //     style: TextStyle(
                    //       fontSize: 14.0,
                    //     )),
                    SizedBox(height: 5),
                    Text('Contact Number : ${storesdata.storecontnum[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Address : ${storesdata.storeaddress[index]}',
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
    _filterCode = [];
    _filterContact = [];
    _filterAddress = [];
    for (int i = 0; i < storesdata.storename.length; i++) {
      var item = storesdata.storename[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
        int index = storesdata.storename.indexOf(item);
        _filterCode.add(storesdata.storecode[index]);
        _filterContact.add(storesdata.storecontnum[index].toString());
        _filterAddress.add(storesdata.storeaddress[index]);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          key: UniqueKey(),
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
                    Text('Store Name : ${_filterList[index]}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    // SizedBox(height: 5),
                    // Text("Store Code : ${_filterCode[index]}",
                    //     style: TextStyle(
                    //       fontSize: 14.0,
                    //     )),
                    SizedBox(height: 5),
                    Text('Contact Number : ${_filterContact[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                    SizedBox(height: 5),
                    Text('Address : ${_filterAddress[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                  ],
                ));
          }),
    );
  }
}
