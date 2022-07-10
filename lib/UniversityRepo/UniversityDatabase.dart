import 'dart:async';
import 'dart:io';
import './university.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UniversityDatabase {

  UniversityDatabase._privateConstructor();
  static final UniversityDatabase databaseManager = UniversityDatabase._privateConstructor();
  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  static const _dbName = "universities.db";
  static const _dbVersion = 1;
  static const _tableName = "universities";


  // from the convention
  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        province TEXT NOT NULL,
        description TEXT NOT NULL,
        map TEXT NOT NULL,
        numbers TEXT NOT NULL
      )
      ''');
  }

  // Add Note
  Future<int> addUniversity(University university) async {
    Database db = await databaseManager.database;
    return await db.insert(_tableName, university.toMap());
  }

  // Delete Note
  Future<int> deleteUniversity(University university) async {
    Database db = await databaseManager.database;
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [university.id],
    );
  }

  // Delete All Notes
  Future<int> deleteAllUniversities() async {
    Database db = await databaseManager.database;
    return await db.delete(_tableName);
  }

  // Update Note
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
          name: maps[index]["subject"],
          province: maps[index]["title"],
          description: maps[index]["content"],
          map: maps[index]["dateTimeEdited"],
          numbers: maps[index]["dateTimeCreated"],
        );
      },
    );
  }
}