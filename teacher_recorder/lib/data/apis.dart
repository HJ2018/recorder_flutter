/**
 *  apis.dart
 *
 *  Created by iotjin on 2020/07/07.
 *  description:  api 管理
 */
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:teacher_recorder/component/Tool/jh_storage_utils.dart';
import 'package:flutter/cupertino.dart';


class APIs {

  static UDID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      print("ios唯一设备码："+iosDeviceInfo.identifierForVendor);
      AppSettingUtils.saveString(KEY.UDID_KEY, iosDeviceInfo.identifierForVendor);
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      print("android唯一设备码："+androidDeviceInfo.androidId);
      AppSettingUtils.saveString(KEY.UDID_KEY, androidDeviceInfo.androidId);
    }
  }

  static String Type() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      return "2";
    } else {
      return "1"; // unique ID on Android
    }

  }

  //正式环境
  static const String apiPrefix = "http://tutor.ahduosi.com";
  //本地环境
  // static const String apiPrefix = "http://192.168.31.123:8886";


  //获取验证码
  static String sendSms = "/auth/sendSms";

  //登录接口
  static String login = "/tutor/login";

  //打卡信息
  static String Dakahome = "/tutor/home";

  //课程接口
  static String course = "/room/classRoomList";

  //开始上课接口
  static String beginDaka = "/room/beginClockin";

  //结束上课接口
  static String endDaka = "/room/endClockin";

  //课后反馈
  static String feedback = "/room/feedback";

  //堂上课记录列表接口
  static String RecordList = "/room/classRecordList";

  //课堂列表详情查询接口
  static String RoomDetail = "/room/classRoomDetail";

  //课后反馈详情查询接口
  static String RecordDetail = "/room/classRecordDetail";

  //申请提现
  static String applywithdrawa = "/tutor/applyWithdrawal";

  //提现记录
  static String withdrawalList = "/tutor/withdrawalPageList";

  //绑定收款账号接口
  static String bingdinAccount = "/tutor/bindPaymentAccount";
  /**======*/
  //首页信息查询接口
  static String NewHome = "/tutor/index";

  //匹配列表分页查询接口
  static String MatchingList = "/matching/matchingList";

  //匹配抢单接口
  static String GrabOrder = "/matching/applyMatching";

  //获取用户个人信息接口
  static String getByUser = "/tutor/getById";

  //提交意见反馈接口
  static String submit = "/feedback/submit";

  //退出登陆
  static String ExitSign = "/tutor/signOut";

  //未打卡排课分页查询接口
  static String NOCourseList = "/room/classCourseList";

  //补卡信息接口
  static String patchRecord = "/room/patchRecord";




// ==============================================================

}

// //接口类型
// enum APIType {
//   Login,
//   GetPage,
// }
// //使用：APITypeValues[APIType.Login]
// const APITypeValues = {
//   APIType.Login: "/login",
//   APIType.GetPage: "/getPageArrDic"
// };



class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class NavRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class Repaint {

  static GlobalKey repaintWidgetKey = GlobalKey(); // 绘图key值
}