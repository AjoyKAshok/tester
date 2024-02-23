import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Fieldmanager/products.dart';

import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/FMapi/add_categoryapi.dart';

import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/FMapi/add_brandapi.dart';

import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';

List outletlist = outletdata.outletname.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();
String selectedoutlets;

List<int> selectcategory;
List categorylist = Category.name.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

class AddCategoryMap extends StatefulWidget {
  @override
  _AddCategoryMapState createState() => _AddCategoryMapState();
}

class _AddCategoryMapState extends State<AddCategoryMap> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: containerscolor,
            iconTheme: IconThemeData(color: orange),
            title: Text(
              'Add Category Mapping',
              style: TextStyle(color: orange),
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
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: pink,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SearchableDropdown.single(
                              underline: SizedBox(),
                              items: outletlist,
                              value: selectedoutlets,
                              hint: "Select Outlet",
                              searchHint: "Select Outlet",
                              onChanged: (value) {
                                setState(() {
                                  selectedoutlets = value;
                                });
                              },
                              isExpanded: true,
                            ),
                          ),
                          SizedBox(height: 5),
                          SelectClient(),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SearchableDropdown.multiple(
                              underline: SizedBox(),
                              items: categorylist,
                              selectedItems: selectcategory,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Select Category"),
                              ),
                              searchHint: "Select Category",
                              onChanged: (value) {
                                setState(() {
                                  selectcategory = value;
                                  print(selectcategory);
                                });
                              },
                              closeButton: (selectedItems) {
                                return (selectedItems.isNotEmpty
                                    ? "Save ${selectedItems.length == 1 ? '"' + categorylist[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                    : "Save without selection");
                              },
                              isExpanded: true,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              CategoryOutletmap.outletid = outletdata.outletid[
                                  outletdata.outletname
                                      .indexOf(selectedoutlets)];
                              CategoryOutletmap.clientid =
                                  'Emp${dropdownclient.replaceAll(new RegExp(r'[^0-9]'), '')}';

                              CategoryOutletmap.categoryid = [];

                              for (int u = 0; u < selectcategory.length; u++) {
                                CategoryOutletmap.categoryid
                                    .add(Category.id[u]);
                              }
                              await addcategoryoutletmap();
                              print(
                                  "Category id: ${CategoryOutletmap.categoryid}");
                              print(CategoryOutletmap.clientid);
                              print(CategoryOutletmap.outletid);

                              setState(() {
                                isApiCallProcess = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Products()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(orange)),
                            child: Text(
                              "SAVE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String dropdownclient;

class SelectClient extends StatefulWidget {
  @override
  _SelectClientState createState() => _SelectClientState();
}

class _SelectClientState extends State<SelectClient> {
  static List DropDownItems = employees.client.map((String val) {
    return new DropdownMenuItem<String>(
      value: val,
      child: new Text(val),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButton(
        elevation: 0,
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(color: Colors.transparent),
        iconEnabledColor: Colors.black,
        iconSize: 25.0,
        value: dropdownclient,
        onChanged: (newVal) {
          setState(() {
            dropdownclient = newVal;
          });
        },
        items: DropDownItems,
        hint: Text(
          "Select Client",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
