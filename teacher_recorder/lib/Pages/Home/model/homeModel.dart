// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    this.courseVo,
    this.monthVo,
    this.weekVo,
  });

  CourseVo courseVo;
  MonthVo monthVo;
  WeekVo weekVo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    courseVo: CourseVo.fromJson(json["courseVO"]),
    monthVo: MonthVo.fromJson(json["monthVO"]),
    weekVo: WeekVo.fromJson(json["weekVO"]),
  );

  Map<String, dynamic> toJson() => {
    "courseVO": courseVo.toJson(),
    "monthVO": monthVo.toJson(),
    "weekVO": weekVo.toJson(),
  };
}

class CourseVo {
  CourseVo({
    this.id,
    this.classRoomId,
    this.startCourseTime,
    this.endCourseTime,
    this.hours,
    this.takingClassState,
    this.address,
    this.longitude,
    this.latitude,
  });

  String id;
  String classRoomId;
  DateTime startCourseTime;
  DateTime endCourseTime;
  String hours;
  String takingClassState;
  String address;
  String longitude;
  String latitude;

  factory CourseVo.fromJson(Map<String, dynamic> json) => CourseVo(
    id: json["id"],
    classRoomId: json["classRoomId"],
    startCourseTime: DateTime.parse(json["startCourseTime"]),
    endCourseTime: DateTime.parse(json["endCourseTime"]),
    hours: json["hours"],
    takingClassState: json["takingClassState"],
    address: json["address"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "classRoomId": classRoomId,
    "startCourseTime": startCourseTime.toIso8601String(),
    "endCourseTime": endCourseTime.toIso8601String(),
    "hours": hours,
    "takingClassState": takingClassState,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
  };
}

class MonthVo {
  MonthVo({
    this.hours,
    this.hoursCost,
    this.transferNum,
  });

  String hours;
  String hoursCost;
  String transferNum;

  factory MonthVo.fromJson(Map<String, dynamic> json) => MonthVo(
    hours: json["hours"],
    hoursCost: json["hoursCost"],
    transferNum: json["transferNum"],
  );

  Map<String, dynamic> toJson() => {
    "hours": hours,
    "hoursCost": hoursCost,
    "transferNum": transferNum,
  };
}

class WeekVo {
  WeekVo({
    this.totalHours,
    this.consumeHours,
    this.surplusHours,
  });

  String totalHours;
  String consumeHours;
  String surplusHours;

  factory WeekVo.fromJson(Map<String, dynamic> json) => WeekVo(
    totalHours: json["totalHours"],
    consumeHours: json["consumeHours"],
    surplusHours: json["surplusHours"],
  );

  Map<String, dynamic> toJson() => {
    "totalHours": totalHours,
    "consumeHours": consumeHours,
    "surplusHours": surplusHours,
  };
}
