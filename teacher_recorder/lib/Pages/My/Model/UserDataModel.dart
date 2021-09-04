// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
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
    this.nickName,
    this.sex,
    this.sign,
    this.birthday,
    this.urgentContactName,
    this.urgentContactPhone,
    this.teachingInterval,
    this.experience,
    this.nativePlace,
    this.type,
    this.totalHours,
    this.settlementHours,
    this.settlementMoney,
    this.grade,
    this.honor,
    this.experienceDescription,
    this.introduction,
    this.province,
    this.city,
    this.address,
    this.teachingArea,
    this.longitude,
    this.latitude,
    this.paymentAccountState,
    this.paymentAccount,
    this.isAgreement,
    this.teachingCondition,
    this.coverUrl,
    this.headUrl,
    this.realName,
    this.email,
    this.educationList,
    this.subjectsList,
    this.teachingTimeList,
  });

  String nickName;
  String sex;
  dynamic sign;
  String birthday;
  String urgentContactName;
  String urgentContactPhone;
  String teachingInterval;
  String experience;
  String nativePlace;
  String type;
  String totalHours;
  String settlementHours;
  String settlementMoney;
  String grade;
  String honor;
  String experienceDescription;
  String introduction;
  String province;
  String city;
  String address;
  String teachingArea;
  String longitude;
  String latitude;
  String paymentAccountState;
  String paymentAccount;
  String isAgreement;
  String teachingCondition;
  String coverUrl;
  String headUrl;
  String realName;
  String email;
  List<EducationList> educationList;
  List<SubjectsList> subjectsList;
  List<TeachingTimeList> teachingTimeList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nickName: json["nickName"],
    sex: json["sex"],
    sign: json["sign"],
    birthday: json["birthday"],
    urgentContactName: json["urgentContactName"],
    urgentContactPhone: json["urgentContactPhone"],
    teachingInterval: json["teachingInterval"],
    experience: json["experience"],
    nativePlace: json["nativePlace"],
    type: json["type"],
    totalHours: json["totalHours"],
    settlementHours: json["settlementHours"],
    settlementMoney: json["settlementMoney"],
    grade: json["grade"],
    honor: json["honor"],
    experienceDescription: json["experienceDescription"],
    introduction: json["introduction"],
    province: json["province"],
    city: json["city"],
    address: json["address"],
    teachingArea: json["teachingArea"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    paymentAccountState: json["paymentAccountState"],
    paymentAccount: json["paymentAccount"],
    isAgreement: json["isAgreement"],
    teachingCondition: json["teachingCondition"],
    coverUrl: json["coverUrl"],
    headUrl: json["headUrl"],
    realName: json["realName"],
    email: json["email"],
    educationList: List<EducationList>.from(json["educationList"].map((x) => EducationList.fromJson(x))),
    subjectsList: List<SubjectsList>.from(json["subjectsList"].map((x) => SubjectsList.fromJson(x))),
    teachingTimeList: List<TeachingTimeList>.from(json["teachingTimeList"].map((x) => TeachingTimeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nickName": nickName,
    "sex": sex,
    "sign": sign,
    "birthday": birthday,
    "urgentContactName": urgentContactName,
    "urgentContactPhone": urgentContactPhone,
    "teachingInterval": teachingInterval,
    "experience": experience,
    "nativePlace": nativePlace,
    "type": type,
    "totalHours": totalHours,
    "settlementHours": settlementHours,
    "settlementMoney": settlementMoney,
    "grade": grade,
    "honor": honor,
    "experienceDescription": experienceDescription,
    "introduction": introduction,
    "province": province,
    "city": city,
    "address": address,
    "teachingArea": teachingArea,
    "longitude": longitude,
    "latitude": latitude,
    "paymentAccountState": paymentAccountState,
    "paymentAccount": paymentAccount,
    "isAgreement": isAgreement,
    "teachingCondition": teachingCondition,
    "coverUrl": coverUrl,
    "headUrl": headUrl,
    "realName": realName,
    "email": email,
    "educationList": List<dynamic>.from(educationList.map((x) => x.toJson())),
    "subjectsList": List<dynamic>.from(subjectsList.map((x) => x.toJson())),
    "teachingTimeList": List<dynamic>.from(teachingTimeList.map((x) => x.toJson())),
  };
}

class EducationList {
  EducationList({
    this.type,
    this.school,
    this.major,
  });

  int type;
  String school;
  String major;

  factory EducationList.fromJson(Map<String, dynamic> json) => EducationList(
    type: json["type"],
    school: json["school"],
    major: json["major"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "school": school,
    "major": major,
  };
}

class SubjectsList {
  SubjectsList({
    this.period,
    this.subject,
  });

  int period;
  String subject;

  factory SubjectsList.fromJson(Map<String, dynamic> json) => SubjectsList(
    period: json["period"],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "period": period,
    "subject": subject,
  };
}

class TeachingTimeList {
  TeachingTimeList({
    this.week,
    this.morning,
    this.afternoon,
    this.night,
  });

  int week;
  int morning;
  int afternoon;
  int night;

  factory TeachingTimeList.fromJson(Map<String, dynamic> json) => TeachingTimeList(
    week: json["week"],
    morning: json["morning"],
    afternoon: json["afternoon"],
    night: json["night"],
  );

  Map<String, dynamic> toJson() => {
    "week": week,
    "morning": morning,
    "afternoon": afternoon,
    "night": night,
  };
}
