import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/api/FMapi/add_planoapi.dart';
import 'package:merchandising/Fieldmanager/products.dart';
import 'package:merchandising/api/FMapi/outlet brand mappingapi.dart';

List<String> image = [" "];
int filefor;
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

class AddPlanoFM extends StatefulWidget {
  @override
  _AddPlanoFMState createState() => _AddPlanoFMState();
}

class _AddPlanoFMState extends State<AddPlanoFM> {
  FilePickerResult _file;

  Future getFile() async {
    FilePickerResult file = await FilePicker.platform.pickFiles();
    setState(() {
      _file = file;
      pickedfile.name[filefor] = file.names.toString();
    });
    return _file;
  }

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
              'Add Planogram to Outlets',
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
                            margin: EdgeInsets.only(top: 5),
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
                                pickedfile.name = [];
                                pickedfile.bytes = [];
                                for (int i = 0;
                                    i < selectcategory.length;
                                    i++) {
                                  pickedfile.name.add("");
                                  pickedfile.bytes.add("");
                                }
                              },
                              closeButton: (selectedItems) {
                                return (selectedItems.isNotEmpty
                                    ? "Save ${selectedItems.length == 1 ? '"' + categorylist[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                    : "Save without selection");
                              },
                              isExpanded: true,
                            ),
                          ),
                          selectcategory != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: Text(
                                    "Please select the planogram Images for the following",
                                    style: TextStyle(color: orange),
                                  ),
                                )
                              : SizedBox(),
                          selectcategory != null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: selectcategory.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Text(
                                                  "${Category.name[selectcategory[index]]}",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  filefor = index;
                                                  FilePickerResult picked =
                                                      await getFile();
                                                  if (picked != null) {
                                                    File file = File(picked
                                                        .files.single.path);
                                                    var image =
                                                        file.readAsBytesSync();
                                                    pickedfile.bytes[index] =
                                                        base64Encode(image);
                                                  }
                                                },
                                                child: Icon(CupertinoIcons
                                                    .folder_badge_plus),
                                              )
                                            ],
                                          ),
                                          pickedfile.name[index] != ""
                                              ? Text(pickedfile.name[index])
                                              : SizedBox()
                                        ],
                                      ),
                                    );
                                  })
                              : SizedBox(),
                          SizedBox(height: 5),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              AddPlanooutlet.outletid = mapping.outletid[
                                  mapping.outletname.indexOf(selectedoutlets)];

                              AddPlanooutlet.cid = [];
                              AddPlanooutlet.planoimg = [];
                              AddPlanooutlet.outletpdtmapid = [];

                              for (int u = 0; u < selectcategory.length; u++) {
                                AddPlanooutlet.cid.add(Category.id[u]);
                                AddPlanooutlet.planoimg.add(
                                    'data:image/jpeg;base64,${pickedfile.bytes}');
                                AddPlanooutlet.outletpdtmapid
                                    .add(mapping.opmid[u]);
                              }
                              await addplanooutletmap();

                              print(AddPlanooutlet.outletid);
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

class pickedfile {
  static List<String> name = [];
  static List<dynamic> bytes = [];
}
