import 'dart:io';

import 'package:musicapp/model/audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final _databaseName = "AudioDB.db";
  static final _databaseVersion = 1;

  static final table = 'Audio';

  static final columnId = 'artistId';
  static final columnUrl = 'artworkUrl100';
  static final columnPath = 'path';
  static final columnName = 'name';

  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/$_databaseName';
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnUrl TEXT NOT NULL,
            $columnPath TEXT NOT NULL,
            $columnName TEXT NOT NULL
          )
          ''');
  }

  newAudio(MyAudio newAudio) async {
    final db = await database;
    return await db.insert(table, newAudio.toJson());
  }

  Future<List<MyAudio>> getAllAudio() async {
    final db = await database;
    var res = await db.query("Audio");
    List<MyAudio> list = res.isNotEmpty ? res.map((c) => MyAudio.fromJson(c)).toList() : [];
    return list;
  }
}
