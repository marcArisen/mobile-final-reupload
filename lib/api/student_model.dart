import 'dart:convert';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String welcomeToJson(List<StudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  StudentModel({
    this.id,
    this.year,
    this.semester,
    this.nationalityNameEng,
    this.univNameTh,
    this.univMasterName,
    this.amount,
  });

  int? id;
  int? year;
  int? semester;
  String? nationalityNameEng;
  String? univNameTh;
  String? univMasterName;
  int? amount;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["_id"],
    year: json["YEAR"],
    semester: json["SEMESTER"],
    nationalityNameEng: json["NATIONALITY_NAME_ENG"],
    univNameTh: json["UNIV_NAME_TH"],
    univMasterName: json["UNIV_MASTER_NAME"],
    amount: json["AMOUNT"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "YEAR": year,
    "SEMESTER": semester,
    "NATIONALITY_NAME_ENG": nationalityNameEng,
    "UNIV_NAME_TH": univNameTh,
    "UNIV_MASTER_NAME": univMasterName,
    "AMOUNT": amount,
  };
}

// enum Univ { EMPTY, UNIV, PURPLE, FLUFFY, TENTACLED, STICKY, INDIGO, INDECENT, HILARIOUS, AMBITIOUS }
//
// final univValues = EnumValues({
//   "มหาวิทยาลัยเกษตรศาสตร์": Univ.AMBITIOUS,
//   "จุฬาลงกรณ์มหาวิทยาลัย": Univ.EMPTY,
//   "มหาวิทยาลัยเกษตรศาสตร์ วิทยาเขตเฉลิมพระเกียรติสกลนคร": Univ.FLUFFY,
//   "มหาวิทยาลัยธรรมศาสตร์": Univ.HILARIOUS,
//   "มหาวิทยาลัยบูรพา": Univ.INDECENT,
//   "มหาวิทยาลัยเชียงใหม่": Univ.INDIGO,
//   "มหาวิทยาลัยเกษตรศาสตร์ วิทยาเขตศรีราชา": Univ.PURPLE,
//   "มหาวิทยาลัยขอนแก่น": Univ.STICKY,
//   "มหาวิทยาลัยเกษตรศาสตร์ บางเขน": Univ.TENTACLED,
//   "มหาวิทยาลัยเกษตรศาสตร์ วิทยาเขตกำแพงแสน": Univ.UNIV
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap = { };
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
