import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/api/api_service.dart';
import 'package:merchandising/api/customer_activites_api/add_planogramapi.dart';
import 'package:merchandising/network/NetworkStatusService.dart';
import 'package:merchandising/utils/background.dart';
import 'package:provider/provider.dart';
import '../../ConstantMethods.dart';
import 'package:flutter/cupertino.dart';
import '../../ProgressHUD.dart';
import 'MenuContent.dart';
import 'package:merchandising/model/camera.dart';
import 'package:camera/camera.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Customers Activities.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/customer_activites_api/addplanogram.dart';
import '../../api/api_service2.dart';

// String url =
//     "http://157.245.55.88/planogram_image/${GetPlanoDetails.imageurl.toString()}";

String ontap;
int selectedindex;
List<File> afterimages = [];
List<File> beforeimages = [];

List<String> afterimagesencode = [];
List<String> beforeimagesencode = [];

List<Map<String, dynamic>> planogram_items = [];
Map<String, dynamic> itemMap;

class Planogram1 extends StatefulWidget {
  final String from;

  Planogram1(this.from);

  @override
  State<Planogram1> createState() => _Planogram1State();
}

class _Planogram1State extends State<Planogram1> {
  List<String> planolist = GetPlanoDetails.categoryname;
  List<CameraDescription> cameras = [];
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<String> productdata;
  List<String> _filterList;
  List<int> _filterindex;
  bool connection = false;

  @override
  void initState() {
    super.initState();
    // print('Planogram New: $url');
    if (widget.from != null) {
      loadPlanogramValues();
    }
    print(
        "before image length..${beforeimages.length}...${GetPlanoDetails.categoryname.length}");
  }

  loadPlanogramValues() async {
    setState(() {
      isApicallProcess = true;
    });
    await getPlanogramDetails();

    setState(() {
      planolist = GetPlanoDetails.categoryname;

      productdata = planolist;

      isApicallProcess = false;
    });

    beforeimages = [];
    afterimages = [];
    beforeimagesencode = [];
    afterimagesencode = [];
    for (int i = 0; i < GetPlanoDetails.brandname.length; i++) {
      beforeimages.add(File('dummy.png'));
      afterimages.add(File('dummy.png'));
      beforeimagesencode.add('dummy.png');
      afterimagesencode.add('dummy.png');
    }
    print(
        "before image length..${beforeimages.length}...${GetPlanoDetails.categoryname.length}");
  }

