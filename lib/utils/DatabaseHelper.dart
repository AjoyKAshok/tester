import 'package:merchandising/utils/DBActivitiesModel.dart';
import 'package:merchandising/utils/DBAddDataServerModel.dart';
import 'package:merchandising/utils/DBModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

String todayjp_table = "todayjp",
    todayskipped_table = "todayskipped",
    todayvisited_table = "todayvisited";
String journeyplanweekly_table = "journeyplanweekly",
    skjourneyplanweekly_table = "skjourneyplanweekly",
    vstjourneyplanweekly_table = "vstjourneyplanweekly";
String nbldetaildata_table = "nbldetaildata",
    availabilitydetdata_table = "availabilitydetdata",
    visibilitydetdata_table = "visibilitydetdata",
    shareofshelfdetdata_table = "shareofshelfdetdata",
    planodetaildata_table = "planodetaildata",
    promodetaildata_table = "promodetaildata",
    checklistdetaildata_table = "checklistdetaildata",
    expiryproductsdata_table = "expiryproductsdata";
String alljpoutletschart_table = "alljpoutletschart",
    alljpoutletsEchart_table = "alljpoutletsEchart",
    alljpoutlets_table = "alljpoutlets";
String addDataForSync = "addDataForSync";

class DatabaseHelper {
  //////////////////////////////////////////////////DECLARE AND INITIALISE VARIABLE//////////////////////////////////////////

  static DatabaseHelper _databaseHelper; //Singleton
  static Database _database; //singleton

  static final String colID = 'id';
  static final String firstColumn = 'firstColumn';
  static final String timesheetID = 'timesheetID';

  static final String addtoserverurl = 'addtoserverurl';
  static final String addtoserverbody = 'addtoserverbody';
  static final String addtoservermessage = 'addtoservermessage';

  //////////////////////////////////////////////////METHOD FOR CREATE AND INITIALISE DATABASE//////////////////////////////////////////

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'rms.db'); //directory.path + 'rms.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todayjp_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $todayskipped_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $todayvisited_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');

    await db.execute(
        'CREATE TABLE $journeyplanweekly_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $skjourneyplanweekly_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $vstjourneyplanweekly_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');

    await db.execute(
        'CREATE TABLE $alljpoutlets_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $alljpoutletsEchart_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $alljpoutletschart_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');

    ///Customer activity
    await db.execute(
        'CREATE TABLE $availabilitydetdata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $visibilitydetdata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $shareofshelfdetdata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $planodetaildata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $promodetaildata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $checklistdetaildata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');
    await db.execute(
        'CREATE TABLE $nbldetaildata_table($timesheetID INTEGER PRIMARY KEY ,$firstColumn TEXT)');

    await db.execute(
        'CREATE TABLE $expiryproductsdata_table($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $firstColumn TEXT)');

    await db.execute(
        'CREATE TABLE $addDataForSync($addtoserverurl TEXT,$addtoserverbody TEXT,$addtoservermessage TEXT)');
  }

  //////////////////////////////////////////////////METHOD FOR INSERT BOOK//////////////////////////////////////////

  Future<int> insertData(DBModel dbModel, String table) async {
    Database db = await this.database;
    var result = await db.insert(table, dbModel.toMap());
    return result;
  }

  Future<int> insertActivityData(
      DBActivitiesModel dbModel, String table) async {
    Database db = await this.database;
    var result = await db.insert(table, dbModel.toMap());
    return result;
  }

  Future<int> insertDataForSync(
      DBAddDataServerModel dbModel, String table) async {
    Database db = await this.database;
    var result = await db.insert(table, dbModel.toMap());
    return result;
  }

  Future<int> dataIsExist(String table) async {
    Database db = await this.database;

    int count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));

    print(count);
    return count;
  }

  Future<int> dataIsExistOnActivity(String table, String timesheet) async {
    Database db = await this.database;
    int count = 0;
    if (db != null) {
      count = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT (*) FROM $table WHERE $timesheetID=?', [timesheet]));
    }
    return count;
  }

  deleteTable(String table) async {
    Database db = await this.database;
    int i = await db.delete(table); //delete all rows in a table
    print("delted value ..$i");
  }

  updateActivityData(DBActivitiesModel dbModel, String table) async {
    Database db = await this.database;
    await db.update(
      '$table',
      dbModel.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'timesheetID = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dbModel.timesheet],
    );
  }

  Future<String> getData(String table) async {
    List<DBModel> noteListFuture = await getDataList(table);
    String data;
    // noteListFuture.then((bookList_) async {
    List<DBModel> bookList = noteListFuture;
    if (bookList.length > 0) {
      data = bookList[0].firstColumn ?? "";
    }
    print("booklist length..${bookList.length}...data  ... $data..");
    // await Future.delayed(const Duration(seconds: 3));

    // });
// return data;
    return "$data";
  }

  Future<List<String>> getList(String table) async {
    List<DBModel> noteListFuture = await getDataList(table);
    List<String> data = [];
    List<DBModel> bookList = noteListFuture;
    print('The List : $bookList');
    for (int i = 0; i < bookList.length; i++) {
      data.add(bookList[i].firstColumn);
    }
    return data;
  }

  //////////////////////////////////////////////////METHOD FOR GETTING BOOK LIST//////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getDataMapList(String table) async {
    Database db = await this.database;
    var result = await db.query(table);
    print('THe result of query : $result');
    return result;
  }

  //
  Future<List<DBModel>> getDataList(String table) async {
    var bookMapList = await getDataMapList(table);

    int count = bookMapList.length;

    List<DBModel> booksList = List<DBModel>();
    for (int i = 0; i < count; i++) {
      booksList.add(DBModel.fromMapObject(bookMapList[i]));
    }
    return booksList;
  }

  Future<List<DBAddDataServerModel>> getDataForSyncList(String table) async {
    var bookMapList = await getDataMapList(table);

    int count = bookMapList.length;

    List<DBAddDataServerModel> booksList = List<DBAddDataServerModel>();
    for (int i = 0; i < count; i++) {
      booksList.add(DBAddDataServerModel.fromMapObject(bookMapList[i]));
    }
    return booksList;
  }

  getActivityList(String table, String timesheet) async {
    Database db = await this.database;
    // raw query
    List<Map> result = await db.rawQuery(
        'SELECT $firstColumn FROM $table WHERE $timesheetID=?', ['$timesheet']);

    // print the results
    result.forEach((row) => print(row));
    print("result...$result");
    if (result == null || result.isEmpty) {
      return null;
    } else {
      return result[0]["firstColumn"].toString();
    }
  }
}

