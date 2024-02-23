class DBModel {
  //////////////////////////////////////////////////DECLARE VARIABLE//////////////////////////////////////////
  int _id;
  String _firstColumn;

  DBModel(this._firstColumn);

  //////////////////////////////////////////////////GETTERS//////////////////////////////////////////

  int get id {
    return _id;
  }

  String get firstColumn => _firstColumn;


  //////////////////////////////////////////////////SETTERS//////////////////////////////////////////

  set firstColumn(String firstColumn) {
    this._firstColumn = firstColumn;
  }



//Used to Save and Retrieve from the Database
//Converting the Book Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
    if (id != null) {
      map['id'] = _id;
    }
    map['firstColumn'] = firstColumn;
    return map;
  }

  DBModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstColumn = map['firstColumn'];
  }
}
