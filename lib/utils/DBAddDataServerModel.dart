class DBAddDataServerModel {
  //////////////////////////////////////////////////DECLARE VARIABLE//////////////////////////////////////////
  // addtoserverurl
  // addtoserverbody
  // addtoservermessage
  String _addtoserverurl;
  String _addtoserverbody;
  String _addtoservermessage;


  DBAddDataServerModel(this._addtoserverurl,this._addtoserverbody,this._addtoservermessage);

  //////////////////////////////////////////////////GETTERS//////////////////////////////////////////



  String get addtoserverurl => _addtoserverurl;

  String get addtoserverbody => _addtoserverbody;
  String get addtoservermessage => _addtoservermessage;

  //////////////////////////////////////////////////SETTERS//////////////////////////////////////////

  set addtoserverurl(String addtoserverurl) {
    this._addtoserverurl = addtoserverurl;
  }
  set addtoserverbody(String addtoserverbody) {
    this._addtoserverbody = addtoserverbody;
  }
  set addtoservermessage(String addtoservermessage) {
    this._addtoservermessage = addtoservermessage;
  }




//Used to Save and Retrieve from the Database
//Converting the Book Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
    map['addtoserverurl'] = addtoserverurl;
    map['addtoserverbody'] = addtoserverbody;
    map['addtoservermessage']=addtoservermessage;


    return map;
  }

  DBAddDataServerModel.fromMapObject(Map<String, dynamic> map) {

    this._addtoserverurl=map['addtoserverurl'];
    this._addtoserverbody = map['addtoserverbody'];
    this._addtoservermessage = map['addtoservermessage'];

  }
}
