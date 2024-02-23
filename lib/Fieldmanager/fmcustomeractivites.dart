import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:merchandising/ConstantMethods.dart";
import 'package:merchandising/api/api_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:merchandising/api/avaiablityapi.dart';
import 'package:merchandising/Fieldmanager/addjp.dart';
import 'package:merchandising/api/customer_activites_api/visibilityapi.dart';
import '../ConstantMethods.dart';
import 'package:merchandising/api/customer_activites_api/share_of_shelf_detailsapi.dart';
import 'package:merchandising/api/customer_activites_api/Competitioncheckapi.dart';
import 'package:merchandising/api/customer_activites_api/planogramdetailsapi.dart';
import 'package:merchandising/api/customer_activites_api/promotion_detailsapi.dart';
import 'package:merchandising/utils/background.dart';
import '../api/api_service2.dart';

String day;
String outletname;
bool isavaiability = false;
bool isvisibility = false;
bool issos = false;
bool isplano = false;
bool ispromotion = false;
bool iscomptn = false;
bool isexpiry = false;
bool ischecklist = false;

class FmActivites extends StatefulWidget {
  @override
  _FmActivitesState createState() => _FmActivitesState();
}

class _FmActivitesState extends State<FmActivites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerscolor,
        iconTheme: IconThemeData(color: orange),
        title: Column(
          children: [
            Text(
              'Activites',
              style: TextStyle(color: orange),
            ),
            EmpInfo()
          ],
        ),
      ),
      body: Stack(
        children: [
          BackGround(),
          Column(
            children: [
              OutletData(),
              Center(
                  child: Text(
                "Merchandiser activites",
                style: TextStyle(color: pink),
              )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = true;
                          isvisibility = false;
                          issos = false;
                          isplano = false;
                          ispromotion = false;
                          iscomptn = false;
                          isexpiry = false;
                          ischecklist = false;
                          ;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "Avaialability",
                        ontap: isavaiability,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = true;
                          issos = false;
                          isplano = false;
                          ispromotion = false;
                          iscomptn = false;
                          isexpiry = false;
                          ischecklist = false;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "Visibility",
                        ontap: isvisibility,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = false;
                          issos = true;
                          isplano = false;
                          ispromotion = false;
                          iscomptn = false;
                          isexpiry = false;
                          ischecklist = false;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "share of shelf",
                        ontap: issos,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = false;
                          issos = false;
                          isplano = true;
                          ispromotion = false;
                          iscomptn = false;
                          isexpiry = false;
                          ischecklist = false;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "Planogram",
                        ontap: isplano,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = false;
                          issos = false;
                          isplano = false;
                          ispromotion = true;
                          iscomptn = false;
                          isexpiry = false;
                          ischecklist = false;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "promotion Check",
                        ontap: ispromotion,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = false;
                          issos = false;
                          isplano = false;
                          ispromotion = false;
                          iscomptn = true;
                          isexpiry = false;
                          ischecklist = false;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "Competation Check",
                        ontap: iscomptn,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = false;
                          issos = false;
                          isplano = false;
                          ispromotion = true;
                          iscomptn = false;
                          isexpiry = true;
                          ischecklist = false;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "Expiry Info",
                        ontap: isexpiry,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isavaiability = false;
                          isvisibility = false;
                          issos = false;
                          isplano = false;
                          ispromotion = false;
                          iscomptn = false;
                          isexpiry = false;
                          ischecklist = true;
                        });
                      },
                      child: ActivitesSelector(
                        activityname: "CheckList",
                        ontap: ischecklist,
                      ),
                    ),
                  ],
                ),
              ),
              isavaiability ||
                      isvisibility ||
                      issos ||
                      isplano ||
                      ispromotion ||
                      iscomptn ||
                      ischecklist ||
                      isexpiry
                  ? Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.00),
                            color: pink,
                          ),
                          child: isavaiability
                              ? Avaialibility()
                              : isvisibility
                                  ? Visibility()
                                  : issos
                                      ? ShareOfShelf()
                                      : isplano
                                          ? Planogram()
                                          : ispromotion
                                              ? Promotion()
                                              : iscomptn
                                                  ? Competition()
                                                  : ischecklist
                                                      ? Checklist()
                                                      : SizedBox()),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}

