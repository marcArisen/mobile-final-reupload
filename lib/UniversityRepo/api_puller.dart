/*
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/UniversityRepo/university.dart';

import '../api/student_model.dart';

class ApiPuller {

  // Record({
  //   this.id,
  //   this.year,
  //   this.semester,
  //   this.nationalityNameEng,
  //   this.univNameTh,
  //   this.univMasterName,
  //   this.amount,
  // });
  //
  // int? id;
  // int? year;
  // int? semester;
  // String? nationalityNameEng;
  // String? univNameTh;
  // String? univMasterName;
  // int? amount;

  Future<List<int>>? updateNumberToDatabase(List<Record> lst){
    for (int i = 0; i < lst.length; i++) {
      // UniversityDatabase().addUniversity(university)
      // UniversityDatabase.databaseManager.addUniversity(university)

      // UniversityDatabase.databaseManager.updateUniversity()
    }
    return null;
  }

  List listAllUniversities(List<Record>? lst){
    var to_return = [];
    for (int i = 0; i < lst!.length; i++) {
      to_return.add(lst[i].univMasterName!);
    }
    // there are 97 universities
    return to_return.toSet().toList();
  }
  //
  // void mockDatabase(List lst){
  //   for (int i = 0; i < lst!.length; i++) {
  //     // addUniversity(University university)
  //     var temp = University2({
  //       i,
  //       lst[i],
  //       "Bangkok",
  //       "university",
  //       "this.map",
  //       0,
  //     });
  //   }
  // }


}

 */