// To parse this JSON data, do
//
//     final classFeedbackModel = classFeedbackModelFromJson(jsonString);

import 'dart:convert';

ClassFeedbackModel classFeedbackModelFromJson(String str) => ClassFeedbackModel.fromJson(json.decode(str));

String classFeedbackModelToJson(ClassFeedbackModel data) => json.encode(data.toJson());

class ClassFeedbackModel {
  ClassFeedbackModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory ClassFeedbackModel.fromJson(Map<String, dynamic> json) => ClassFeedbackModel(
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
    this.classHomework,
    this.classPerformance,
    this.tutorReward,
    this.tutorTotalReward,
  });

  String id;
  String studentName;
  DateTime classDate;
  String beginTime;
  String endTime;
  String hours;
  String startClassAddress;
  String endClassAddress;
  String actualHours;
  String classContent;
  String classHomeworkState;
  String classSignState;
  String classHomework;
  String classPerformance;
  String tutorReward;
  String tutorTotalReward;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    studentName: json["studentName"],
    classDate: DateTime.parse(json["classDate"]),
    beginTime: json["beginTime"],
    endTime: json["endTime"],
    hours: json["hours"],
    startClassAddress: json["startClassAddress"],
    endClassAddress: json["endClassAddress"],
    actualHours: json["actualHours"],
    classContent: json["classContent"],
    classHomeworkState: json["classHomeworkState"],
    classSignState: json["classSignState"],
    classHomework: json["classHomework"],
    classPerformance: json["classPerformance"],
    tutorReward: json["tutorReward"],
    tutorTotalReward: json["tutorTotalReward"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentName": studentName,
    "classDate": "${classDate.year.toString().padLeft(4, '0')}-${classDate.month.toString().padLeft(2, '0')}-${classDate.day.toString().padLeft(2, '0')}",
    "beginTime": beginTime,
    "endTime": endTime,
    "hours": hours,
    "startClassAddress": startClassAddress,
    "endClassAddress": endClassAddress,
    "actualHours": actualHours,
    "classContent": classContent,
    "classHomeworkState": classHomeworkState,
    "classSignState": classSignState,
    "classHomework": classHomework,
    "classPerformance": classPerformance,
    "tutorReward": tutorReward,
    "tutorTotalReward": tutorTotalReward,
  };
}
