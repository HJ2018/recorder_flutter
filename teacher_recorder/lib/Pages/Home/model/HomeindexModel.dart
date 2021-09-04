// To parse this JSON data, do
//
//     final homeindexModel = homeindexModelFromJson(jsonString);

import 'dart:convert';

HomeindexModel homeindexModelFromJson(String str) => HomeindexModel.fromJson(json.decode(str));

String homeindexModelToJson(HomeindexModel data) => json.encode(data.toJson());

class HomeindexModel {
  HomeindexModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory HomeindexModel.fromJson(Map<String, dynamic> json) => HomeindexModel(
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
    this.activityList,
    this.courseVo,
    this.matchingList,
    this.broadcastList,
  });

  List<ActivityList> activityList;
  CourseVo courseVo;
  List<MatchingList> matchingList;
  List<String> broadcastList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    activityList: List<ActivityList>.from(json["activityList"].map((x) => ActivityList.fromJson(x))),
    courseVo: CourseVo.fromJson(json["courseVO"]),
    matchingList: List<MatchingList>.from(json["matchingList"].map((x) => MatchingList.fromJson(x))),
    broadcastList: List<String>.from(json["broadcastList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "activityList": List<dynamic>.from(activityList.map((x) => x.toJson())),
    "courseVO": courseVo.toJson(),
    "matchingList": List<dynamic>.from(matchingList.map((x) => x.toJson())),
    "broadcastList": List<dynamic>.from(broadcastList.map((x) => x)),
  };
}

class ActivityList {
  ActivityList({
    this.imgUrl,
    this.linkUrl,
    this.type,
    this.title,
    this.option,
  });

  String imgUrl;
  String linkUrl;
  String type;
  String title;
  dynamic option;

  factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
    imgUrl: json["imgUrl"],
    linkUrl: json["linkUrl"],
    type: json["type"],
    title: json["title"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "imgUrl": imgUrl,
    "linkUrl": linkUrl,
    "type": type,
    "title": title,
    "option": option,
  };
}

class CourseVo {
  CourseVo({
    this.nextClassDate,
    this.nextClassDateTime,
    this.grade,
    this.studentName,
    this.address,
    this.subject,
    this.classCourseState,
  });

  String nextClassDate;
  String nextClassDateTime;
  String grade;
  String studentName;
  String address;
  String subject;
  String classCourseState;

  factory CourseVo.fromJson(Map<String, dynamic> json) => CourseVo(
    nextClassDate: json["nextClassDate"],
    nextClassDateTime: json["nextClassDateTime"],
    grade: json["grade"],
    studentName: json["studentName"],
    address: json["address"],
    subject: json["subject"],
    classCourseState: json["classCourseState"],
  );

  Map<String, dynamic> toJson() => {
    "nextClassDate": nextClassDate,
    "nextClassDateTime": nextClassDateTime,
    "grade": grade,
    "studentName": studentName,
    "address": address,
    "subject": subject,
    "classCourseState": classCourseState,
  };
}

class MatchingList {
  MatchingList({
    this.id,
    this.grade,
    this.subject,
    this.studentSex,
    this.address,
    this.tutorAddress,
    this.longitude,
    this.distance,
    this.latitude,
    this.studentSituation,
    this.tutorRequirement,
    this.state,
    this.applyNum,
    this.applyState,
    this.createTime,
  });

  String id;
  String grade;
  String subject;
  String studentSex;
  String address;
  String tutorAddress;
  String longitude;
  String distance;
  String latitude;
  String studentSituation;
  String tutorRequirement;
  String state;
  String applyNum;
  String applyState;
  DateTime createTime;

  factory MatchingList.fromJson(Map<String, dynamic> json) => MatchingList(
    id: json["id"],
    grade: json["grade"],
    subject: json["subject"],
    studentSex: json["studentSex"],
    address: json["address"],
    tutorAddress: json["tutorAddress"],
    longitude: json["longitude"],
    distance: json["distance"],
    latitude: json["latitude"],
    studentSituation: json["studentSituation"],
    tutorRequirement: json["tutorRequirement"],
    state: json["state"],
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
    "tutorAddress": tutorAddress,
    "longitude": longitude,
    "distance": distance,
    "latitude": latitude,
    "studentSituation": studentSituation,
    "tutorRequirement": tutorRequirement,
    "state": state,
    "applyNum": applyNum,
    "applyState": applyState,
    "createTime": createTime.toIso8601String(),
  };
}
