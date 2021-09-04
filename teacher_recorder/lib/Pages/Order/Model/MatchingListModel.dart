// To parse this JSON data, do
//
//     final matchingListModel = matchingListModelFromJson(jsonString);

import 'dart:convert';

MatchingListModel matchingListModelFromJson(String str) => MatchingListModel.fromJson(json.decode(str));

String matchingListModelToJson(MatchingListModel data) => json.encode(data.toJson());

class MatchingListModel {
  MatchingListModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory MatchingListModel.fromJson(Map<String, dynamic> json) => MatchingListModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
    "timestamp": timestamp,
  };
}

class Data {
  Data({
    this.records,
    this.total,
    this.size,
    this.current,
    this.orders,
    this.searchCount,
    this.pages,
  });

  List<Record> records;
  int total;
  int size;
  int current;
  dynamic orders;
  bool searchCount;
  int pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
    total: json["total"],
    size: json["size"],
    current: json["current"],
    orders: json["orders"],
    searchCount: json["searchCount"],
    pages: json["pages"],
  );

  Map<String, dynamic> toJson() => {
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
    "total": total,
    "size": size,
    "current": current,
    "orders": orders,
    "searchCount": searchCount,
    "pages": pages,
  };
}

class Record {
  Record({
    this.id,
    this.grade,
    this.subject,
    this.studentSex,
    this.address,
    this.longitude,
    this.latitude,
    this.studentSituation,
    this.tutorRequirement,
    this.state,
    this.distance,
    this.applyNum,
    this.applyState,
    this.createTime,
    this.tutorAddress,
  });

  String id;
  String grade;
  String subject;
  String studentSex;
  String address;
  String longitude;
  String latitude;
  String studentSituation;
  String tutorRequirement;
  String state;
  String tutorAddress;
  String distance;
  String applyNum;
  String applyState;
  DateTime createTime;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    grade: json["grade"],
    subject: json["subject"],
    studentSex: json["studentSex"],
    address: json["address"],
    tutorAddress: json["tutorAddress"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    studentSituation: json["studentSituation"],
    tutorRequirement: json["tutorRequirement"],
    state: json["state"],
    distance: json["distance"],
    applyNum: json["applyNum"],
    applyState: json["applyState"],
    createTime: DateTime.parse(json["createTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade": grade,
    "subject": subject,
    "studentSex": studentSex,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "studentSituation": studentSituation,
    "tutorRequirement": tutorRequirement,
    "state": state,
    "distance": distance,
    "applyNum": applyNum,
    "applyState": applyState,
    "createTime": createTime.toIso8601String(),
  };
}
