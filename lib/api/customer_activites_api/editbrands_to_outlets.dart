import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Fieldmanager/products.dart';
import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Promotion%20Check.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/FMapi/brand_detailsapi.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:merchandising/api/FMapi/add_outlet_brandapi.dart';

List outletlist = outletdata.outletname.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();
String selectedoutlets;

List<int> selectbrands;
List brandlist = BrandData.brandname.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

class EditBrandstoOutlet extends StatefulWidget {
  @override
  _EditBrandstoOutletState createState() => _EditBrandstoOutletState();
}

class _EditBrandstoOutletState extends State<EditBrandstoOutlet> {
  bool isApiCallProcess = false;
  FilePickerResult _file;

  Future getFile() async {
    FilePickerResult file = await FilePicker.platform.pickFiles();
    setState(() {
      _file = file;
    });
    return _file;
  }

  List<TextEditingController> shelf = [];
  List<TextEditingController> target = [];
  List<String> image = [" "];

  GlobalKey<FormState> brandkey = GlobalKey<FormState>();

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
              'Edit Brands to Outlets',
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
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SearchableDropdown.multiple(
                              underline: SizedBox(),
                              items: brandlist,
                              selectedItems: selectbrands,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Select Brands"),
                              ),
                              searchHint: "Select Brands",
                              onChanged: (value) {
                                setState(() {
                                  selectbrands = value;
                                  print(selectbrands);
                                });
                              },
                              closeButton: (selectedItems) {
                                return (selectedItems.isNotEmpty
                                    ? "Save ${selectedItems.length == 1 ? '"' + brandlist[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                    : "Save without selection");
                              },
                              isExpanded: true,
                            ),
                          ),
                          selectbrands != null
                              ? Form(
                                  key: brandkey,
                                  child: new ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: selectbrands.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        shelf.add(TextEditingController());
                                        target.add(TextEditingController());
                                        return Container(
                                            padding: EdgeInsets.all(10.0),
                                            margin: EdgeInsets.only(
                                                bottom: 5.0, top: 5.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          "Brand:",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '${BrandData.brandname[selectbrands[index]]}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 40.0,
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0, top: 10.0),
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: pink,
                                                  ),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: shelf[index],
                                                    cursorColor: grey,
                                                    validator: (input) => !input
                                                            .isNotEmpty
                                                        ? "shelf should not be empty"
                                                        : null,
                                                    decoration:
                                                        new InputDecoration(
                                                      border: InputBorder.none,
                                                      focusColor: orange,
                                                      hintText:
                                                          "Shelf size in meters",
                                                      hintStyle: TextStyle(
                                                        color: grey,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 40.0,
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: pink,
                                                  ),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: target[index],
                                                    cursorColor: grey,
                                                    validator: (input) => !input
                                                            .isNotEmpty
                                                        ? "target should not be empty"
                                                        : null,
                                                    decoration:
                                                        new InputDecoration(
                                                      border: InputBorder.none,
                                                      focusColor: orange,
                                                      hintText:
                                                          "Minimum Target required in percentage",
                                                      hintStyle: TextStyle(
                                                        color: grey,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "Upload Image",
                                                        style: TextStyle(
                                                            fontSize: 14.0),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          FilePickerResult
                                                              picked =
                                                              await getFile();
                                                          if (picked != null) {
                                                            File file = File(
                                                                picked
                                                                    .files
                                                                    .single
                                                                    .path);
                                                            var imagebytes = file
                                                                .readAsBytesSync();
                                                            image[selectbrands[
                                                                    index]] =
                                                                base64Encode(
                                                                    imagebytes);
                                                            //image[selectbrands[index]] = base64Encode(imagebytes);
                                                          }
                                                        },
                                                        child: Icon(CupertinoIcons
                                                            .folder_badge_plus)),
                                                  ],
                                                ),
                                              ],
                                            ));
                                      }),
                                )
                              : SizedBox(),
                          TextButton(
                            onPressed: () async {
                              if (validateform() == true)
                                setState(() {
                                  isApiCallProcess = true;
                                });

                              for (int u = 0; u < selectbrands.length; u++) {
                                brandmap.outletid = outletdata.outletid[
                                    outletdata.outletname
                                        .indexOf(selectedoutlets)];
                                brandmap.brandid
                                    .add(BrandData.brandid[selectbrands[u]]);
                                brandmap.shelf.add(shelf[u].text);
                                brandmap.target.add(target[u].text);
                                brandmap.myfile.add(image[selectbrands[u]]);
                              }
                              await addbrandmap();
                              print(brandmap.brandid);
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

  bool validateform() {
    final form = brandkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
