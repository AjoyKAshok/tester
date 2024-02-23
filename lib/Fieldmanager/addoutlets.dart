import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/HR/HRdashboard.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/Fieldmanager/FMdashboard.dart';
import 'package:merchandising/api/FMapi/addoutletapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'addjp.dart';

class AddOutlets extends StatefulWidget {
  @override
  _AddOutletsState createState() => _AddOutletsState();
}

List addstoretooutlets = store.addoutlet.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

class _AddOutletsState extends State<AddOutlets> {
  TextEditingController name = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.name)
      : TextEditingController();
  TextEditingController latitude = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.lat)
      : TextEditingController();
  TextEditingController longitude = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.long)
      : TextEditingController();
  TextEditingController area = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.area)
      : TextEditingController();
  TextEditingController city = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.city)
      : TextEditingController();
  TextEditingController country = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.country)
      : TextEditingController();
  TextEditingController state = updateoutlet.outletedit
      ? TextEditingController(text: updatingoutlet.state)
      : TextEditingController();
  GlobalKey<FormState> addoutlets = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  String outlet_id;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: containerscolor,
            iconTheme: IconThemeData(color: orange),
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      updateoutlet.outletedit ? 'Update Outlet' : 'Add Outlets',
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
              SingleChildScrollView(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: addoutlets,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      updateoutlet.outletedit
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${updatingoutlet.outletname}',
                                    style: TextStyle(color: orange),
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    controller: name,
                                    cursorColor: grey,
                                    validator: (input) => !input.isNotEmpty
                                        ? "Name not be empty"
                                        : null,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusColor: orange,
                                      hintText: "Store name",
                                      hintStyle: TextStyle(
                                        color: grey,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(3.0),
                              child: SearchableDropdown.single(
                                underline: SizedBox(),
                                items: addstoretooutlets,
                                value: outlet_id,
                                hint: "Select outlet",
                                searchHint: "Select outlet",
                                onChanged: (value) {
                                  setState(() {
                                    outlet_id = value;
                                    print(value);
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: latitude,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "Latitude should not be empty"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Outlet latitude",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          validator: (input) => !input.isNotEmpty
                              ? "Longitude should not be empty"
                              : null,
                          controller: longitude,
                          cursorColor: grey,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Outlet longitude",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: area,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "Outlet Area should not be empty"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Outlet Area",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: city,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "Outlet City should be valid"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Outlet City",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: state,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "Outlet State should be valid"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: "Outlet State",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: country,
                          cursorColor: grey,
                          validator: (input) => !input.isNotEmpty
                              ? "Outlet Country should not be empty"
                              : null,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusColor: orange,
                            hintText: 'Outlet Country',
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            print("Name ... ${name.text}");

                            if (validateform()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              for (int u = 0; u < store.addoutlet.length; u++) {
                                if (store.addoutlet[u] == outlet_id) {
                                  outletdetails.outletname = store.storeid[u];
                                }
                              }
                              if (updateoutlet.outletedit) {
                                updateoutlet.name = name.text;
                              }
                              outletdetails.outletlat = latitude.text;
                              outletdetails.outletlong = longitude.text;
                              outletdetails.outletarea = area.text;
                              outletdetails.outletcity = city.text;
                              outletdetails.outletstate = state.text;
                              outletdetails.outletcountry = country.text;
                              await addoutletdetails();
                              await getFMoutletdetails();
                              outlets = outletdata.outletname_notempty.map((String val) {
                                return new DropdownMenuItem<String>(
                                  value: val,
                                  child: new Text(val),
                                );
                              }).toList();
                              setState(() {
                                isApiCallProcess = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          // ignore: non_constant_identifier_names
                                          (BuildContextcontext) =>
                                              FieldManagerDashBoard()));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('SAVE'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }

  bool validateform() {
    final form = addoutlets.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