class OutletData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.00),
        color: pink,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
              child: Text(
            "$outletname",
            style: TextStyle(fontSize: 16, color: orange),
          )),
          SingleChildScrollView(child: Text("Merchandiser ID : $currentid ")),
          Text("Day: $day")
        ],
      ),
    );
  }
}

class ActivitesSelector extends StatefulWidget {
  ActivitesSelector({this.activityname, this.ontap});

  final String activityname;
  bool ontap = false;

  @override
  _ActivitesSelectorState createState() => _ActivitesSelectorState();
}

class _ActivitesSelectorState extends State<ActivitesSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.00),
        color: widget.ontap ? orange : pink,
      ),
      child: Text(
        widget.activityname,
        style: TextStyle(color: widget.ontap ? pink : orange, fontSize: 16),
      ),
    );
  }
}

class Avaialibility extends StatefulWidget {
  @override
  _AvaialibilityState createState() => _AvaialibilityState();
}

class _AvaialibilityState extends State<Avaialibility> {
  bool pis = false;

  bool pos = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Products that are not available",
            style: TextStyle(color: orange, fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Products Sku(ZREP)",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Reason",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
          ],
        ),
        ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: Avaiablity.oos.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(Avaiablity.oos[index]),
                    ),
                  ),
                  Text(Avaiablity.oosreason[index])
                ],
              );
            }),
      ],
    );
  }
}

class Visibility extends StatefulWidget {
  @override
  _VisibilityState createState() => _VisibilityState();
}

class _VisibilityState extends State<Visibility> {
  bool pressAttentionMTB = false;
  bool pressAttentionTODAY = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  pressAttentionMTB = true;
                  pressAttentionTODAY = false;
                });
              },
              child: Container(
                height: 40,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        "INS",
                        style: TextStyle(
                          color: pressAttentionMTB == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.triangle_fill,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: pressAttentionMTB == true ? orange : Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pressAttentionTODAY = true;
                  pressAttentionMTB = false;
                });
              },
              child: Container(
                height: 40,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        'OOS',
                        style: TextStyle(
                          color: pressAttentionTODAY == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.triangle_fill,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: pressAttentionTODAY == true ? orange : Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "categories",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 10.0),
              child: Text(
                "status",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
          ],
        ),
        pressAttentionTODAY
            ? ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: VisibilityData.ooscatdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(VisibilityData.ooscatdata[index]),
                        ),
                      ),
                      Text(VisibilityData.oosreason[index])
                    ],
                  );
                })
            : ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: VisibilityData.inscatdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(VisibilityData.inscatdata[index]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PreveiwScreen(
                                        input: VisibilityData.insimage[index],
                                      )));
                        },
                        child: SizedBox(
                          height: 80,
                          width: 50,
                          child: PhotoView(
                            loadingBuilder: (context, event) => Center(
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: orange,
                                ),
                              ),
                            ),
                            imageProvider:
                                NetworkImage(VisibilityData.insimage[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
      ],
    );
  }
}

class PreveiwScreen extends StatelessWidget {
  PreveiwScreen({@required this.input});

  String input;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  child: CircularProgressIndicator(
                    backgroundColor: orange,
                  ),
                ),
              ),
              imageProvider: NetworkImage(input),
            ),
          ),
        )
      ],
    );
  }
}

class ShareOfShelf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: ShareData.ctrgys.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(left: 10.0),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ShareData.ctrgys[index],
                  style: TextStyle(color: orange, fontSize: 16),
                ),
                Text('Target : ${ShareData.target[index]}'),
                Text('Share : ${ShareData.share[index]}'),
                Text(
                    'Actual : ${ShareData.actual[index]} (${((double.parse(ShareData.actual[index]) / double.parse(ShareData.share[index])) * 100).toStringAsFixed(1)}%)'),
              ],
            ),
          );
        });
  }
}

