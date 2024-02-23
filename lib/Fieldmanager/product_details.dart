import 'package:merchandising/ConstantMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/MenuContent.dart';
import 'package:merchandising/Fieldmanager/add_product.dart';
import 'package:merchandising/api/FMapi/product_detailsapi.dart';
import 'package:merchandising/utils/background.dart';
import 'package:photo_view/photo_view.dart';

int position;

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";

  List<String> _filterList;
  List<String> _filterbrandname;
  List<String> _filtertype;
  List<String> _filtercategory;

  _ProductDetailsState() {
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          iconTheme: IconThemeData(color: orange),
          title: Column(
            children: [
              Text(
                "Product Details",
                style: TextStyle(color: orange),
              ),
              EmpInfo(),
            ],
          ),
        ),
        // drawer: Drawer(
        //   child: Menu(),
        // ),
        body: Stack(
          children: [
            BackGround(),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10, 10, 0),
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

           
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(left: 20.0),
      width: double.infinity,
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(25.0)),
      child: new TextField(
        style: TextStyle(color: orange),
        controller: _searchview,
        cursorColor: orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          focusColor: orange,
          hintText: 'Search by Product Name/Code',
          hintStyle: TextStyle(color: orange),
          border: InputBorder.none,
          icon: Icon(
            CupertinoIcons.search,
            color: orange,
          ),
          isCollapsed: true,
        ),
      ),
    );
  }

  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: productlist.productname.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                position = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductDetailView()));
              },
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Name : ${productlist.productname[index]}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text("Brand Name : ${productlist.brandname[index]}",
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                      SizedBox(height: 5),
                      Text('Type : ${productlist.type[index]}',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                      SizedBox(height: 5),
                      Text('Category : ${productlist.productcategory[index]}',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ],
                  )),
            );
          }),
    );
  }

  Widget _performSearch() {
    _filterList = [];
    _filterbrandname = [];
    _filtertype = [];
    _filtercategory = [];
    for (int i = 0; i < productlist.productname.length; i++) {
      var item = productlist.productname[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
        int index = productlist.productname.indexOf(item);
        _filterbrandname.add(productlist.brandname[index]);
        _filtertype.add(productlist.type[index]);
        _filtercategory.add(productlist.productcategory[index].toString());
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                position = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductDetailView()));
              },
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('product Name : ${_filterList[index]}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Brand Name  : ${_filterbrandname[index]}",
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                      SizedBox(height: 5),
                      Text('Type : ${_filtertype[index]}',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                      SizedBox(height: 5),
                      Text('Category : ${_filtercategory[index]}',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ],
                  )),
            );
          }),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        iconTheme: IconThemeData(color: orange),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Details",
              style: TextStyle(color: orange),
            ),
            EmpInfo(),
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: Menu(),
      // ),

      body: Stack(
        children: [
          BackGround(),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sku:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.sku[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Product Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        SingleChildScrollView(
                            child: Text(
                          productlist.productname[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        )),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Brand Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.brandname[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Type:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.type[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Range:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.range[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Zrep Code:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.zrepcode[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Piece per cartoon:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.piecepercartoon[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Price per piece:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.priceperpiece[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Brand ID:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.brandid[position].toString(),
                          style: TextStyle(fontSize: 15.0),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Client ID:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          productlist.clientid[position],
                          style: TextStyle(fontSize: 15.0),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Product category:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${productlist.productcategory[position]}',
                          style: TextStyle(fontSize: 15.0),
                        )
                      ],
                    ),
                    SizedBox(height: 15),

                    // Row(
                    //   children: [
                    //     Text("Image:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                    //     Spacer(),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     VeiwImage()));
                    //       },
                    //       child: Container(
                    //         width: 60,
                    //         padding: EdgeInsets.all(10),
                    //         decoration: BoxDecoration(
                    //           color: orange,
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Center(child: Text("Veiw",style: TextStyle(color: Colors.white),)),
                    //       ),
                    //     ),
                    //     SizedBox(width: 10),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class VeiwImage extends StatelessWidget {
  String url =
      "https://test.rhapsody.ae/product_image/${productlist.imageurl[position].toString()}";

  @override
  Widget build(BuildContext context) {
    return PhotoView(
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
    );
  }
}