getDataForSyncList_(String table) async {
  DatabaseHelper helper = DatabaseHelper();
  List<DBAddDataServerModel> data = await helper.getDataForSyncList(table);
  return data;
}

saveDataIntoDB(String data, String table) async {
  DatabaseHelper helper = DatabaseHelper();
  DBModel dbModel;
  dbModel = new DBModel(data);
  int existResult;
  existResult = await helper.dataIsExist(table);
  if (existResult != 0) {
    //already exist
    print("isexist");
    String data = await helper.getData(table);
    print("get data...${data}...");
    await helper.deleteTable(table);
    await helper.insertData(dbModel, table);
  } else {
    print("not isexist");
    int result = await helper.insertData(dbModel, table);
    if (result != 0) {
      print("saved...");
    }
  }
}

saveActivitiesDataIntoDB(String timesheet, String data, String table) async {
  DatabaseHelper helper = DatabaseHelper();
  DBActivitiesModel dbModel;
  dbModel = new DBActivitiesModel(int.parse(timesheet), data);
  int existResult;
  existResult = await helper.dataIsExistOnActivity(table, timesheet);
  if (existResult != 0) {
    //exist
    await helper.updateActivityData(dbModel, table);
    print("isexist");
  } else {
    //not exist
    int result = await helper.insertActivityData(dbModel, table);
    print("not isexist");
  }
}

saveDataForSync(String url, String body, String comment, String table) async {
  DatabaseHelper helper = DatabaseHelper();
  DBAddDataServerModel dbModel;
  dbModel = new DBAddDataServerModel(url, body, comment);
  int result = await helper.insertDataForSync(dbModel, table);
}

selectActivityData(String timesheet, String table) {
  DatabaseHelper helper = DatabaseHelper();
}

getData(String table) async {
  print("table..$table");
  DatabaseHelper helper = DatabaseHelper();
  String data = await helper.getData(table);
  return data;
}

///save list data
saveListDataIntoDb(String data, String table) async {
  DatabaseHelper helper = DatabaseHelper();
  DBModel dbModel;
  dbModel = new DBModel(data);
  int result = await helper.insertData(dbModel, table);
}

///get list of data
getListData(String table) async {
  DatabaseHelper helper = DatabaseHelper();
  List<String> data = await helper.getList(table);
  return data;
}

getActivityData(String table, String timesheet) async {
  DatabaseHelper helper = DatabaseHelper();
  String data = await helper.getActivityList(table, timesheet);
  return data;
}

///delete table
deleteTable_(String table) async {
  DatabaseHelper helper = DatabaseHelper();
  await helper.deleteTable(table);
}

deleteAllTable_() async {
  DatabaseHelper helper = DatabaseHelper();
  await helper.deleteTable(availabilitydetdata_table);
  await helper.deleteTable(visibilitydetdata_table);
  await helper.deleteTable(shareofshelfdetdata_table);
  await helper.deleteTable(planodetaildata_table);
  await helper.deleteTable(promodetaildata_table);
  await helper.deleteTable(checklistdetaildata_table);
  await helper.deleteTable(nbldetaildata_table);
}
