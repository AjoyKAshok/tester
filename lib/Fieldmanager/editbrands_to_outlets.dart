import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Fieldmanager/products.dart';
import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/api/FMapi/outletapi.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:file_picker/file_picker.dart';
import '../api/api_service2.dart';
import 'category_map.dart';
import 'dart:convert';
import 'package:merchandising/api/FMapi/add_categoryapi.dart';
import 'dart:io';
import 'package:merchandising/api/FMapi/add_outlet_brandapi.dart';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/FMapi/outlet brand mappingapi.dart';
import 'package:merchandising/api/FMapi/add_planoapi.dart';
import 'package:merchandising/api/FMapi/add_shareofshelfapi.dart';
import 'package:merchandising/utils/background.dart';

int filefor;
List<String> image = [" "];
List outletlist = outletdata.outletname.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();
String selectedoutlets;

List<int> selectbrands;
List brandlist = Category.name.map((String val) {
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

  List<TextEditingController> target = [];

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
            title: Column(
              children: [
                Text(
                  'Add Activities',
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
                          SelectClient(),
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
                              hint: Text("Select Categories"),
                              searchHint: "Select Categories",
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  selectbrands = value;
                                  print(selectbrands);
                                });
                                pickedfile.name = [];
                                pickedfile.bytes = [];
                                for (int i = 0; i < selectbrands.length; i++) {
                                  pickedfile.name.add("");
                                  pickedfile.bytes.add("");
                                }
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
                                                          "Category:",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '${Category.name[selectbrands[index]]}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 40.0,
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(
                                                      top: 10.0, bottom: 10.0),
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
                                                          "Minimum Target for share of shelf",
                                                      hintStyle: TextStyle(
                                                        color: Colors.black26,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            "Upload Planogram Image",
                                                            style: TextStyle(
                                                                fontSize: 14.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          filefor = index;
                                                          FilePickerResult
                                                              picked =
                                                              await getFile();
                                                          if (picked != null) {
                                                            File file = File(
                                                                picked
                                                                    .files
                                                                    .single
                                                                    .path);
                                                            var image = file
                                                                .readAsBytesSync();
                                                            pickedfile.bytes[
                                                                    index] =
                                                                base64Encode(
                                                                    image);
                                                            print(pickedfile
                                                                .bytes[index]);
                                                            //image[selectbrands[index]] = base64Encode(imagebytes);
                                                          }
                                                        },
                                                        child: Icon(CupertinoIcons
                                                            .folder_badge_plus)),
                                                  ],
                                                ),
                                                pickedfile.name[index] != ""
                                                    ? Center(
                                                        child: Text(pickedfile
                                                            .name[index]))
                                                    : SizedBox()
                                              ],
                                            ));
                                      }),
                                )
                              : SizedBox(),
                          TextButton(
                            onPressed: () async {
                              if (validateform() == true) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                brandmap.outletid = outletdata.outletid[
                                    outletdata.outletname
                                        .indexOf(selectedoutlets)];
                                currentoutletid = brandmap.outletid;
                                print("outlet id: is $currentoutletid");
                                await getmappedoutlets();
                                CategoryOutletmap.outletid =
                                    outletdata.outletid[outletdata.outletname
                                        .indexOf(selectedoutlets)];
                                AddShareData.outletid =
                                    CategoryOutletmap.outletid;
                                CategoryOutletmap.clientid =
                                    'Emp${dropdownclient.replaceAll(new RegExp(r'[^0-9]'), '')}';
                                CategoryOutletmap.categoryid = [];
                                for (int u = 0; u < selectbrands.length; u++) {
                                  print(
                                      '${Category.name[selectbrands[u]]} : ${mapping.categoryname.contains(Category.name[selectbrands[u]])}');
                                  if (mapping.categoryname.contains(
                                          Category.name[selectbrands[u]]) !=
                                      true) {
                                    CategoryOutletmap.categoryid
                                        .add(Category.id[selectbrands[u]]);
                                  }
                                }
                                if (CategoryOutletmap.categoryid.length > 0) {
                                  await addcategoryoutletmap();
                                  await getmappedoutlets();
                                }
                                int i = 0;
                                AddPlanooutlet.outletpdtmapid = [];
                                AddPlanooutlet.planoimg = [];
                                AddShareData.target = [];
                                AddPlanooutlet.cid = [];
                                for (int u = 0; u < selectbrands.length; u++) {
                                  print('loop no : $u');
                                  if (mapping.outletid[u] ==
                                      brandmap.outletid) {
                                    print("cat: ${mapping.outletid[u]}");
                                    print(mapping.opmid[mapping.categoryname
                                        .indexOf(
                                            Category.name[selectbrands[i]])]);
                                    AddPlanooutlet.cid
                                        .add(Category.id[selectbrands[u]]);
                                    AddPlanooutlet.outletpdtmapid.add(mapping
                                            .opmid[
                                        mapping.categoryname.indexOf(
                                            Category.name[selectbrands[i]])]);
                                    AddPlanooutlet.planoimg.add(
                                        'data:image/jpeg;base64,${pickedfile.bytes[i]}');
                                    AddShareData.target
                                        .add(int.parse(target[i].text));
                                    i++;
                                  }
                                }
                                AddPlanooutlet.outletid = outletdata.outletid[
                                    outletdata.outletname
                                        .indexOf(selectedoutlets)];
                                await addplanooutletmap();
                                AddShareData.categories = AddPlanooutlet.cid;
                                AddShareData.mappingid =
                                    AddPlanooutlet.outletpdtmapid;
                                await addShareofshelffm();
                                currentoutletid = null;
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Products()));
                              }
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

class pickedfile {
  static List<String> name = [];
  static List<dynamic> bytes = [];
}
