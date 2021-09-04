// To parse this JSON data, do
//
//     final withdrawalListModel = withdrawalListModelFromJson(jsonString);

import 'dart:convert';

WithdrawalListModel withdrawalListModelFromJson(String str) => WithdrawalListModel.fromJson(json.decode(str));

String withdrawalListModelToJson(WithdrawalListModel data) => json.encode(data.toJson());

class WithdrawalListModel {
  WithdrawalListModel({
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  int code;
  String message;
  Data data;
  int timestamp;

  factory WithdrawalListModel.fromJson(Map<String, dynamic> json) => WithdrawalListModel(
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
    this.startTime,
    this.type,
    this.account,
    this.orderNo,
    this.money,
    this.endTime,
    this.state,
  });

  String id;
  String startTime;
  String type;
  String account;
  String orderNo;
  String money;
  String endTime;
  int state;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    startTime: json["startTime"],
    type: json["type"],
    account: json["account"],
    orderNo: json["orderNo"],
    money: json["money"],
    endTime:json["endTime"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime,
    "type": type,
    "account": account,
    "orderNo": orderNo,
    "money": money,
    "endTime": endTime,
    "state": state,
  };
}
