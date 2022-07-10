
import 'dart:convert';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.help,
    this.success,
    this.result,
  });

  String? help;
  bool? success;
  Result? result;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    help: json["help"],
    success: json["success"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "help": help,
    "success": success,
    "result": result?.toJson(),
  };
}

class Result {
  Result({
    this.includeTotal,
    this.resourceId,
    this.fields,
    this.recordsFormat,
    this.records,
    this.limit,
    this.links,
    this.total,
  });

  bool? includeTotal;
  String? resourceId;
  List<Field>? fields;
  String? recordsFormat;
  List<Record>? records;
  int? limit;
  Links? links;
  int? total;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    includeTotal: json["include_total"],
    resourceId: json["resource_id"],
    fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
    recordsFormat: json["records_format"],
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    limit: json["limit"],
    links: Links.fromJson(json["_links"]),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "include_total": includeTotal,
    "resource_id": resourceId,
    "fields": List<dynamic>.from(fields!.map((x) => x.toJson())),
    "records_format": recordsFormat,
    "records": List<dynamic>.from(records!.map((x) => x.toJson())),
    "limit": limit,
    "_links": links?.toJson(),
    "total": total,
  };
}

class Field {
  Field({
    this.type,
    this.id,
  });

  String? type;
  String? id;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
  };
}

class Links {
  Links({
    this.start,
    this.next,
  });

  String? start;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    start: json["start"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "next": next,
  };
}

class Record {
  Record({
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

  factory Record.fromJson(Map<String, dynamic> json) => Record(
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
