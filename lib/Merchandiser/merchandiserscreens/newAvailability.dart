//import 'dart:ffi';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merchandising/network/NetworkStatusService.dart';
import 'package:merchandising/utils/background.dart';
import 'package:provider/provider.dart';
import '../../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import '../../../ProgressHUD.dart';
import 'MenuContent.dart';
import 'package:merchandising/api/customer_activites_api/add_availabilityapi.dart';
import 'Customers Activities.dart';
import 'package:merchandising/api/api_service.dart';

import 'newCustomerActivities.dart';

List<String> selectedList = [];
String Selectedtype = "SKU";

String selecttype;
bool ontapavailrefreshNew = false;
List<int> shuffledchecklist = Avaiablity.checkvalue;
List<String> shuffledreasons = Avaiablity.reason;
List<String> categories = Distintcategory;
List<String> Brands = Distintbrands;
String SelectedcategoryNew;
String SelectedbrandNew;
List<String> defaulflistNew = Avaiablity.fullname;
List<String> filteredList = [];

class NewAvailabilityScreen extends StatefulWidget {
  @override
  _NewAvailabilityScreenState createState() => _NewAvailabilityScreenState();
}

class _NewAvailabilityScreenState extends State<NewAvailabilityScreen> {
  /*@override
   Void initState() {
    super.initState();
    bool value =  shuffledchecklist[defaulflistNew.indexOf(widget.item)] == 1 ? false:true;
   // bool value = outofStockitems.contains(widget.item) == true ? true : false;
    setState(() {
      isSwitched = value;
    });
  }*/

  List<bool> isSelected;
  TextEditingController _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<String> _filterList;
  List<String> InputList = defaulflistNew;
  int reasonChecked = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode focusNode = FocusNode();
  String hintText = 'Search by Product Name / ZREP code';

  @override
  _NewAvailabilityScreenState() {
    print("from _AvailabilityScreenState");
  }

  @override
  void dispose() {
    _searchview.dispose();
    super.dispose();
  }

  bool isApiCallProcess = false;
  bool connection = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAvailabilityValues();

