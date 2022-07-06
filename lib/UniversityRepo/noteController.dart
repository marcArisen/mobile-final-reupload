// import 'package:flutter/cupertino.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'university.dart';
// import 'UniversityDatabase.dart';
//
// class UniversityController extends GetxController {
//   var universities = <University>[];
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   bool isEmpty() {
//     return universities.isEmpty;
//   }
//
//   void getAllNotes() async {
//     universities = await NoteDatabase.databaseManager.getNoteList();
//     update();
//   }
// }