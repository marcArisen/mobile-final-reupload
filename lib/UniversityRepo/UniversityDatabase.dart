
import 'dart:async';
import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../api/api_service.dart';
import './university.dart';

class UniversityDatabase {

  UniversityDatabase._privateConstructor();
  static final UniversityDatabase databaseManager = UniversityDatabase._privateConstructor();
  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();


  static const _dbName = "universities.db";
  static const _dbVersion = 1;
  static const _tableName = "universities";
  static List<University> universities = [];

  // from the convention
  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    // getAllUniversities();
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        thaiName TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        logo TEXT NOT NULL,
        province TEXT NOT NULL,
        description TEXT NOT NULL,
        map TEXT NOT NULL,
        numbers TEXT NOT NULL
      )
      ''');
  }

  Future<int> addUniversity(University university) async {
    Database db = await databaseManager.database;
    return await db.insert(_tableName, university.toMap());
  }

  Future<int> deleteUniversity(University university) async {
    Database db = await databaseManager.database;
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [university.id],
    );
  }

  Future<int> deleteAllUniversities() async {
    Database db = await databaseManager.database;
    return await db.delete(_tableName);
  }

  Future<int> updateUniversity(University university) async {
    Database db = await databaseManager.database;
    return await db.update(
      _tableName,
      university.toMap(),
      where: "id = ?",
      whereArgs: [university.id],
    );
  }

  Future<int> updateUniversityByName(University university) async {
    Database db = await databaseManager.database;
    return await db.update(
      _tableName,
      university.toMap(),
      where: "id = ?",
      whereArgs: [university.name],
    );
  }

  Future<List<University>> getUniversityList() async {
    Database db = await databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(
      maps.length,
          (index) {
        return University(
          id: maps[index]["id"],
          name: maps[index]["name"],
          thaiName: maps[index]["thaiName"],
          imageUrl: maps[index]["imageUrl"],
          logo: maps[index]["logo"],
          province: maps[index]["province"],
          description: maps[index]["description"],
          map: maps[index]["map"],
          numbers: maps[index]["numbers"],
        );
      },
    );
  }

  void getAllUniversities() async {
    universities = await UniversityDatabase.databaseManager.getUniversityList();
  }

  List<String?> getAllNameUniversities() {
    return universities.map((e) => e.name).toList();
  }

}
