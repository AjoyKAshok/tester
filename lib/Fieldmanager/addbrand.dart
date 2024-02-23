import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/Fieldmanager/products.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/FMapi/add_brandapi.dart';
import 'package:merchandising/api/FMapi/brand_detailsapi.dart';
import 'package:merchandising/utils/background.dart';

class AddBrand extends StatefulWidget {
  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  TextEditingController brandname = TextEditingController();
  GlobalKey<FormState> products = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  //String brands;
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
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: containerscolor,
            iconTheme: IconThemeData(color: orange),
            title: Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Add Brand',
                      style: TextStyle(color: orange),
                    ),
                    EmpInfo()
                  ],
                ),
              ],
            ),
          ),
          // drawer: Drawer(
          //   child: Menu(),
          // ),
          body: Stack(
            children: [
              BackGround(),
              ProgressHUD(
                inAsyncCall: isApiCallProcess,
                opacity: 0.3,
                child: SingleChildScrollView(
                    child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: products,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: brandname,
                            cursorColor: grey,
                            validator: (input) => !input.isNotEmpty
                                ? "Brand Name  should not be empty"
                                : null,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusColor: orange,
                              hintText: "Brand Name",
                              hintStyle: TextStyle(
                                color: grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        SelectClient(),
                        SelectFieldManager(),
                        SelectSalesManager(),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (validateform() == true) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                BrandDetails.brandname = brandname.text;
                                BrandDetails.clientempid =
                                    'Emp${dropdownclient.replaceAll(new RegExp(r'[^0-9]'), '')}';
                                BrandDetails.fieldmanagerempid =
                                    'RMS${dropdownfieldmanager.replaceAll(new RegExp(r'[^0-9]'), '')}';
                                BrandDetails.salesempid =
                                    'Emp${dropdownsalesmanager.replaceAll(new RegExp(r'[^0-9]'), '')}';
                                await addbranddetails();
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                if (dropdownclient != null &&
                                    dropdownsalesmanager != null &&
                                    dropdownfieldmanager != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Products()));
                                } else
                                  Flushbar(
                                    message: dropdownclient == null
                                        ? "Client cannot be empty"
                                        : dropdownfieldmanager == null
                                            ? "Field Manager cannot be empty"
                                            : "Sales Manager cannot be empty",
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10, top: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('ADD'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              )
            ],
          )),
    );
  }

  bool validateform() {
    final form = products.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
        iconEnabledColor: orange,
        iconSize: 35.0,
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

String dropdownfieldmanager;

class SelectFieldManager extends StatefulWidget {
  @override
  _SelectFieldManagerState createState() => _SelectFieldManagerState();
}

class _SelectFieldManagerState extends State<SelectFieldManager> {
  static List DropDownItems = employees.feildmanagers.map((String val) {
    return new DropdownMenuItem<String>(
      value: val,
      child: new Text(val),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButton(
        elevation: 0,
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(color: Colors.transparent),
        iconEnabledColor: orange,
        iconSize: 35.0,
        value: dropdownfieldmanager,
        onChanged: (newVal) {
          setState(() {
            dropdownfieldmanager = newVal;
          });
        },
        items: DropDownItems,
        hint: Text(
          "Select Field Manager",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

String dropdownsalesmanager;

class SelectSalesManager extends StatefulWidget {
  @override
  _SelectSalesManagerState createState() => _SelectSalesManagerState();
}

class _SelectSalesManagerState extends State<SelectSalesManager> {
  static List DropDownItems = employees.sales.map((String val) {
    return new DropdownMenuItem<String>(
      value: val,
      child: new Text(val),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButton(
        elevation: 0,
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(color: Colors.transparent),
        iconEnabledColor: orange,
        iconSize: 35.0,
        value: dropdownsalesmanager,
        onChanged: (newVal) {
          setState(() {
            dropdownsalesmanager = newVal;
          });
        },
        items: DropDownItems,
        hint: Text(
          "Select Sales Manager",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
