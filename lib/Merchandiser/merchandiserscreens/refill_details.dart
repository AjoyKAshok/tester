import 'dart:async';
import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/network/NetworkStatusService.dart';
import 'package:merchandising/utils/background.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../../ConstantMethods.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'Customers Activities.dart';
import 'package:merchandising/model/database.dart';
import 'package:merchandising/api/clientapi/stockexpirydetailes.dart';
import 'package:merchandising/model/dropdownsearchrepo.dart';
import 'package:merchandising/api/api_service2.dart';
import 'package:merchandising/api/avaiablityapi.dart';

import 'newCustomerActivities.dart';

List<String> productLocation = ["STORE", "BACK DOOR"];
String productLocationValue;
String outletid = chekinoutlet.checkinoutlet ?? "";
String proLocation = "";
String selectedCategory;
int refillqty;
String empId = '${DBrequestdata.receivedempid}';
String displayDate;
String catname = "";
bool showDrop1 = false;
int searchingCount = 0;
List<String> customer = [
  "AL MAYA",
  "AUH COOP",
  "SHARJAH COOP",
  "EMIRATES COOP",
  "WAITROSE",
  "AL AIN COOP",
  "LULU",
  "CARREFOUR",
  "SPINNEYS",
  "GT",
  "UNION COOP",
  "CHOITHRAM",
  "WEST ZONE",
  "SAFEER",
  "NESTO",
  "OTHERS"
];
String customerValue;
String cusvalue = "";
String clientName = DBrequestdata.client;

//List<String> UOM = ["BAG","BUNDLE","BOX","CASE","CARTON","DOZEN","PIECE","PACK","SINGLE"];
List<String> UOM = ["OUTER", "CASE", "PIECE", "CAN", "NRB", "PET", "BIB"];
String UOMValue1;

var productname1 = "Select from the above";
var packtype1 = 'Regular';
var range = 'Regular';
int indexofselectedproduct;
var selectedproduct1;
List<String> selectedList = [];
String selecttype;
String selectedPeriod;
String selectpack;
String selectedBarCode;
String selectedUOM;
TextEditingController barcodeOfSelected = TextEditingController();
TextEditingController uomSelected = TextEditingController();
List selecttypelist =
    ["SKU", "ZREP", "Product Name", "Barcode"].map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();
String selectcodes;
List productdetails = Refill.productdetails.toSet().toList().map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

List barcode = Refill.barcode.toSet().toList().map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();
// List zrep = Expiry.zrepcodes.toSet().toList().map((String val) {
//   return new DropdownMenuItem<String>(
//     value: val,
//     child: new Text(val),
//   );
// }).toList();
// List sku = Expiry.sku.toSet().toList().map((String val) {
//   return new DropdownMenuItem<String>(
//     value: val,
//     child: new Text(val),
//   );
// }).toList();

List inputlist = selectedList.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

TextEditingController remarks1 = TextEditingController();
TextEditingController categoryController1 = TextEditingController();
TextEditingController productcontroller1 = TextEditingController();
DropdownMenuItem jj = DropdownMenuItem(
  child: null,
);

bool isApiCallProcess = false;
String catName1;

class RefillDetails extends StatefulWidget {
  @override
  State<RefillDetails> createState() => _RefillDetailsState();
}

bool expirycheck = false;

class _RefillDetailsState extends State<RefillDetails> {
  String productLocationValue;
  String customerValue;

  String proLocation = "";
  String cusvalue = "";
  String uomvalue = "";
  String catvalue = "";
  bool connection = false;

