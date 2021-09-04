// To parse this JSON data, do
//
//     final recordListModel = recordListModelFromJson(jsonString);

import 'dart:convert';

RecordListModel recordListModelFromJson(String str) => RecordListModel.fromJson(json.decode(str));

String recordListModelToJson(RecordListModel data) => json.encode(data.toJson());

class RecordListModel {
  RecordListModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory RecordListModel.fromJson(Map<String, dynamic> json) => RecordListModel(
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
    this.hours,
    this.startClassAddress,
    this.endClassAddress,
    this.actualHours,
    this.classContent,
    this.classHomeworkState,
    this.classSignState,
    this.tutorReward,
    this.tutorTotalReward,
  });

  String id;
  String studentName;
  // DateTime classDate;
  String classDate;
  String beginTime;
  String endTime;
  String hours;
  String startClassAddress;
  String endClassAddress;
  String actualHours;
  String classContent;
  String classHomeworkState;
  int classSignState;
  dynamic tutorReward;
  dynamic tutorTotalReward;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    studentName: json["studentName"],
    // classDate: DateTime.parse(json["classDate"]),
    classDate: json["classDate"],
    beginTime: json["beginTime"],
    endTime: json["endTime"],
    hours: json["hours"],
    startClassAddress: json["startClassAddress"],
    endClassAddress: json["endClassAddress"],
    actualHours: json["actualHours"],
    classContent: json["classContent"],
    classHomeworkState: json["classHomeworkState"],
    classSignState: json["classSignState"],
    tutorReward: json["tutorReward"],
    tutorTotalReward: json["tutorTotalReward"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentName": studentName,
    "classDate": classDate,
    // "${classDate.year.toString().padLeft(4, '0')}-${classDate.month.toString().padLeft(2, '0')}-${classDate.day.toString().padLeft(2, '0')}",
    "beginTime": beginTime,
    "endTime": endTime,
    "hours": hours,
    "startClassAddress": startClassAddress,
    "endClassAddress": endClassAddress,
    "actualHours": actualHours,
    "classContent": classContent,
    "classHomeworkState": classHomeworkState,
    "classSignState": classSignState,
    "tutorReward": tutorReward,
    "tutorTotalReward": tutorTotalReward,
  };
}
