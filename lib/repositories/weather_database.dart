import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class WeatherDatabase {
  static final _databaseName = "weather.db";
  static final _databaseVersion = 1;

  static final table = 'weather';

  static final columnId = '_id';
  static final columnTemperature = 'temperature';
  static final columnIconCode = 'iconCode';
  static final columnDescription = 'description';
  static final columnLocation = 'location';
  static final columnDateTime = 'dateTime';

  /*
    final int temperature;
  final String iconCode;
  final String description;
  final String location;
  final DateTime dateTime;
   */

  WeatherDatabase._privateConstructor();

  static final WeatherDatabase instance = WeatherDatabase._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTemperature INTEGER NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnLocation TEXT NOT NULL,
            $columnIconCode TEXT NOT NULL,
            $columnDateTime TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