  void getDropDownItem() {
    setState(() {
      proLocation = productLocationValue;
      cusvalue = customerValue;
      UOMValue1 = "PIECE";
      catvalue = catName1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadExpiryReportValues1();
    print('The Client for the user is $clientName');
  }

  loadExpiryReportValues1() {
    // UOMValue1 = "CAN";
    // catName1 = null;
    productname1 = "Select from the above";
    // packtype1 = 'Regular';
    selectedproduct1 = null;
    showDrop1 = false;
    // ENDdate1 = tomoroww1;
    remarks1.clear();
    quantity.clear();
    // categoryController1.clear();
    productcontroller1.clear();
    uomSelected.clear();
    barcodeOfSelected.clear();
    selectedBarCode = null;
    selectedUOM = null;
  }

  @override
  void didChangeMetrics() {
    //print(WidgetsBinding.instance.focusManager.toString());
    //_removeDropdownRoute();
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<NetworkStatusService>(context);

    if (networkStatus.online == true) {
      setState(() {
        connection = true;
      });
    } else {
      connection = false;
    }
    // FocusScope.of(context).requestFocus(new FocusNode());
    return ValueListenableBuilder<bool>(
        valueListenable: onlinemode,
        builder: (context, value, child) {
          return ProgressHUD(
            inAsyncCall: isApiCallProcess,
            opacity: 0.3,
            child: GestureDetector(
              onTap: () {
                // FocusScopeNode currentFocus = FocusScope.of(context);
                // if (!currentFocus.hasPrimaryFocus) {
                //   currentFocus.unfocus();
                // }
              },
              child: Scaffold(
                appBar: AppBar(
                  // backgroundColor: containerscolor,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: orange),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stock Check Details',
                            style: TextStyle(color: orange),
                          ),
                          EmpInfo()
                        ],
                      ),
                      Spacer(),
                      // GestureDetector(
                      //   onTap: () async {
                      //     setState(() {
                      //       isApiCallProcess = true;
                      //     });
                      //     print(addedproductid.length);
                      //     for (int u = 0; u < addedproductid.length; u++) {
                      //       print(u);
                      //       addedexpiryindex = u;
                      //       productid = addedproductid[u];
                      //       pricepc = addedpriceperitem[u];
                      //       // expirypc = addeditemscount[u];
                      //       pcexpirydate = addedexpirydate[u];
                      //       exposureqntypc = addedexposurequnatity[u];
                      //       remarksifany = addedremarks[u] == ""
                      //           ? "no remarks entered"
                      //           : addedremarks[u];
                      //       productlocation = addedproductlocation[u];
                      //       customerstoregroup = addedcustomerstore[u];
                      //       uom = addeduom[u];
                      //       print("UOM: $uom");
                      //       print(addeduom[u].toString());
                      //       await getRefillDetails();
                      //       // await addexpiryproducts();
                      //     }

                      //     // await Addedstockdataformerch();
                      //     setState(() {
                      //       addedproductid = [];
                      //       addedpriceperitem = [];
                      //       addeditemscount = [];
                      //       addedexpirydate = [];
                      //       addedexposurequnatity = [];
                      //       addedremarks = [];
                      //       addedproductlocation = [];
                      //       addedcustomerstore = [];
                      //       addeduom = [];
                      //     });
                      //     expirycheck = true;
                      //     setState(() {
                      //       isApiCallProcess = false;
                      //     });
                      //     Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (BuildContext context) =>
                      //                 CustomerActivities()));
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(right: 10.00),
                      //     padding: EdgeInsets.all(10.0),
                      //     decoration: BoxDecoration(
                      //       color: Color(0xffFFDBC1),
                      //       borderRadius: BorderRadius.circular(10.00),
                      //     ),
                      //     child: Text(
                      //       'Submit',
                      //       style: TextStyle(color: Colors.black, fontSize: 15),
                      //     ),
                      //   ),
                      // )
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
                      Column(
                        children: [
                          SizedBox(
                            height: onlinemode.value ? 0 : 25,
                          ),
                          Expanded(
                            child: DefaultTabController(
                              length: 2, // lengt0h of tabs
                              initialIndex: 0,

                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                appBar: PreferredSize(
                                  preferredSize:
                                      Size.fromHeight(kToolbarHeight),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TabBar(
                                      //    controller: _controller,
                                      labelColor: orange,
                                      unselectedLabelColor: Colors.black,
                                      indicatorColor: orange,
                                      labelPadding: EdgeInsets.zero,
                                      tabs: [
                                        Tab(text: 'Add Data'),
                                        Tab(text: 'Saved Data'),
                                        // Tab(text: 'Submitted Data'),
                                      ],
                                    ),
                                  ),
                                ),
                                body: TabBarView(
                                    //physics: NeverScrollableScrollPhysics(),
                                    // controller: _controller,
                                    children: [
                                      AddData(),
                                      Addedexpirydata(),
                                      // SubmittedData(),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // NBlFloatingButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class AddData extends StatefulWidget {
  @override
  AddDataState createState() => AddDataState();
}

class AddDataState extends State<AddData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      quantity.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // height: 700,

            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                DropDownField(
                    controller: productcontroller1,
                    value: selectedproduct1,
                    labelText: 'Select product',
                    hintText: "Search by Product-ZREP-SKU-Barcode",
                    items: Refill.productfullname,
                    hintStyle: TextStyle(
                        color: orange,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500),
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                    onValueChanged: (dynamic newValue) {
                      //  print('tets1');
                      // getstockexpiryproducts();
                      getRefillDetails();
                      selectedproduct1 = newValue;
                      indexofselectedproduct =
                          Refill.productfullname.indexOf(selectedproduct1);
                      print('The index is: $indexofselectedproduct');
                      print("selectedproduct...${selectedproduct1}");

                      setState(() {
                        //await getstockexpiryproducts();
                        // print('tets');
                        productname1 =
                            Refill.productdetails[indexofselectedproduct];
                        selectedUOM = Refill.UOM[indexofselectedproduct];
                        uomSelected.text = selectedUOM;
                        // categoryController1.text = catName1;
                        selectedBarCode =
                            Refill.barcode[indexofselectedproduct];
                        barcodeOfSelected.text = selectedBarCode;
                        print('Bar code of selected item: $selectedBarCode');
                        print('UOM code of selected item: $selectedUOM');

                        // remarks.text="ID${Expiry.id[indexofselectedproduct]}";
                        if (newValue.toString().trim().length < 0) {
                          print("there is no value");
                        }
                      });
                    }),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 5.0, right: 5.0),
                      child: Row(
                        // mainAxisAlignment:
                        //     MainAxisAlignment
                        //         .spaceBetween,
                        children: [
                          Container(
                            width: 55,
                            child: Text(
                              "Product",
                              style: TextStyle(color: orange),
                            ),
                          ),
                          Text(" : "),
                          Flexible(
                              child: Text(
                            "$productname1",
                            maxLines: 3,
                            style: TextStyle(color: orange),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: uomSelected,
                    cursorColor: grey,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusColor: orange,
                      hintText: "UOM",
                      hintStyle: TextStyle(
                        color: grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: barcodeOfSelected,
                    cursorColor: grey,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusColor: orange,
                      hintText: "Barcode",
                      hintStyle: TextStyle(
                        color: grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                EndDate(),
                SizedBox(height: 10),
                Peice(),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: remarks1,
                    cursorColor: grey,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    // ], //
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusColor: orange,
                      hintText: "Remarks",
                      hintStyle: TextStyle(
                        color: grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  Addedexpirydata();
                });
                
                if (selectedUOM != null) {
                  if (customerValue == null) {
                    if (productLocationValue == null) {
                      print("Log Refill Module");
                      print(productname1 +
                          "${today.toLocal()}".split(' ')[0] +
                          "!=" +
                          "${today.toLocal()}".split(' ')[0]);
                      print("End");
                      if (productname1 != null) {
                        print("correct");
                        Storecode = outletid;
                        print(
                            'The Store code from Refill Details: $currentoutletid');

                        // filledby = '${DBrequestdata.receivedempid}';
                        remarksifany = remarks1.text == "" ? 0 : remarks1.text;

                        uom = selectedUOM == "" ? 0 : selectedUOM;
                        print('Refill Details Employee id : ${empId}');
                        print('Refill Details Remarks : ${remarksifany}');
                        print('Refill Details UOM : ${uom}');
                        {
                          setState(() {
                            isApiCallProcess = true;
                          });

                          addedproductid.add(Refill
                              .id[Refill.productdetails.indexOf(productname1)]);
                          addedproductname.add('$productname1');
                          // displayDate =  "${DateFormat("yyyy-MM-dd").format(ENDdate1)}";
                          addedexpirydate.add(
                              "${DateFormat("yyyy-MM-dd").format(ENDdate1)}");

                          addedremarks
                              .add(remarks1.text == null ? "" : remarks1.text);

                          addeduom.add(selectedUOM);
                          addedrefillitems.add({
                            "id": Refill.id[
                                Refill.productdetails.indexOf(productname1)],
                            "amount": refillqty,
                            "date": DateFormat("yyyy-MM-dd").format(ENDdate1),
                          });

                          print(
                              'Refill Details Product id : ${addedproductid}');
                          print(
                              'Refill Details Remarks Again : ${addedremarks}');
                          print('Refill Details UOM Again : ${addeduom}');
                          print(
                              'Refill Details Timesheet Id : ${currenttimesheetid}');
                          print(
                              'Refill Details Product Name : ${productname1}');

                          print(
                              'Refill Details Refill Items : $addedrefillitems');
                          productname1 = "Select from the above";

                          selectedproduct1 = null;
                          showDrop1 = false;
                          ENDdate1 = today;
                          quantity.clear();
                          remarks1.clear();
                          barcodeOfSelected.clear();
                          uomSelected.clear();
                          productcontroller1.clear();
                          DefaultTabController.of(context).animateTo(1);
                          // Flushbar(
                          //   message: "data updated sucessfully",
                          //   duration: Duration(seconds: 3),
                          // )..show(context);
                          Fluttertoast.showToast(
              msg: "Data Updated Successfully...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.orange[200],
              textColor: Colors.white,
              fontSize: 16.0
          );
                        }
                      } else {
                        print("please Select Product..$productname1");
                        Flushbar(
                          message: productname1 == null
                              ? "please Select Product should not be null "
                              : "please select a vaild product Expiry date",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                    } else {
                      print("Location");
                      Flushbar(
                        message: productLocationValue == ""
                            ? "Please Select Product Location"
                            : "Product Location is required",
                        duration: Duration(seconds: 3),
                      )..show(context);
                    }
                  } else {
                    print("Customer");
                    Flushbar(
                      message: customerValue == ""
                          ? "Please select Customer"
                          : "Customer is required",
                      duration: Duration(seconds: 3),
                    )..show(context);
                  }
                } else {
                  print("UOMMMMMMMMMM");
                  Flushbar(
                    message: selectedUOM == ""
                        ? "Please Select UOM"
                        : "Please Fill The Empty Field",
                    duration: Duration(seconds: 3),
                  )..show(context);
                }

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (BuildContext context) => ExpiryReport()));
                setState(() {
                  isApiCallProcess = false;
                });
              },
              style:
                  ButtonStyle(backgroundColor: MaterialStateProperty.all(pink)),
              child: Text(
                "SAVE",
                style: TextStyle(color: orange),
              ))
        ],
      ),
    );
  }
}

DateTime tomoroww1 = DateTime.now().add(Duration(days: 1));

DateTime today = DateTime.now();

DateTime ENDdate1 = DateTime.now();

class EndDate extends StatefulWidget {
  @override
  _EndDateState createState() => _EndDateState();
}

class _EndDateState extends State<EndDate> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: orange,
              onPrimary: Colors.white,
              surface: orange,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != EndDate)
      setState(() {
        ENDdate1 = picked;
        // displayDate = '${(ENDdate1.year) - (ENDdate1.year) - (ENDdate1.year)}';
        displayDate = "${ENDdate1.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Text(
            "Refill Date",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            "${ENDdate1.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}

class Peice extends StatefulWidget {
  @override
  _PeiceState createState() => _PeiceState();
}

double priceperpiece;
double estimatedValue;
double estimatedQuantityValue;
TextEditingController quantity = TextEditingController();
TextEditingController expirypeciescount = TextEditingController();
TextEditingController peiceprice = TextEditingController();

class _PeiceState extends State<Peice> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadValues();
  }

  loadValues() {
    quantity.clear();
    // expirypeciescount.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: quantity,
            onChanged: (value) {
              setState(() {
                refillqty = int.parse(value);
                // quantity.text = value;
              });
            },
            cursorColor: grey,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusColor: orange,
              hintText: "Refill Quantity",
              hintStyle: TextStyle(
                color: grey,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Addedexpirydata extends StatefulWidget {
  @override
  _AddedexpirydataState createState() => _AddedexpirydataState();
}

class _AddedexpirydataState extends State<Addedexpirydata> {
  var _searchview = new TextEditingController();

  bool _firstSearch = true;

  String _query = "";

  List<dynamic> inputlist;

  List<String> _filterList;

  List<String> _filteredexpiryList;
  List<int> _filteredeitemsList;

  @override
  void initState() {
    super.initState();
    inputlist = addedproductname;
    // inputlist.sort();
  }

  _AddedexpirydataState() {
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
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              // _createSearchView(),
              SizedBox(
                height: 10.0,
              ),
              _firstSearch ? _createListView() : _performSearch(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                child: GestureDetector(
                  onTap: () async {
                    if (true)
                    // if (onlinemode.value)
                    {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      print(addedproductid.length);

                      if (addedproductid.length != 0) {
                        for (int u = 0; u < addedproductid.length; u++) {
                          print(u);
                          addedexpiryindex = u;
                          productid = addedproductid[u];

                          pcexpirydate = addedexpirydate[u];

                          remarksifany = addedremarks[u] == ""
                              ? "no remarks entered"
                              : addedremarks[u];

                          uom = addeduom[u];
                        }
                        Map stockdata = {
                          "employee_id": empId,
                          "outlet_id": currentoutletid,
                          "time_sheet_id": currenttimesheetid,
                          "refill_items": addedrefillitems,
                        };
                        print(
                            'Adding Refill Data to DB : ${jsonEncode(stockdata)}');
                        try {
                          http.Response response = await http.post(
                            addrefillDetail,
                            headers: {
                              'Content-Type': 'application/json',
                              'Accept': 'application/json',
                              'Authorization':
                                  'Bearer ${DBrequestdata.receivedtoken}',
                            },
                            body: jsonEncode(stockdata),
                          );
                          // print(
                          //     'Adding Refill Data to DB : ${jsonEncode(stockdata)}');
                          print("online saved data...${response.body}");
                        } on SocketException catch (_) {
                          print("offline saved data...");
                          adddataforsync(
                              "https://test.rhapsody.ae/api/add_stock_expiry_new",
                              jsonEncode(stockdata),
                              "expiry report for product id :$productid for the timesheet $currenttimesheetid,"
                                  // " items count : $expirypc, "
                                  "expiry date : $pcexpirydate");
                        }
                        addedproductname = [];
                        addedproductid = [];
                        addedpriceperitem = [];
                        addeditemscount = [];
                        addedexpirydate = [];
                        addedexposurequnatity = [];
                        addedremarks = [];
                        addedproductlocation = [];
                        addedcustomerstore = [];
                        addeduom = [];
                        addedrefillitems = [];

                        // await Addedstockdataformerch();
                        setState(() {
                          isApiCallProcess = false;
                        });
                        expirycheck = true;
                        // DefaultTabController.of(context).animateTo(2);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NewCustomerActivities()));
                        Flushbar(
                          message: "Data Submitted Successfully...",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        Flushbar(
                          message: "No product to submit",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Submit Now",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      margin: EdgeInsets.fromLTRB(10.0, 10, 10, 0),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: new TextField(
              style: TextStyle(color: orange),
              controller: _searchview,
              cursorColor: orange,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                focusColor: orange,
                hintText: 'Search by SKU/ZREP',
                hintStyle: TextStyle(color: orange),
                border: InputBorder.none,
                isCollapsed: true,
                icon: Icon(
                  CupertinoIcons.search,
                  color: orange,
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                _searchview.clear();
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
    return new Flexible(
        child: new ListView.builder(
            itemCount: addedproductid.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: alertboxcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              content: Builder(
                                builder: (context) {
                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Delete ?',
                                        style: TextStyle(
                                            color: orange, fontSize: 20),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                      Text(
                                        "Do you want to remove these enteries ?",
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Note* if you want to send the data regarding this product, you need to add the Entries again before submitting the data",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: orange, fontSize: 10),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            print(index);
                                            setState(() {
                                              addedproductname.removeAt(index);
                                              addedproductid.removeAt(index);
                                              addedexpirydate.removeAt(index);
                                              addeditemscount.removeAt(index);
                                              addedexposurequnatity
                                                  .removeAt(index);
                                              addedremarks.removeAt(index);
                                              addedproductlocation
                                                  .removeAt(index);
                                              addedcustomerstore
                                                  .removeAt(index);
                                              addeduom.removeAt(index);
                                              addedpriceperitem.removeAt(index);
                                              // addcatname.removeAt(index);
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        RefillDetails()));
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Text('YES',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${addedproductname[index]}',
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: orange),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Product ID :',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(addedproductid[index].toString()),
                        ],
                      ),
                      SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text('Category :',
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //         )),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     // Text(addcatname[index].toString()),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Refill Date :',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(addedexpirydate[index]),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('UOM :',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(addeduom[index].toString()),
                        ],
                      ),
                      SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text('price :',
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //         )),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text('${addedpriceperitem[index]} AED'),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text('No of Items :',
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //         )),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text(addeditemscount[index].toString()),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text('Exposure Quantity :',
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //         )),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text(addedexposurequnatity[index].toString()),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      addedremarks[index] != ""
                          ? Row(
                              children: [
                                Text('Remarks :',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(addedremarks[index].toString()),
                              ],
                            )
                          : SizedBox(height: 2),
                      // Row(
                      //   children: [
                      //     Text('Product Location :',
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //         )),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text(addedproductlocation[index].toString() == "null"
                      //         ? "--"
                      //         : addedproductlocation[index].toString()),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text('Customer Store :',
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //         )),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text(addedcustomerstore[index].toString() == "null"
                      //         ? "--"
                      //         : addedcustomerstore[index].toString()),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                    ],
                  ),
                ),
              );
            }),
      
    );
  }

  Widget _performSearch() {
    _filterList = [];
    _filteredexpiryList = [];
    _filteredeitemsList = [];
    for (int i = 0; i < addedproductname.length; i++) {
      var item = addedproductname[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterList.add(item);
        _filteredexpiryList
            .add(addedexpirydate[addedproductname.indexOf(item)]);
        _filteredeitemsList
            .add(addeditemscount[addedproductname.indexOf(item)]);
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return Flexible(
      child: new ListView.builder(
          itemCount: _filteredeitemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '${_filterList[index]}',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Expiry Date :',
                          style: TextStyle(
                            fontSize: 15.0,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_filteredexpiryList[index]),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Items Count:',
                          style: TextStyle(
                            fontSize: 15.0,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_filteredeitemsList[index].toString()),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

List<String> addedproductname = [];
List<num> addedpriceperitem = [];
List<String> addedexpirydate = [];
List<int> addeditemscount = [];
List<int> addedexposurequnatity = [];
List<int> addedrefillquantity = [];
List<String> addedremarks = [];
List<int> addedproductid = [];
List<String> addedproductlocation = [];
List<String> addedcustomerstore = [];
List<String> addeduom = [];
List<Map<String, dynamic>> addedrefillitems = [];

class SubmittedData extends StatefulWidget {
  const SubmittedData({Key key}) : super(key: key);

  @override
  _SubmittedDataState createState() => _SubmittedDataState();
}

class _SubmittedDataState extends State<SubmittedData> {
  var _searchview = new TextEditingController();

  bool _firstSearch = true;

  String _query = "";

  List<dynamic> inputlist;

  List<String> _filterList;

  List<String> _filteredexpiryList;
  List<int> _filteredeitemsList;

  _SubmittedDataState() {
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
    return StockDataMerch.productname.length > 0
        ? Column(
            children: <Widget>[
              _createSearchView(),
              SizedBox(
                height: 10.0,
              ),
              _firstSearch ? _createListView() : _performSearch(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    await Addedstockdataformerch();

                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (StockDataMerch.productname.length == 0) {
                      Flushbar(
                        message: "No data submitted to this outlet",
                        duration: Duration(seconds: 3),
                      )..show(context);
                    }
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 10.00),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xffFFDBC1),
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      child: Text(
                        'Get Submitted Data',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        :
        // Container();
        GestureDetector(
            onTap: () async {
              setState(() {
                isApiCallProcess = true;
              });
              await Addedstockdataformerch();

              setState(() {
                isApiCallProcess = false;
              });
              print("Stockdata");
              print(Stockdata.productname.length);
              if (StockDataMerch.productname.length == 0) {
                Flushbar(
                  message: "No data submitted to this outlet",
                  duration: Duration(seconds: 3),
                )..show(context);
              }
            },
            child: Center(
              child: Container(
                margin: EdgeInsets.only(right: 10.00),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xffFFDBC1),
                  borderRadius: BorderRadius.circular(10.00),
                ),
                child: Text(
                  'Get Submitted Data',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
          );
  }

  Widget _createSearchView() {
    return new Container(
      margin: EdgeInsets.fromLTRB(10.0, 10, 10, 0),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: new TextField(
              style: TextStyle(color: orange),
              controller: _searchview,
              cursorColor: orange,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                focusColor: orange,
                hintText: 'Search by SKU/ZREP',
                hintStyle: TextStyle(color: orange),
                border: InputBorder.none,
                isCollapsed: true,
                icon: Icon(
                  CupertinoIcons.search,
                  color: orange,
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                _searchview.clear();
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
      child: ListView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          //shrinkWrap: true,
          itemCount: StockDataMerch.productname.length,
          itemBuilder: (BuildContext context, int index) {
            print(StockDataMerch.productname);
            print("$index - ${StockDataMerch.productname[index]}");
            return Container(
              // height: 170,
              margin: EdgeInsets.only(bottom: 10, left: 10.0, right: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                // child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${StockDataMerch.productname[index]}",
                          style: TextStyle(color: orange),
                          maxLines: 1,
                        )),
                    //Text("Outlet : ${Stockdata.outlet[index]}"),

                    Text(
                        "Category : ${StockDataMerch.categoryname[index].toString()}"),

                    Text(
                        "Expiry Date : ${StockDataMerch.expirydate[index].toString()}"),
                    //Text("Price : ${StockDataMerch.pieceperprice[index].toString()} AED"),

                    Text("UOM : ${StockDataMerch.Uom[index].toString()}"),

                    Text(
                        "Near to Expiry : ${StockDataMerch.nearexpiry[index].toString()}"),
                    Text(
                        "Exposure Quantity : ${StockDataMerch.exposurequantity[index].toString()}"),
                    Text(
                        "Remarks : ${StockDataMerch.remarks[index].toString()}"),
                    Text(
                        "Captured on : ${StockDataMerch.captureddate[index].toString()}"),
                    Text(
                        "Product Location : ${StockDataMerch.Productlocation[index].toString() == "null" ? "--" : StockDataMerch.Productlocation[index].toString()}"),
                    Text(
                        "Customer StoreGroup : ${StockDataMerch.Customerstoregroup[index].toString() == "null" ? "--" : StockDataMerch.Customerstoregroup[index].toString()}"),
                  ],
                ),
                // ),
              ),
            );
          }),
    );
  }

  List<int> _filterindex = [];

  Widget _performSearch() {
    _filterList = [];
    _filterindex = [];
    _filteredexpiryList = [];
    _filteredeitemsList = []; // StockDataMerch
    for (int i = 0; i < StockDataMerch.productname.length; i++) {
      var item = StockDataMerch.productname[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterindex.add(StockDataMerch.productname.indexOf(item));
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return Expanded(
      child: ListView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          //shrinkWrap: true,
          itemCount: _filterindex.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 170,
              margin: EdgeInsets.only(bottom: 10, left: 10.0, right: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "${StockDataMerch.productname[_filterindex[index]]}",
                            style: TextStyle(color: orange),
                            maxLines: 1,
                          )),
                      //Text("Outlet : ${Stockdata.outlet[index]}"),
                      Text(
                          "Expiry Date : ${StockDataMerch.expirydate[_filterindex[index]].toString()}"),
                      // Text("Price : ${StockDataMerch.pieceperprice[_filterindex[index]].toString()} AED"),
                      Text(
                          "Category :${StockDataMerch.categoryname[_filterindex[index]].toString()}"),
                      Text(
                          "UOM : ${StockDataMerch.Uom[_filterindex[index]].toString()}"),
                      Text(
                          "Near to Expiry : ${StockDataMerch.nearexpiry[_filterindex[index]].toString()}"),
                      Text(
                          "Exposure Quantity : ${StockDataMerch.exposurequantity[_filterindex[index]].toString()}"),
                      Text(
                          "Remarks : ${StockDataMerch.remarks[_filterindex[index]].toString()}"),
                      Text(
                          "Captured on : ${StockDataMerch.captureddate[_filterindex[index]].toString()}"),

                      Text(
                          "Product Location : ${StockDataMerch.Productlocation[_filterindex[index]].toString() == "null" ? "--" : StockDataMerch.Productlocation[_filterindex[index]].toString()}"),
                      Text(
                          "Customer StoreGroup : ${StockDataMerch.Customerstoregroup[_filterindex[index]].toString() == "null" ? "--" : StockDataMerch.Customerstoregroup[_filterindex[index]].toString()}"),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