  _PlanogramCheckPhase1State() {
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

  bool isApicallProcess = false;

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
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        automaticallyImplyLeading: false,
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
          children: [
            Text(
              'Planogram New',
              style: TextStyle(color: orange),
            ),
            Spacer(),
            SubmitButton(
              onpress: () async {
                setState(() {
                  isApicallProcess = true;
                });
                AddPlanogramData.beforeimage = beforeimagesencode;
                AddPlanogramData.afterimage = afterimagesencode;
                AddPlanogramData.outletid = currentoutletid;
                AddPlanogramData.timesheetid = currenttimesheetid;
                AddPlanogramData.categoryname = GetPlanoDetails.categoryname;
                AddPlanogramData.categoryid = GetPlanoDetails.categoryid;
                for (var i = 0; i < GetPlanoDetails.categoryname.length; i++) {
                  String cName = AddPlanogramData.categoryname[i];
                  int cId = AddPlanogramData.categoryid[i];
                  String bImage = AddPlanogramData.beforeimage[i];
                  String aImage = AddPlanogramData.afterimage[i];
                  File bFile = File(bImage);
                  // String bFileName = bFile.path;
                  File aFile = File(aImage);
                  List<int> bImageBytes = bFile.readAsBytesSync();
                  List<int> aImageBytes = aFile.readAsBytesSync();
                  String base64ImageBefore = base64Encode(bImageBytes);
                  String base64ImageAfter = base64Encode(aImageBytes);

                  itemMap = {
                    'category_name': cName,
                    'category_id': cId,
                    'before_image': bImage,
                    'after_image': aImage,
                  };

                  AddPlanogramData.planogram_items.add(itemMap);
                }

                // GetPlanoDetails.planogram_items;
                AddPlanogramData.outletpdtmapid = GetPlanoDetails.opm;

                // AddPlanogramData.planoimage = GetPlanoDetails.image;

                // print('Before Images: ${AddPlanogramData.beforeimage}');
                // print('After Images: ${AddPlanogramData.afterimage}');
                await addPlanogramdataDetails(
                    connection,
                    AddPlanogramData.planogram_items,
                    GetPlanoDetails.categoryname.length);
                // planocheck=true;
                setState(() {
                  isApicallProcess = false;
                });
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CustomerActivities()));
                }
              },
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
            Align(
              alignment: Alignment.center,
              child: Text(
                "No Records Found",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            BackGround(),
            ProgressHUD(
              opacity: 0.3,
              inAsyncCall: isApicallProcess,
              child: Column(
                children: [
                  SizedBox(
                    height: onlinemode.value ? 0 : 25,
                  ),
                  OutletDetails(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
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
                  ),
                ],
              ),
            ),
            NBlFloatingButton(),
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: pink, borderRadius: BorderRadius.circular(25.0)),
        child: Row(
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
                  hintText: 'Search by Category name',
                  hintStyle: TextStyle(color: orange),
                  border: InputBorder.none,
                  icon: Icon(
                    CupertinoIcons.search,
                    color: orange,
                  ),
                  isCollapsed: true,
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
        ));
  }

  Widget _createListView() {
    if (GetPlanoDetails.categoryname.length > 0)
      return new Flexible(
        child: new ListView.builder(
            shrinkWrap: true,
            itemCount: GetPlanoDetails.categoryname.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    color: pink, borderRadius: BorderRadius.circular(10)),
                //height: MediaQuery.of(context).size.height/4,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${GetPlanoDetails.categoryname[index]}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: orange),
                      ),
                    ),
                    Table(
                      columnWidths: {
                        0: FractionColumnWidth(.45),
                        1: FractionColumnWidth(.45),
                      },
                      children: [
                        TableRow(
                          children: [
                            Column(
                              children: [
                                // SizedBox(
                                //   height: 10.0,
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        print("before...");
                                        print('Planogram New: $index');
                                        Selectedscreen = "planogram";
                                        WidgetsFlutterBinding
                                            .ensureInitialized();

                                        ontap = 'before';
                                        selectedindex = index;
                                        print('Planogram New: $selectedindex');
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          TakePictureScreen()));
                                        });
                                      },
                                      icon: Icon(
                                        CupertinoIcons.photo_camera_solid,
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Text(
                                        "Before",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                if (beforeimages.length ==
                                    GetPlanoDetails.categoryname.length)
                                  Container(
                                    margin: EdgeInsets.only(top: 0),
                                    // ignore: unrelated_type_equality_checks
                                    child: beforeimages[index].toString() !=
                                            'File: \'dummy.png\''
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PreveiwScreen(
                                                    input: beforeimages[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image(
                                              height: 100,
                                              image: FileImage(
                                                  beforeimages[index]),
                                            ),
                                          )
                                        : Image(
                                            height: 100,
                                            image: AssetImage(
                                                'images/capture.png'),
                                          ),
                                  ),
                              ],
                            ),
                            Column(
                              children: [
                                // SizedBox(
                                //   height: 10.0,
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Selectedscreen = "planogram";
                                        ontap = 'after';
                                        selectedindex = index;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        TakePictureScreen()));
                                      },
                                      icon: Icon(
                                        CupertinoIcons.photo_camera_solid,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Text(
                                        "After",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                if (afterimages.length ==
                                    GetPlanoDetails.categoryname.length)
                                  Container(
                                    margin: EdgeInsets.only(top: 0),
                                    // ignore: unrelated_type_equality_checks
                                    child: afterimages[index].toString() !=
                                            'File: \'dummy.png\''
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          PreveiwScreen(
                                                            input: afterimages[
                                                                index],
                                                          )));
                                            },
                                            child: Image(
                                              height: 100,
                                              image:
                                                  FileImage(afterimages[index]),
                                            ),
                                          )
                                        : Image(
                                            width: 100,
                                            image: AssetImage(
                                                'images/capture.png'),
                                          ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      );
    else
      return _noRecordsFoundView();
  }

  Widget _performSearch() {
    _filterList = [];
    _filterindex = [];
    for (int i = 0; i < GetPlanoDetails.categoryname.length; i++) {
      var item = GetPlanoDetails.categoryname[i];
      if (item.trim().toLowerCase().contains(_query.trim().toLowerCase())) {
        _filterList.add(item);
        _filterindex.add(i);
      }
    }
    if (_filterList.length > 0)
      return _createFilteredListView();
    else
      return _noRecordsFoundView();
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

  Widget _createFilteredListView() {
    return Flexible(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: pink, borderRadius: BorderRadius.circular(10)),
              //height: MediaQuery.of(context).size.height/4,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${GetPlanoDetails.categoryname[_filterindex[index]]}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: orange),
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: FractionColumnWidth(.45),
                      1: FractionColumnWidth(.45),
                    },
                    children: [
                      TableRow(
                        children: [
                          Column(
                            children: [
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Selectedscreen = "planogram";
                                      ontap = 'before';
                                      selectedindex = _filterindex[index];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TakePictureScreen()));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.photo_camera_solid,
                                    ),
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      "Before",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0),
                                // ignore: unrelated_type_equality_checks
                                child: beforeimages[_filterindex[index]]
                                            .toString() !=
                                        'File: \'dummy.png\''
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PreveiwScreen(
                                                            input: beforeimages[
                                                                _filterindex[
                                                                    index]],
                                                          )));
                                        },
                                        child: Image(
                                          height: 100,
                                          image: FileImage(beforeimages[
                                              _filterindex[index]]),
                                        ),
                                      )
                                    : Image(
                                        height: 100,
                                        image: AssetImage('images/capture.png'),
                                      ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Selectedscreen = "planogram";
                                      ontap = 'after';
                                      selectedindex = _filterindex[index];
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TakePictureScreen()));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.photo_camera_solid,
                                    ),
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      "After",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0),
                                // ignore: unrelated_type_equality_checks
                                child: afterimages[_filterindex[index]]
                                            .toString() !=
                                        'File: \'dummy.png\''
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PreveiwScreen(
                                                            input: afterimages[
                                                                _filterindex[
                                                                    index]],
                                                          )));
                                        },
                                        child: Image(
                                          height: 100,
                                          image: FileImage(
                                              afterimages[_filterindex[index]]),
                                        ),
                                      )
                                    : Image(
                                        width: 100,
                                        image: AssetImage('images/capture.png'),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({@required this.onpress});

  final onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
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

class VeiwImage extends StatelessWidget {
  VeiwImage({this.url});

  var url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            ),
          ),
          imageProvider: NetworkImage(
            url,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Planogram1(null)));
                },
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.arrow_back,
                  color: orange,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Planogram1(null)));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