class Planogram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "categories",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Target",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Before",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "After",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
          ],
        ),
        ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: PlanoDetails.categoryname.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(PlanoDetails.categoryname[index]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PreveiwScreen(
                                    input: PlanoDetails.imageurl[index],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 80,
                      width: 50,
                      child: PhotoView(
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(
                              backgroundColor: orange,
                            ),
                          ),
                        ),
                        imageProvider:
                            NetworkImage(PlanoDetails.imageurl[index]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PreveiwScreen(
                                    input: PlanoDetails.imageurl[index],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 80,
                      width: 50,
                      child: PhotoView(
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(
                              backgroundColor: orange,
                            ),
                          ),
                        ),
                        imageProvider:
                            NetworkImage(PlanoDetails.imageurl[index]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PreveiwScreen(
                                    input: PlanoDetails.imageurl[index],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 80,
                      width: 50,
                      child: PhotoView(
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(
                              backgroundColor: orange,
                            ),
                          ),
                        ),
                        imageProvider:
                            NetworkImage(PlanoDetails.imageurl[index]),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ],
    );
  }
}

class Promotion extends StatefulWidget {
  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  bool pressAttentionMTB = false;
  bool pressAttentionTODAY = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Promotion Details",
          style: TextStyle(color: orange, fontSize: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  pressAttentionMTB = true;
                  pressAttentionTODAY = false;
                });
              },
              child: Container(
                height: 40,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        "INS",
                        style: TextStyle(
                          color: pressAttentionMTB == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.triangle_fill,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: pressAttentionMTB == true ? orange : Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pressAttentionTODAY = true;
                  pressAttentionMTB = false;
                });
              },
              child: Container(
                height: 40,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        'OOS',
                        style: TextStyle(
                          color: pressAttentionTODAY == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.triangle_fill,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: pressAttentionTODAY == true ? orange : Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "categories",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 10.0),
              child: Text(
                "status",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ),
          ],
        ),
        pressAttentionTODAY
            ? ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: PromoData.oospdtdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(PromoData.oospdtdata[index]),
                        ),
                      ),
                      Text(PromoData.oosreason[index])
                    ],
                  );
                })
            : ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: PromoData.inspdtdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(PromoData.inspdtdata[index]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PreveiwScreen(
                                        input: PromoData.insimage[index],
                                      )));
                        },
                        child: SizedBox(
                          height: 80,
                          width: 50,
                          child: PhotoView(
                            loadingBuilder: (context, event) => Center(
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: orange,
                                ),
                              ),
                            ),
                            imageProvider:
                                NetworkImage(PromoData.insimage[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
      ],
    );
  }
}

class Competition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Competition Details",
                style: TextStyle(color: orange, fontSize: 16),
              ),
              Text(
                "Captured Image",
                style: TextStyle(color: orange, fontSize: 16),
              ),
            ],
          ),
          ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: competitiondata.cptcmy.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("Company: ${competitiondata.cptcmy[index]}"),
                          SizedBox(height: 5),
                          Text("Brand: ${competitiondata.cptbrand[index]}"),
                          SizedBox(height: 5),
                          Text(
                              "Regular Price:${competitiondata.cptmrp[index].toString()}"),
                          SizedBox(height: 5),
                          Text(
                              "Selling Price: ${competitiondata.cptsellprice[index].toString()}"),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PreveiwScreen(
                                          input: competitiondata.cptimg[index],
                                        )));
                          },
                          child: SizedBox(
                            height: 80,
                            width: 50,
                            child: PhotoView(
                              loadingBuilder: (context, event) => Center(
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  child: CircularProgressIndicator(
                                    backgroundColor: orange,
                                  ),
                                ),
                              ),
                              imageProvider:
                                  NetworkImage(competitiondata.cptimg[index]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

class Checklist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Task Details",
              style: TextStyle(color: orange, fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 10),
        ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: task.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task List: ${task.list[index].toString()}"),
                    SizedBox(height: 10),
                    Text("Task Compeleted: ${task.iscompleted.toString()}"),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
