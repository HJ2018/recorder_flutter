// To parse this JSON data, do
//
//     final recordDetailModel = recordDetailModelFromJson(jsonString);

import 'dart:convert';

RecordDetailModel recordDetailModelFromJson(String str) => RecordDetailModel.fromJson(json.decode(str));

String recordDetailModelToJson(RecordDetailModel data) => json.encode(data.toJson());

class RecordDetailModel {
  RecordDetailModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory RecordDetailModel.fromJson(Map<String, dynamic> json) => RecordDetailModel(
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
    this.classRoomId,
    this.studentName,
    this.classRoomCode,
    this.tutorReward,
    this.subjectName,
    this.longitude,
    this.latitude,
    this.gradeName,
    this.address,
    this.consumeHours,
    this.totalHours,
    this.classRoomState,
    this.studentSex,
  });

  String classRoomId;
  String studentName;
  String classRoomCode;
  String tutorReward;
  String subjectName;
  String longitude;
  String latitude;
  String gradeName;
  String address;
  String consumeHours;
  String totalHours;
  String classRoomState;
  String studentSex;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    classRoomId: json["classRoomId"],
    studentName: json["studentName"],
    classRoomCode: json["classRoomCode"],
    tutorReward: json["tutorReward"],
    subjectName: json["subjectName"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    gradeName: json["gradeName"],
    address: json["address"],
    consumeHours: json["consumeHours"],
    totalHours: json["totalHours"],
    classRoomState: json["classRoomState"],
    studentSex: json["studentSex"],
  );

  Map<String, dynamic> toJson() => {
    "classRoomId": classRoomId,
    "studentName": studentName,
    "classRoomCode": classRoomCode,
    "tutorReward": tutorReward,
    "subjectName": subjectName,
    "longitude": longitude,
    "latitude": latitude,
    "gradeName": gradeName,
    "address": address,
    "consumeHours": consumeHours,
    "totalHours": totalHours,
    "classRoomState": classRoomState,
    "studentSex": studentSex,
  };
}
