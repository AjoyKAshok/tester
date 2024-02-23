class DBActivitiesModel {
  //////////////////////////////////////////////////DECLARE VARIABLE//////////////////////////////////////////

  String _firstColumn;
  int _timesheet;

  DBActivitiesModel(this._timesheet,this._firstColumn);

  //////////////////////////////////////////////////GETTERS//////////////////////////////////////////



  String get firstColumn => _firstColumn;

  int get timesheet => _timesheet;
  //////////////////////////////////////////////////SETTERS//////////////////////////////////////////

  set firstColumn(String firstColumn) {
    this._firstColumn = firstColumn;
  }
  set timesheet(int timesheet) {
    this._timesheet = timesheet;
  }


//Used to Save and Retrieve from the Database
//Converting the Book Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database

    map['timesheetID']=timesheet;
    map['firstColumn'] = firstColumn;

    return map;
  }

  DBActivitiesModel.fromMapObject(Map<String, dynamic> map) {

    this._timesheet=map['timesheetID'];
    this._firstColumn = map['firstColumn'];

  }
}
