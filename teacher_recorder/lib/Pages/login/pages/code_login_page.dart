/**
 *  code_login_page.dart
 *
 *  Created by iotjin on 2020/04/09.
 *  description:  验证码登录
 */
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:teacher_recorder/component/Tool/jh_progress_hud.dart';
import 'package:teacher_recorder/component/Tool/jh_keyboard_utils.dart';
import 'package:teacher_recorder/component/Tool/jh_login_textfield.dart';
import 'package:teacher_recorder/component/Tool/jh_count_down_btn.dart';
import 'package:teacher_recorder/component/Tool/jh_button.dart';
import 'package:teacher_recorder/component/Tool/jh_storage_utils.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/component/Route/routes.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import 'package:teacher_recorder/http/dio_utils.dart';
import 'logigDataModel.dart';
import 'dart:ui';

class CodeLoginPage extends StatefulWidget {
  @override
  _CodeLoginPageState createState() => _CodeLoginPageState();
}

class _CodeLoginPageState extends State<CodeLoginPage> {

   double navH = MediaQueryData.fromWindow(window).padding.top +10;

  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  var _phone ='';
  var _code = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return
      Scaffold(

          body:KeyboardActions(

            config: JhKeyboardUtils.getKeyboardConfig(context, [_node1,_node2]),
            child: _mainBody(),
          )

      );
  }

  Widget _mainBody(){
    return SingleChildScrollView(

            child:Padding(
              padding: EdgeInsets.only(top:navH , left: 15,bottom: 15,right: 15),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(height: 30),
                  Image.asset(
                    "images/HomeTopImage.png",
                    width: 240,
                    height: 100,
                    // fit: BoxFit.fill,
                  ),

                  // SizedBox(height: 10),
                  Text(
                    '验证码登录',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  SizedBox(height: 30),
                  JhLoginTextField(
                      text:_phone,
                      hintText: "请输入手机号",
                      focusNode:_node1,
                      TtextStyle: TextStyle(fontSize: 16.0,color:Colors.black),
                      maxLength: 11,
                      isShowDeleteBtn: true,
                      leftWidget: Icon(Icons.phone_android),
                      keyboardType:TextInputType.number,
                      inputCallBack: (value)=> _phone=value
                  ),
                  SizedBox(height: 20),

                  JhLoginTextField(
                      leftWidget: Icon(Icons.verified_user_outlined),
                      hintText: "请输入验证码",
                      TtextStyle: TextStyle(fontSize: 16.0,color: Colors.black),
                      focusNode:_node2,
                      maxLength: 6,
                      keyboardType:TextInputType.phone,
                      rightWidget:
                      JhCountDownBtn(
                          showBorder: true,
                          getVCode:() async {
                            print("+++++++++++++");
                            ClickOkBtn();
                            return true;
                          }
                      ),
                      inputCallBack: (value)=> _code =value
                  ),

                  SizedBox(height: 80),
                  JhButton(text: "登 录",
                      onPressed: _ClickOkBtn
                  ),
                  SizedBox(height: 15),



                ],
              ),

            ),
          );
  }

  void ClickOkBtn() async{

    // final result =  APIs().UDID().then((String result){
    //   print("-------------------： $result");
    // });

    if(_phone.length != 11 && _phone != null){
      JhProgressHUD.showText("请检查手机号码输入是否正确!");
      return;
    }

    DataUtils.sendSms({"type":"0" , "mobile" :_phone},success: (data){
      print("返回数据： $data" );
    } ,fail: (code){
      print("返回数据： $code");
    });
  }

  void _ClickOkBtn() async {

    print('_phone =$_phone');
    print('_code =$_code');

    if(_phone.length != 11 && _phone != null){
      JhProgressHUD.showText("请检查手机号码输入是否正确!");
      return;
    }
    if(_code.length != 5){
      JhProgressHUD.showText("请输入有效验证码!");
      return;
    }

    Map<String, dynamic> parameters = {
      'state': '1',
      'mobile': _phone,
      'code': _code,
    };
    String TOKEN = AppSettingUtils.getStringWithKey(KEY.TOKEN_KEY);
    print(TOKEN);
    DataUtils.login(parameters,success: (data){
      Map<String, dynamic> json = Map<String, dynamic>.from(data);
      LoginModel model = LoginModel.fromJson(json) ;
      print("返回数据： ============>>>>>>    ${model.message}====${model.data.token}" );
      if(model.code == 200){
        AppSettingUtils.saveString(KEY.TOKEN_KEY, model.data.token);
        AppSettingUtils.saveString(KEY.HEADURL_KEY, model.data.member.headUrl);
        AppSettingUtils.saveString(KEY.NAME_KEY, model.data.member.realName);
        AppSettingUtils.saveString(KEY.EXPER_KEY, model.data.member.experience);
        AppSettingUtils.saveString(KEY.ADDRESS_KEY, model.data.member.address);
        DioUtils.clear();
        NavigatorUtils.pushReplacement(context, Routes.home);

      }
    }, fail: (code){
      print("返回数据： $code");
    });


    // Future.delayed(Duration(seconds: 1),(){

//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (context) => (BaseTabBar()
//          )));
//       NavigatorUtils.pushReplacement(context, Routes.home);
//     });


  }

}
