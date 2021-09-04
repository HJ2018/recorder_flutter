// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  CourseModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  List<Datum> data;
  int timestamp;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "timestamp": timestamp,
  };
}

class Datum {
  Datum({
    this.gradeName,
    this.classRoomState,
    this.classRoomId,
    this.address,
    this.totalHours,
    this.studentName,
    this.latitude,
    this.classRoomCode,
    this.consumeHours,
    this.subjectName,
    this.longitude,
  });

  String gradeName;
  String classRoomState;
  String classRoomId;
  String address;
  String totalHours;
  String studentName;
  String latitude;
  String classRoomCode;
  String consumeHours;
  String subjectName;
  String longitude;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    gradeName: json["gradeName"],
    classRoomState: json["classRoomState"],
    classRoomId: json["classRoomId"],
    address: json["address"],
    totalHours: json["totalHours"],
    studentName: json["studentName"],
    latitude: json["latitude "],
    classRoomCode: json["classRoomCode"],
    consumeHours: json["consumeHours"],
    subjectName: json["subjectName"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "gradeName": gradeName,
    "classRoomState": classRoomState,
    "classRoomId": classRoomId,
    "address": address,
    "totalHours": totalHours,
    "studentName": studentName,
    "latitude ": latitude,
    "classRoomCode": classRoomCode,
    "consumeHours": consumeHours,
    "subjectName": subjectName,
    "longitude": longitude,
  };
}
