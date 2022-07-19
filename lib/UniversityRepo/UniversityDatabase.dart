
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
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
  static List<University> fav_universities = [];

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

  List<String> getAllNameUniversities() {
    return universities.map((e) => e.name!).toList();
  }

  /// This one is for testing purposes
  void addAllToFirebase(String user) {
    for (int i = 0; i < universities.length; i++) {
      FirebaseFirestore.instance.collection(user).doc(universities[i].name).set(universities[i].toJson());
    }
  }

  void addUniversityToFirebase(String user, University university){
    FirebaseFirestore.instance.collection(user).doc(university.name).set(university.toJson());
  }

  void deleteUniversityToFirebase(String user, University university){
    FirebaseFirestore.instance.collection(user)
        .doc(university.name) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print(' ${university.name} Deleted'))
        .catchError((error) => print("this university  doesn't save to favorite"));
  }

  String convertToText(String numbers) {
    Map valueMap = jsonDecode(numbers);
    var buffer = new StringBuffer();
    valueMap.forEach((key, value) {
      buffer.write(changeToEmoji(key));
      buffer.write(": ");
      buffer.write(value);
      buffer.write(" ");
    });
    return buffer.toString();
  }

  String changeToEmoji(String country){
    switch (country) {
      case ("AUSTRALIAN"): { return "🇦🇺";}
      case ("BANGLADESHI"): { return "🇧🇩";}
      case ("BRAZILIAN"): { return "🇧🇷";}
      case ("BHUTANESE"): { return "🇧🇹";}
      case ("CHINESE"): { return "🇨🇳";}
      case ("COLOMBIAN"): { return "🇨🇴";}
      case ("GERMAN"): { return "🇩🇪";}
      case ("FRENCH"): { return "🇵🇫";}
      case ("BRITON,BRIYISH"): { return "🇻🇬";}
      case ("CROATIAN,CROAT"): { return "🇭🇷";}
      case ("INDONESIAN"): { return "🇮🇩";}
      case ("INDIAN"): { return "🇮🇳";}
      case ("IRANIAN"): { return "🇮🇷";}
      case ("JORDANIAN"): { return "🇯🇴";}
      case ("JAPANESE"): { return "🇯🇵";}
      case ("KYRGYZSTANI"): { return "🇰🇬";}
      case ("CAMBODIAN"): { return "🇰🇭";}
      case ("KOREAN"): { return "🇰🇷";}
      case ("LAO/LAOTIAN"): { return "🇱🇦";}
      case ("MYANMAR"): { return "🇲🇲";}
      case ("MALAYSIAN"): { return "🇲🇾";}
      case ("NIGERIAN"): { return "🇳🇬";}
      case ("NORWEGIAN"): { return "🇳🇴";}
      case ("NEPALESE"): { return "🇳🇵";}
      case ("PHILIPPINO"): { return "🇵🇭";}
      case ("PAKISTANI"): { return "🇵🇰";}
      case ("SINGAPOREAN"): { return "🇸🇬";}
      case ("TAJIKISTANI"): { return "🇹🇯";}
      case ("TURKISH"): { return "🇹🇷";}
      case ("TAIWAN"): { return "🇹🇼";}
      case ("AMERICAN"): { return "🇺🇸";}
      case ("VIET NAMESE"): { return "🇻🇳";}
      case ("ZIMBABWEAN"): { return "🇿🇼";}
      case ("SRI LANKAN"): { return "🇱🇰";}
      case ("SWISS"): { return "🇨🇭";}
      case ("stateless person"): { return "ℹ️";}
      case ("ARGENTINE"): { return "🇦🇷";}
      case ("BRUNEIAN"): { return "🇧🇳";}
      case ("GHANAIAN"): { return "🇬🇭";}
      case ("KENYAN"): { return "🇰🇪";}
      case ("DUTCH"): { return "🇸🇽";}
      case ("RUSSIAN FEDERATION"): { return "🇷🇺";}
      case ("TURKMEN"): { return "🇹🇲";}
      case ("AFGHAN"): { return "🇦🇫";}
      case ("CHAINESE/HONG KONGER"): { return "🇨🇳";}
      case ("BRITISH INDIAN OCEAN TERRITORY"): { return "🇻🇬";}
      case ("ITALIAN"): { return "🇮🇹";}
      case ("SWEDISH"): { return "🇸🇪";}
      case ("SOMALI"): { return "🇸🇴";}
      case ("UZBEKISTANI"): { return "🇺🇿";}
      case ("FRENCH GUIANA"): { return "🇬🇫";}
      case ("GUINEAN"): { return "🇬🇳";}
      case ("MOROCCAN"): { return "🇲🇦";}
      case ("SOUTH AFRICAN"): { return "🇿🇦";}
      case ("CANADIAN"): { return "🇨🇦";}
      case ("MEXICAN"): { return "🇲🇽";}
      case ("YEMENI"): { return "🇾🇪";}
      case ("AMERICAN SAMOAN"): { return "🇦🇸";}
      case ("PERUVIAN"): { return "🇵🇪";}
      case ("ANDORRAN"): { return "🇦🇩";}
      case ("MAURITIAN"): { return "🇲🇺";}
      case ("VIRGIN ISLANDS, BRITISH"): { return "🇻🇬";}
      case ("TRINIDADIAN"): { return "🇹🇹";}
      case ("ECUADORIAN"): { return "🇪🇨";}
      case ("TANZANIAN"): { return "🇹🇿";}
      case ("BOSNIAN , HERZEGOVINIAN"): { return "🇧🇦";}
      case ("FINNISH"): { return "🇫🇮";}
      case ("BAHAMIAN"): { return "🇧🇸";}
      case ("CONGO"): { return "🇨🇩";}
      case ("MALAWIAN"): { return "🇲🇼";}
      case ("NEW CALEDONIAN"): { return "🇳🇨";}
      case ("CAMEROONIAN"): { return "🇨🇲";}
      case ("DANISH"): { return "🇩🇰";}
      case ("ISRAELI"): { return "🇮🇱";}
      case ("UGANDAN"): { return "🇺🇬";}
      case ("LUXEMBOURGER"): { return "🇱🇺";}
      case ("PORTUGUESE"): { return "🇵🇹";}
      case ("HUNGARIAN"): { return "🇭🇺";}
      case ("KAZAKHSTANI"): { return "🇰🇿";}
      case ("HAITIAN"): { return "🇭🇹";}
      case ("MOZAMBICAN"): { return "🇲🇿";}
      case ("NAMIBIAN"): { return "🇳🇦";}
      case ("PANAMANIAN"): { return "🇵🇦";}
      case ("TUNISIAN"): { return "🇹🇳";}
      case ("SPANISH"): { return "🇪🇸";}
      case ("POLISH"): { return "🇵🇱";}
      case ("SIERRA LEONEAN"): { return "🇸🇱";}
      case ("UKRAINIAN"): { return "🇺🇦";}
      case ("ARUBAN"): { return "🇦🇼";}
      case ("TOKELAUAN"): { return "🇹🇰";}
      case ("TIMORESE"): { return "🇹🇱";}
      case ("TUVALUAN"): { return "🇹🇻";}
      case (""): { return "🇵🇦";}
      case ("BELGIAN"): { return "🇧🇪";}
      case ("C?TE D'IVOIRE"): { return "🇨🇮";}
      case ("SYRIAN"): { return "🇸🇾";}
      case ("BULGARIAN"): { return "🇧🇬";}
      case ("SERB"): { return "🇷🇸";}
      default: { return "NO INFO";}
    }
  }


}
