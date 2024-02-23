import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/utils/background.dart';
import 'package:flushbar/flushbar.dart';
import 'package:merchandising/network/NetworkStatusService.dart';
import 'package:provider/provider.dart';
import 'Customers Activities.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:merchandising/model/camera.dart';
import 'package:merchandising/api/customer_activites_api/add_promotionapi.dart';
import 'package:camera/camera.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';

File capturedimagepromotion = File('dummy.txt');
String Selectedreason;
var selectedbrand;
//int selectedindex;
var selectedcategory;

var selectedproduct;
List reasonItems = [
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

List DropDownItems = PromoData.productname.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();
List<String> productname = [];
bool isSwitched = false;

class PromotionCheck extends StatefulWidget {
  final String from;

  PromotionCheck(this.from);

  @override
  _PromotionCheckState createState() => _PromotionCheckState();
}

class _PromotionCheckState extends State<PromotionCheck> {
  GlobalKey<FormState> keyone = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool connection = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.from != null) {
      loadPromotionValues();
    }
  }

  loadPromotionValues() async {
    setState(() {
      isApiCallProcess = true;
    });
    isSwitched = false;
    capturedimagepromotion = File('dummy.txt');
    selectedproduct = null;
    if (productname.isNotEmpty) {
      print("its not empty");
      productname.clear();
    }
    print("capturedimagepromotion....$capturedimagepromotion");
    await getPromotionDetails();

    setState(() {
      productname = PromoData.productname.toSet().toList();
      isApiCallProcess = false;
    });
    print("PRODUCT NAME...$productname");
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: containerscolor,
          iconTheme: IconThemeData(color: orange),
          leading: widget.from == 'customer' ? IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CustomerActivities()));
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Color(0XFF909090),
                  ) : SizedBox(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Promotion Check',
                style: TextStyle(color: orange),
              ),
              SubmitButton()
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: onlinemode.value ? 0 : 25,
                      ),
                      OutletDetails(),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        child: Form(
                          key: keyone,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 30,
                                width: 120,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                ),
                                child: Center(
                                    child: Text(
                                  "Promotion",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    color: pink,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 5.0, 5.0, 5.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: const [
                                              Expanded(
                                                child: Text(
                                                  "Select Product",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: productname
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      '$item',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedproduct,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedproduct = value as String;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            // size: 20,
                                          ),
                                          // iconSize: 20,
                                          iconEnabledColor: orange,
                                          iconDisabledColor: orange,
                                          buttonHeight: 50,
                                          buttonWidth: 240,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            color: Colors.white,
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,

                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            color: Colors.white,
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(0),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(0, 0),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 10.0),
                                    //   margin: EdgeInsets.fromLTRB(
                                    //       5.0, 5.0, 5.0, 5.0),
                                    //   width: double.infinity,
                                    //   decoration: new BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius:
                                    //           BorderRadius.circular(10.0)),
                                    //   child: DropdownButton(
                                    //     underline: SizedBox(),
                                    //     elevation: 0,
                                    //
                                    //     dropdownColor: Colors.white,
                                    //     isExpanded: true,
                                    //     iconEnabledColor: orange,
                                    //     iconSize: 35.0,
                                    //
                                    //     value: selectedproduct,
                                    //       key: (selectedproduct != null) ? Key(selectedproduct) : UniqueKey(),
                                    //     onChanged: (newVal) {
                                    //       setState(() {
                                    //         selectedproduct = newVal;
                                    //         //selectedindex = PromoData.productname.indexOf(newVal);
                                    //         // selectedbrand =
                                    //       });
                                    //     },
                                    //     items: productname.map((String val) {
                                    //       return new DropdownMenuItem<String>(
                                    //         value: val,
                                    //         child: new Text(val),
                                    //       );
                                    //     }).toList(),
                                    //     hint: Text(
                                    //       "Select Product",
                                    //       style: TextStyle(color: Colors.grey),
                                    //     ),
                                    //   ),
                                    // ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(left:10.0,top: 10.0),
                                    //   child: Text("Brand : $selectedbrand",style: TextStyle(color: orange,fontSize: 16),),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left:10.0,top: 10.0),
                                    //   child: Text("Category : $selectedcategory",style: TextStyle(color: orange,fontSize: 16),),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Available ?",
                                            style: TextStyle(
                                                color: orange, fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: Switch(
                                              value: isSwitched,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched = value;
                                                });
                                              },
                                              inactiveTrackColor: Colors.green,
                                              activeColor: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            isSwitched != true
                                                ? "Capture Image :"
                                                : "Reason :",
                                            style: TextStyle(
                                                color: orange, fontSize: 16),
                                          ),
                                          Spacer(),
                                          isSwitched != true
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child:
                                                          // ignore: unrelated_type_equality_checks
                                                          capturedimagepromotion
                                                                      .toString() !=
                                                                  'File: \'dummy.txt\''
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (BuildContext context) => PreveiwScreen(
                                                                                  input: capturedimagepromotion,
                                                                                )));
                                                                  },
                                                                  child: Image(
                                                                    height: 50,
                                                                    width: 50,
                                                                    image: FileImage(
                                                                        capturedimagepromotion),
                                                                  ),
                                                                )
                                                              : Image(
                                                                  width: 50,
                                                                  image: AssetImage(
                                                                      'images/capture.png'),
                                                                ),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .photo_camera_solid,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                        onPressed: () {
                                                          _showSelectionDialog(
                                                              context);
                                                        }),
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: 50,
                                                  child: DropdownButton(
                                                    elevation: 0,
                                                    dropdownColor: Colors.white,
                                                    underline: SizedBox(),
                                                    //isExpanded: true,
                                                    iconEnabledColor: orange,
                                                    iconSize: 35.0,
                                                    value: Selectedreason,
                                                    onChanged: (newVal) {
                                                      setState(() {
                                                        Selectedreason = newVal;
                                                      });
                                                    },
                                                    items: reasonItems,
                                                    hint: Text(
                                                      "Select Reason",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            if (selectedproduct != null) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              AddPromo.productid = [];
                              AddPromo.reason = [];
                              AddPromo.checkvalue = [];
                              int result;

                              if (!isSwitched &&
                                      capturedimagepromotion.toString() !=
                                          'File: \'dummy.txt\'' ||
                                  isSwitched && Selectedreason != null) {
                                AddPromo.productid.add(PromoData.productid[
                                    PromoData.productname
                                        .indexOf(selectedproduct)]);
                                AddPromo.checkvalue
                                    .add(isSwitched != true ? 1 : 0);

                                var imagebytes = !isSwitched
                                    ? capturedimagepromotion.readAsBytesSync()
                                    : null;

                                AddPromo.reason.add(isSwitched != true
                                    ? 'data:image/jpeg;base64,${base64Encode(imagebytes)}'
                                    : '$Selectedreason');
                                result = await addPromotion(connection);
                              } else {
                                if (!isSwitched) {
                                  Flushbar(
                                    message:
                                        "Please capture the image before submitting",
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                } else {
                                  Flushbar(
                                    message: "Please Select Reason",
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                }
                              }

                              setState(() {
                                isApiCallProcess = false;
                              });
                              if (result == 200) {
                                Flushbar(
                                  message: "Data Updated",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              }
                            } else {
                              Flushbar(
                                message: "Please Select Product ",
                                duration: Duration(seconds: 3),
                              )..show(context);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(pink)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: orange),
                          )),
                    ],
                  ),
                ),
              ),
              NBlFloatingButton(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showSelectionDialog(BuildContext context) {
  FilePickerResult _file;
  Future getFile() async {
    FilePickerResult file = await FilePicker.platform.pickFiles();
    _file = file;
    return _file;
  }

  return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 180,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              padding: EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "From where do you want to take the photo?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Selectedscreen = "PromotionCheck";
                      WidgetsFlutterBinding.ensureInitialized();

                      // Obtain a list of the available cameras on the device.
                      final cameras = await availableCameras();

                      // Get a specific camera from the list of available cameras.
                      final firstCamera = cameras.first;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TakePictureScreen()));
                    },
                    child: Container(
                      color: Colors.white,
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.camera_fill,
                            size: 40,
                            color: orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Camera",
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult picked = await getFile();
                      if (picked != null) {
                        File file = File(picked.files.single.path);
                        capturedimagepromotion = file;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PromotionCheck(null)));
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.doc_circle_fill,
                            size: 40,
                            color: orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("File Explorer"),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Note* If you select File Explorer you have to select the images that contain watermark of date and time ",
                    style: TextStyle(
                      fontSize: 12,
                      color: orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        );
      });
}

class PreveiwScreen extends StatelessWidget {
  PreveiwScreen({@required this.input});

  File input;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          GestureDetector(
            onVerticalDragEnd: (details) {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: PhotoView(
                  loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  imageProvider: FileImage(input)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                  backgroundColor: pink,
                  child: Icon(Icons.check, size: 35, color: orange),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PromotionCheck(null)));
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        promocheck = true;
        selectedproduct = null;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CustomerActivities()));
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
    );
  }
}