    /* _searchview.addListener(() {
      if (_searchview.text.trim().isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
        print("empty");
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });*/
  }
  /// MODIFIED defaulflistNew to defaulflistNew, SelectedcategoryNew to SelectedcategoryNew and SelectedbrandNew to SelectedbrandNew.

  loadAvailabilityValues() async {
    print("seleccted cat..$SelectedcategoryNew");
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          hintText = '';
        });
      } else {
        setState(() {
          hintText = 'Search by Product Name / ZREP code';
        });
      }
    });

    setState(() {
      ontapavailrefreshNew = true;
      isApiCallProcess = true;
    });

    await getAvaiablitity();
    setState(() {
      defaulflistNew = Avaiablity.fullname;
      InputList = defaulflistNew;
      print("defaulflistNew lenght...${defaulflistNew.length}");
      print("InputList lenght...${InputList.length}");
      print("checkValue lenght...${Avaiablity.checkvalue.length}");

      SelectedcategoryNew = null;
      SelectedbrandNew = null;
      isApiCallProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<NetworkStatusService>(context);

    if (networkStatus.online == true) {
      setState(() {
        connection = true;
      });
    } else {
      setState(() {
        connection = false;
      });

      print("conection from availablity...$connection");
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: containerscolor,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: orange),
          leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NewCustomerActivities()));
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Color(0XFF909090),
                  ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isApiCallProcess = true;
                    _searchview.clear();
                  });
                  Future.delayed(Duration(seconds: 4), () {
                    setState(() {
                      isApiCallProcess = false;
                    });
                  });
                },
                child: Text(
                  'Out of Stock',
                  style: TextStyle(color: orange),
                ),
              ),
              Spacer(),
              /*IconButton(
                  onPressed: () async {
                    ontapavailrefresh = true;
                    setState(() {
                      isApiCallProcess = true;
                    });
                    await getAvaiablitity();
                    print("InputList.length...${InputList.length}");
                    print("availablity.length...${Avaiablity.fullname.length}");
                    print("availablity.product...${Avaiablity.productname.length}");
                    print("defaulflistNew.product...${defaulflistNew.length}");
                    setState(() {

                      InputList = Avaiablity.fullname;
                      print("InputList.length...${InputList.length}");
                      isApiCallProcess = false;
                    });
                  },
                  icon: Icon(CupertinoIcons.refresh_circled_solid,
                      color: orange, size: 30)),*/

              GestureDetector(
                onTap: () {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  SelectedcategoryNew = null;
                  SelectedbrandNew = null;
                  InputList = [];
                  for (int i = 0; i < defaulflistNew.length; i++) {
                    InputList.add(Avaiablity.fullname[i]);
                    shuffledchecklist.add(Avaiablity.checkvalue[i]);
                    shuffledreasons.add(Avaiablity.reason[i]);
                  }
                  Future.delayed(Duration(seconds: 4), () {
                    setState(() {
                      isApiCallProcess = false;
                    });
                  });
                },
                child: Icon(CupertinoIcons.refresh_circled_solid,
                    color: orange, size: 30),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    reasonChecked = 0;
                  });
                  for (int i = 0; i < Avaiablity.checkvalue.length; i++) {
                    if (Avaiablity.checkvalue[i] == 0) {
                      if (Avaiablity.reason[i].length > 0) {
                        setState(() {
                          reasonChecked = reasonChecked + 1;
                        });
                      } else {
                        final snackBar = SnackBar(
                            elevation: 20.00,
                            duration: Duration(seconds: 2),
                            content: Text(
                              "Please select reason",
                            ));
                        // scaffoldKey.currentState.showSnackBar(snackBar);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        /*        Flushbar(
                          message: "Please select reason",
                          duration: Duration(seconds: 3),
                        )..show(context);*/
                      }
                    } else {
                      setState(() {
                        reasonChecked = reasonChecked + 1;
                      });
                    }
                  }
                  print(
                      "reasonChecked..$reasonChecked..Avaiablity.reason...${Avaiablity.reason.length}..Avaiablity.checkvalue..${Avaiablity.checkvalue.length}");

                  if (reasonChecked == Avaiablity.reason.length) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    AddAvail.brandname = [];
                    AddAvail.categoryname = [];
                    AddAvail.productname = [];
                    AddAvail.productid = [];
                    AddAvail.reason = [];
                    AddAvail.checkvalue = [];
                    AddAvail.brandname = Avaiablity.brand;
                    AddAvail.categoryname = Avaiablity.category;
                    AddAvail.productname = Avaiablity.productname;
                    AddAvail.productid = Avaiablity.productid;
                    AddAvail.reason = Avaiablity.reason;
                    AddAvail.checkvalue = Avaiablity.checkvalue;
                    await addAvailability(connection);

                    // avaliabilitycheck = true;
                    setState(() {
                      isApiCallProcess = false;
                      reasonChecked = 0;
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CustomerActivities()));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.00),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffFFDBC1),
                    borderRadius: BorderRadius.circular(10.00),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
        // drawer: Drawer(
        //   child: Menu(),
        // ),
        body: OfflineNotification(
          body: Stack(
            children: [
              BackGround(),
              ProgressHUD(
                opacity: 0.3,
                inAsyncCall: isApiCallProcess,
                child: Column(
                  children: [
                    SizedBox(
                      height: onlinemode.value ? 0 : 25,
                    ),
                    OutletDetails(),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              width: MediaQuery.of(context).size.width / 2.15,
                              child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  iconEnabledColor: orange,
                                  elevation: 20,
                                  dropdownColor: Colors.white,
                                  items: Distintcategory.map((String val) {
                                    return new DropdownMenuItem<String>(
                                      value: val,
                                      child: new Text(val),
                                    );
                                  }).toList(),
                                  hint: Text("Category"),
                                  value: SelectedcategoryNew,
                                  onChanged: (newVal) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });

                                    SelectedcategoryNew = newVal;
                                    if (SelectedbrandNew == null) {
                                      InputList = [];
                                      for (int i = 0;
                                          i < defaulflistNew.length;
                                          i++) {
                                        if (Avaiablity.category[i] ==
                                            SelectedcategoryNew) {
                                          InputList.add(Avaiablity.fullname[i]);
                                          shuffledchecklist
                                              .add(Avaiablity.checkvalue[i]);
                                          shuffledreasons
                                              .add(Avaiablity.reason[i]);
                                        }
                                      }
                                    } else {
                                      InputList = [];
                                      for (int i = 0;
                                          i < defaulflistNew.length;
                                          i++) {
                                        if (Avaiablity.category[i] ==
                                                SelectedcategoryNew &&
                                            Avaiablity.brand[i] ==
                                                SelectedbrandNew) {
                                          InputList.add(Avaiablity.fullname[i]);
                                          shuffledchecklist
                                              .add(Avaiablity.checkvalue[i]);
                                          shuffledreasons
                                              .add(Avaiablity.reason[i]);
                                        }
                                      }
                                    }
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                  })),
                          Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              width: MediaQuery.of(context).size.width / 2.15,
                              child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  iconEnabledColor: orange,
                                  elevation: 20,
                                  dropdownColor: Colors.white,
                                  items: Distintbrands.map((String val) {
                                    return new DropdownMenuItem<String>(
                                      value: val,
                                      child: new Text(val),
                                    );
                                  }).toList(),
                                  hint: Text("Brand"),
                                  value: SelectedbrandNew,
                                  onChanged: (newVal) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });
                                    SelectedbrandNew = newVal;
                                    if (SelectedcategoryNew == null) {
                                      InputList = [];
                                      for (int i = 0;
                                          i < defaulflistNew.length;
                                          i++) {
                                        if (Avaiablity.brand[i] ==
                                            SelectedbrandNew) {
                                          InputList.add(Avaiablity.fullname[i]);
                                        }
                                      }
                                    } else {
                                      InputList = [];
                                      for (int i = 0;
                                          i < defaulflistNew.length;
                                          i++) {
                                        if (Avaiablity.category[i] ==
                                                SelectedcategoryNew &&
                                            Avaiablity.brand[i] ==
                                                SelectedbrandNew) {
                                          InputList.add(Avaiablity.fullname[i]);
                                        }
                                      }
                                    }
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                  })),
                        ],
                      ),
                    ),
                    // _createSearchView(),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: new TextFormField(
                              style: TextStyle(color: orange),
                              controller: _searchview,
                              cursorColor: orange,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                focusColor: orange,
                                hintText: '$hintText',
                                hintStyle: TextStyle(color: orange),
                                border: InputBorder.none,
                                icon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    CupertinoIcons.search,
                                    color: orange,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.trim().isEmpty) {
                                  setState(() {
                                    _firstSearch = true;
                                    _query = "";
                                  });

                                  print("empty");
                                } else {
                                  setState(() {
                                    _firstSearch = false;
                                    _query = _searchview.text;
                                  });
                                }
                              },
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isApiCallProcess = true;
                                  _searchview.clear();
                                });

                                print("clear button clik");
                                /*  setState(() {
                                  // _searchview.clear();
                                  _firstSearch = true;
                                  _query = "";
                                  // _searchview.text="";
                                  // isApiCallProcess = true;
                                  //_searchview.clear();
                                });*/
                                print("search clear");
                                Future.delayed(Duration(seconds: 4), () {
                                  setState(() {
                                    _firstSearch = true;
                                    _query = "";
                                  });
                                });

                                Future.delayed(Duration(seconds: 7), () {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                                print("search clear finish");
                              },
                              child: Icon(
                                CupertinoIcons.clear_circled_solid,
                                color: orange,
                              ))
                        ],
                      ),
                    ),

                    _firstSearch ? _createListView() : _performSearch(),
                  ],
                ),
              ),
              // NBlFloatingButton(),
            ],
          ),
        ));
  }

  Widget _createSearchView() {
    return new Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: new TextFormField(
              style: TextStyle(color: orange),
              controller: _searchview,
              cursorColor: orange,
              focusNode: focusNode,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                focusColor: orange,
                hintText: '$hintText',
                hintStyle: TextStyle(color: orange),
                border: InputBorder.none,
                icon: Icon(
                  CupertinoIcons.search,
                  color: orange,
                ),
              ),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  setState(() {
                    _firstSearch = true;
                    _query = "";
                  });

                  print("empty");
                } else {
                  setState(() {
                    _firstSearch = false;
                    _query = _searchview.text;
                  });
                }
              },
            ),
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  isApiCallProcess = true;
                });

                print("clear button clik");
                setState(() {
                  _searchview.clear();

                  _firstSearch = true;
                  _query = "";

                  // _searchview.text="";

                  // isApiCallProcess = true;
                  //_searchview.clear();
                });
                print("search clear");

                Future.delayed(Duration(seconds: 4), () {
                  setState(() {
                    isApiCallProcess = false;
                  });
                });
                print("search clear finish");
              },
              child: Icon(
                CupertinoIcons.clear_circled_solid,
                color: orange,
              ))
        ],
      ),
    );
  }

  Widget _createListView() {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Item/Description",
                    style: TextStyle(color: orange, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    " Avl",
                    style: TextStyle(color: orange, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          InputList.length > 0
              ? Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: double.infinity,
                    padding: EdgeInsets.all(5.0),
                    margin:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                    ),
                    child: ontapavailrefreshNew == true
                        ? SingleChildScrollView(
                            child: new ListView.builder(
                                shrinkWrap: true,
                                itemCount: InputList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            decoration:
                                                index != InputList.length - 1
                                                    ? BoxDecoration(
                                                        border: Border(
                                                        right: BorderSide(
                                                          //                   <--- right side
                                                          color: Colors.black,
                                                        ),
                                                        bottom: BorderSide(
                                                          //                   <--- left side
                                                          color: Colors.black,
                                                        ),
                                                      ))
                                                    : BoxDecoration(
                                                        border: Border(
                                                        right: BorderSide(
                                                          //                   <--- left side
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  '${InputList[index]}',
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      TextStyle(fontSize: 14.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 70,
                                              //width: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width/1.25)),
                                              decoration: index !=
                                                      InputList.length - 1
                                                  ? BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          //                   <--- left side
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  : BoxDecoration(),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 70,
                                                    margin: EdgeInsets.only(
                                                        right: 0.0),
                                                    /*decoration: BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                          //                   <--- right side
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),*/
                                                    child: Switch(
                                                      value: Avaiablity
                                                                      .checkvalue[
                                                                  Avaiablity
                                                                      .fullname
                                                                      .indexOf(
                                                                          InputList[
                                                                              index])] ==
                                                              0
                                                          ? true
                                                          : false,
                                                      // value: isSwitched,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isSwitchedAvail =
                                                              value;
                                                          isSwitchedAvail ==
                                                                  true
                                                              ? shuffledchecklist[
                                                                      defaulflistNew.indexOf(
                                                                          InputList[
                                                                              index])] =
                                                                  0
                                                              : shuffledchecklist[
                                                                  defaulflistNew.indexOf(
                                                                      InputList[
                                                                          index])] = 1;
                                                          isSwitchedAvail == true
                                                              ? Avaiablity.checkvalue[Avaiablity
                                                                      .fullname
                                                                      .indexOf(
                                                                          InputList[
                                                                              index])] =
                                                                  0
                                                              : Avaiablity
                                                                      .checkvalue[
                                                                  Avaiablity
                                                                      .fullname
                                                                      .indexOf(
                                                                          InputList[
                                                                              index])] = 1;

                                                          //isSwitched == true ? outofStockitems[Avaiablity.productname.indexOf(widget.item)]=0 : outofStockitems[Avaiablity.productname.indexOf(widget.item)]=1;
                                                        });
                                                      },
                                                      inactiveTrackColor:
                                                          Colors.green,
                                                      activeColor: Colors.red,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5.0),
                                                    width: 1, // Thickness
                                                    height: 70,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: Avaiablity
                                                                    .checkvalue[
                                                                Avaiablity
                                                                    .fullname
                                                                    .indexOf(
                                                                        InputList[
                                                                            index])] ==
                                                            1
                                                        ? SizedBox()
                                                        : DropdownButton(
                                                            elevation: 0,
                                                            dropdownColor:
                                                                Colors.white,
                                                            isExpanded: true,
                                                            iconEnabledColor:
                                                                orange,
                                                            iconSize: 35.0,
                                                            underline:
                                                                SizedBox(),
                                                            value: reasons[Avaiablity
                                                                        .fullname
                                                                        .indexOf(InputList[
                                                                            index])] ==
                                                                    ""
                                                                ? null
                                                                : reasons[Avaiablity
                                                                    .fullname
                                                                    .indexOf(
                                                                        InputList[
                                                                            index])],
                                                            onChanged:
                                                                (newVal) {
                                                              setState(() {
                                                                selectedreason =
                                                                    newVal;
                                                                reasons[defaulflistNew
                                                                    .indexOf(
                                                                        InputList[
                                                                            index])] = newVal;
                                                                Avaiablity
                                                                        .reason[
                                                                    Avaiablity
                                                                        .fullname
                                                                        .indexOf(
                                                                            InputList[index])] = newVal;
                                                              });
                                                            },
                                                            items:
                                                                DropDownItems,
                                                            hint: Text(
                                                              Avaiablity.reason[Avaiablity
                                                                          .fullname
                                                                          .indexOf(
                                                                              InputList[index])] ==
                                                                      ''
                                                                  ? "Select Reason"
                                                                  : "${Avaiablity.reason[Avaiablity.fullname.indexOf(InputList[index])]}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Text(
                              "To Access Availability Details Internet is Required\nPlease tap on the Refresh icon provided on the top",
                              style: TextStyle(color: orange, fontSize: 14),
                            )),
                          ),
                  ),
                )
              : _noRecordsFoundView(),
        ],
      ),
    );
  }

  Widget _performSearch() {
    _filterList = [];
    for (int i = 0; i < InputList.length; i++) {
      var item = InputList[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Item/Description",
                    style: TextStyle(color: orange, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    " Avl",
                    style: TextStyle(color: orange, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          if (_filterList.length > 0)
            Flexible(
              child: Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                child: SingleChildScrollView(
                  child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filterList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  decoration: index != _filterList.length - 1
                                      ? BoxDecoration(
                                          border: Border(
                                          right: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                          ),
                                        ))
                                      : BoxDecoration(
                                          border: Border(
                                          right: BorderSide(
                                            //                   <--- left side
                                            color: Colors.black,
                                          ),
                                        )),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${_filterList[index]}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 70,
                                    //width: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width/1.25)),
                                    decoration: index != _filterList.length - 1
                                        ? BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                //                   <--- left side
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        : BoxDecoration(),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 70,
                                          margin: EdgeInsets.only(right: 5.0),
                                          // decoration: BoxDecoration(
                                          //   border: Border(
                                          //     right: BorderSide(
                                          //       //                   <--- left side
                                          //       color: Colors.black,
                                          //     ),
                                          //   ),
                                          // ),
                                          child: Switch(
                                            value: Avaiablity.checkvalue[
                                                        Avaiablity.fullname
                                                            .indexOf(
                                                                _filterList[
                                                                    index])] ==
                                                    1
                                                ? false
                                                : true,
                                            // value: isSwitched,
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitchedAvail = value;
                                                print(
                                                    "isSwitchedAvail..$isSwitchedAvail");
                                                isSwitchedAvail == true
                                                    ? shuffledchecklist[
                                                        defaulflistNew.indexOf(
                                                            _filterList[
                                                                index])] = 0
                                                    : shuffledchecklist[
                                                        defaulflistNew.indexOf(
                                                            _filterList[
                                                                index])] = 1;

                                                isSwitchedAvail == true
                                                    ? Avaiablity.checkvalue[
                                                        Avaiablity.fullname
                                                            .indexOf(
                                                                _filterList[
                                                                    index])] = 0
                                                    : Avaiablity.checkvalue[
                                                        Avaiablity.fullname
                                                            .indexOf(_filterList[
                                                                index])] = 1;

                                                //isSwitched == true ? outofStockitems[Avaiablity.productname.indexOf(widget.item)]=0 : outofStockitems[Avaiablity.productname.indexOf(widget.item)]=1;
                                              });
                                            },
                                            inactiveTrackColor: Colors.green,
                                            activeColor: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 5.0),
                                          width: 1, // Thickness
                                          height: 70,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: 100,
                                            child: Avaiablity.checkvalue[
                                                        Avaiablity.fullname
                                                            .indexOf(
                                                                _filterList[
                                                                    index])] ==
                                                    0
                                                ? DropdownButton(
                                                    elevation: 0,
                                                    dropdownColor: Colors.white,
                                                    isExpanded: true,
                                                    iconEnabledColor: orange,
                                                    iconSize: 35.0,
                                                    value: reasons[Avaiablity
                                                                .fullname
                                                                .indexOf(
                                                                    _filterList[
                                                                        index])] ==
                                                            ""
                                                        ? null
                                                        : reasons[Avaiablity
                                                            .fullname
                                                            .indexOf(
                                                                _filterList[
                                                                    index])],
                                                    onChanged: (newVal) {
                                                      setState(() {
                                                        selectedreason = newVal;
                                                        reasons[defaulflistNew
                                                                .indexOf(
                                                                    _filterList[
                                                                        index])] =
                                                            newVal;
                                                        Avaiablity.reason[Avaiablity
                                                                .fullname
                                                                .indexOf(
                                                                    _filterList[
                                                                        index])] =
                                                            newVal;
                                                      });
                                                    },
                                                    items: DropDownItems,
                                                    hint: Text(
                                                      Avaiablity.reason[Avaiablity
                                                                  .fullname
                                                                  .indexOf(
                                                                      _filterList[
                                                                          index])] ==
                                                              ''
                                                          ? "Select Reason"
                                                          : "${Avaiablity.reason[Avaiablity.fullname.indexOf(_filterList[index])]}",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                : SizedBox()),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          if (_filterList.length == 0) _noRecordsFoundView()
        ],
      ),
    );
  }

  Widget _noRecordsFoundView() {
    return Flexible(
        child: Center(
      child: Text(
        "No Records Found",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    ));
  }
}

