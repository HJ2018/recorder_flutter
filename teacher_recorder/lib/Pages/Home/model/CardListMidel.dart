// To parse this JSON data, do
//
//     final cardListModel = cardListModelFromJson(jsonString);

import 'dart:convert';

CardListModel cardListModelFromJson(String str) => CardListModel.fromJson(json.decode(str));

String cardListModelToJson(CardListModel data) => json.encode(data.toJson());

class CardListModel {
  CardListModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
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
    this.studentName,
    this.classDate,
    this.beginTime,
    this.endTime,
    this.subject,
    this.grade,
    this.hours,
    this.address,
    this.classCourseState,
    this.classRecordId,
    this.classRoomId,
  });

  String id;
  String studentName;
  String classDate;
  String beginTime;
  String endTime;
  String subject;
  String grade;
  String hours;
  String address;
  String classCourseState;
  String classRecordId;
  String classRoomId;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    studentName: json["studentName"],
    classDate: json["classDate"],
    beginTime: json["beginTime"],
    endTime: json["endTime"],
    subject: json["subject"],
    grade: json["grade"],
    hours: json["hours"],
    address: json["address"],
    classCourseState: json["classCourseState"],
    classRecordId: json["classRecordId"],
    classRoomId: json["classRoomId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentName": studentName,
    "classDate": classDate,
    "beginTime": beginTime,
    "endTime": endTime,
    "subject": subject,
    "grade": grade,
    "hours": hours,
    "address": address,
    "classCourseState": classCourseState,
    "classRecordId": classRecordId,
    "classRoomId": classRoomId,
  };
}
