/**
 *  data_utils.dart
 *
 *  Created by iotjin on 2021/04/01.
 *  description: 项目数据请求 管理类
 */


import '../data/apis.dart';
import '../http/http_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code);

class DataUtils {


  //登录
  static void login<T>(
    parameters, {
    Success success,
    Fail fail,
  }) {
//    DioUtils.request(Method.POST, APIs.login, parameters,
//        success: success, fail: fail);
    HttpUtils.post(APIs.login, parameters, success: success, fail: fail);
  }

  //验证码
  static void sendSms<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.sendSms, parameters, success: success, fail: fail);
  }

  //打卡信息
  static void DakahomeData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.Dakahome, parameters, success: success, fail: fail);
  }


  //课堂信息
  static void courseData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.course, parameters, success: success, fail: fail);
  }

  //打卡接口
  static void beginDakaData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.beginDaka, parameters, success: success, fail: fail);
  }

  //结束上课
  static void endDakaData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.endDaka, parameters, success: success, fail: fail);
  }

  //课后反馈
  static void feedbackData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.feedback, parameters, success: success, fail: fail);
  }

  //堂上课记录列表接口
  static void RecordListData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.RecordList, parameters, success: success, fail: fail);
  }

  //课堂详情查询接口
  static void RoomDetailData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.RoomDetail, parameters, success: success, fail: fail);
  }


  //课堂详反馈情查询接口
  static void RecordDetailData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.RecordDetail, parameters, success: success, fail: fail);
  }

  //申请提现
  static void ApplywithdrawaData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.applywithdrawa, parameters, success: success, fail: fail);
  }



  //提现记录
  static void WithdrawalListData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.withdrawalList, parameters, success: success, fail: fail);
  }


  //绑定收款账号接口
  static void BingdinAccountData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.bingdinAccount, parameters, success: success, fail: fail);
  }

  //匹配列表分页查询接口
  static void MatchingListData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.MatchingList, parameters, success: success, fail: fail);
  }

  //匹配抢单接口
  static void GrabOrderData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.GrabOrder, parameters, success: success, fail: fail);
  }

  //获取用户个人信息接口
  static void getByUserData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.getByUser, parameters, success: success, fail: fail);
  }

  //提交意见反馈接口
  static void submitData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.submit, parameters, success: success, fail: fail);
  }

  //首页信息查询接口
  static void NewHomeData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.NewHome, parameters, success: success, fail: fail);
  }

  //退出登陆接口
  static void ExitSignData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.ExitSign, parameters, success: success, fail: fail);
  }

  //未打卡排课分页查询接口
  static void NOCourseListData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.NOCourseList, parameters, success: success, fail: fail);
  }

  //补卡信息接口
  static void patchRecordData<T>(
      parameters, {
        Success success,
        Fail fail,
      }) {
    HttpUtils.post(APIs.patchRecord, parameters, success: success, fail: fail);
  }

}
