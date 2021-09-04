/**
 *  http_utils.dart
 *
 *  Created by iotjin on 2020/07/07.
 *  description:  项目接口请求 管理类
 */
import 'package:flutter/cupertino.dart';
import 'package:teacher_recorder/component/Tool/jh_progress_hud.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:teacher_recorder/component/Tool/jh_storage_utils.dart';
import '../data/apis.dart';
import 'dio_utils.dart';
import 'log_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code);

class HttpUtils {
  // //GET
  // static void GetRequest<T>(
  //   APIType apiType,
  //   parameters, {
  //   Success success,
  //   Fail fail,
  // }) {
  //   post(APITypeValues[apiType], parameters, success: success, fail: fail);
  // }
  //
  // //POST
  // static void PostRequest<T>(
  //   APIType apiType,
  //   parameters, {
  //   Success success,
  //   Fail fail,
  // }) {
  //   post(APITypeValues[apiType], parameters, success: success, fail: fail);
  // }

  /********************************* 分割线 ********************************/

  //get 请求
  static void get<T>(
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {
    _request(Method.GET, url, parameters, success: success, fail: fail);
  }

  //post 请求
  static void post<T>(
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {
    _request(Method.POST, url, parameters, success: success, fail: fail);
  }

  //_request 请求
  static void _request<T>(
    Method method,
    String url,
    parameters, {
    Success success,
    Fail fail,
  }) {

    Future.delayed(Duration.zero,(){
      ///跳转loading页面
      JhProgressHUD.showLoadingText();
    });


    DioUtils.request(method, url, parameters, success: (result) {


     Future.delayed(Duration.zero,(){
       JhProgressHUD.hideHUD();
     });

      if (result['code'] == 200) {
        if (success != null) {
          success(result);
        }
      } else if(result['code'] == 401){
        AppSettingUtils.saveString(KEY.TOKEN_KEY,"");
        Future.delayed(Duration.zero,(){
          JhProgressHUD.showText("登陆失效，请重新登录。。");
        });
        NavRouter.navigatorKey.currentState.pushNamedAndRemoveUntil("/CodeLoginPage", ModalRoute.withName("/"));
      } else {
        //其他状态，弹出错误提示信息
        Future.delayed(Duration.zero,(){
          JhProgressHUD.showText(result['message']);
        });
        print("error======$result");
      }
    }, fail: (code, msg) {
      Future.delayed(Duration.zero,(){
        JhProgressHUD.hideHUD();
      });
      if (fail != null) {
        fail(code);
      }
    });
  }
}
