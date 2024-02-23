import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchandising/ConstantMethods.dart';
import 'package:merchandising/ProgressHUD.dart';
import 'package:merchandising/api/FMapi/add_categoryapi.dart';
import 'package:merchandising/api/FMapi/category_detailsapi.dart';
import 'package:merchandising/utils/background.dart';
import 'add_product.dart';

class CategoryofProducts extends StatefulWidget {
  @override
  _CategoryofProductsState createState() => _CategoryofProductsState();
}

class _CategoryofProductsState extends State<CategoryofProducts> {
  TextEditingController typecategory = TextEditingController();
  GlobalKey<FormState> addcategories = GlobalKey<FormState>();

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
                      'Add Category',
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
          body: Stack(children: [
            BackGround(),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: pink,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: addcategories,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: typecategory,
                            cursorColor: grey,
                            validator: (input) => !input.isNotEmpty
                                ? "add category should not be empty"
                                : null,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusColor: orange,
                              hintText: "Enter Category",
                              hintStyle: TextStyle(
                                color: grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              if (validateform() == true)
                                setState(() {
                                  isApiCallProcess = true;
                                });
                              CategorytoAdd.name = typecategory.text;

                              await addcategory();
                              // await getCategoryDetails();
                              DropDownItemscategory =
                                  Category.name.map((String val) {
                                return new DropdownMenuItem<String>(
                                  value: val,
                                  child: new Text(val),
                                );
                              }).toList();
                              setState(() {
                                isApiCallProcess = false;
                              });

                              // if(typecategory.text!=null){
                              typecategory.clear();
                              Flushbar(
                                message: "Category has been added",
                                duration: Duration(seconds: 4),
                              )..show(context);
                              // }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(orange)),
                            child: Text(
                              "SAVE",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  bool validateform() {
    final form = addcategories.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