String selectedreason;
List DropDownItems = [
  "Item Expired",
  "Pending Delivery",
  "Out Of Stock",
  "Not Listed"
].map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

bool isSwitchedAvail = false;
/*class TogglseSwitch extends StatefulWidget {
  ToggleSwitch({this.item});
   final item;
  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}*/

/*class _ToggleSwitchState extends State<ToggleSwitch> {

//
  @override
   Void initState() {
    super.initState();
    bool value =  shuffledchecklist[defaulflistNew.indexOf(widget.item)] == 1 ? false:true;
   // bool value = outofStockitems.contains(widget.item) == true ? true : false;
    setState(() {
      isSwitched = value;
    });
  }
 // bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          margin: EdgeInsets.only(right:5.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide( //                   <--- left side
                color: Colors.black,
              ),),),
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                isSwitched == true ? shuffledchecklist[defaulflistNew.indexOf(widget.item)]=0 : Avaiablity.checkvalue[defaulflistNew.indexOf(widget.item)]=1;

                //isSwitched == true ? outofStockitems[Avaiablity.productname.indexOf(widget.item)]=0 : outofStockitems[Avaiablity.productname.indexOf(widget.item)]=1;
                print(outofStockitems);
              });
            },
            inactiveTrackColor: Colors.green,
            activeColor: Colors.red,
          ),
        ),
        SizedBox(
          height: 50,
          width: 100,
          child: isSwitched == true ? DropdownButton(
            elevation: 0,
            dropdownColor: Colors.white,
            isExpanded: true,
            iconEnabledColor: orange,
            iconSize: 35.0,
            value: selectedreason,
            onChanged: (newVal){
              setState(() {
                selectedreason = newVal;
                reasons[Avaiablity.productname.indexOf(widget.item)] = newVal;
              });
            },
            items: DropDownItems,
            hint: Text(shuffledreasons[defaulflistNew.indexOf(widget.item)]==''?"Select Reason":"${shuffledreasons[defaulflistNew.indexOf(widget.item)]}",style: TextStyle(color: Colors.black),),
          ) : SizedBox()
        ),
      ],
    );
  }
}*/
List<String> reasons = [];
List<int> outofStockitems = [];