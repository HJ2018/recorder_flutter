/**
 *  jh_count_down_btn.dart
 *
 *  Created by iotjin on 2020/04/07. 
 *  description:  倒计时按钮
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'colors.dart';


const int _normalTime = 60; //默认 倒计时时间
const String _normalText = '获取验证码'; //默认 按钮文字

class JhCountDownBtn extends StatefulWidget {

  final Future<bool> Function() getVCode;
  final Color textColor;
  final bool showBorder;

  const JhCountDownBtn({
    Key key,
    this.getVCode,
    this.textColor,
    this.showBorder:false,
  }): super(key: key);

  @override
  _JhCountDownBtnState createState() => _JhCountDownBtnState();
}

class _JhCountDownBtnState extends State<JhCountDownBtn> {

  Timer _countDownTimer;
  String _btnStr = _normalText;
  int _countDownNum = _normalTime;
  bool _isClick = true;

  @override
  Widget build(BuildContext context) {

    if(widget.getVCode ==null){
      return Container();
    }else
      return
        ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 100,
                maxHeight: 35,
            ),
          child:  FlatButton(
              textColor: _isClick ? KColor.kWeiXinPayColor : Colors.grey,
              color: Colors.transparent,
              shape: widget.showBorder==false ?null:
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(
                    color: _isClick ? KColor.kWeiXinPayColor : Colors.grey,
                    width: 0.8,
                  )
              ),
              child: Text(_btnStr, style: TextStyle(fontSize: 13.0,
                color: _isClick ? KColor.kWeiXinPayColor : Colors.grey,
              )),
              onPressed:() {
                if ( _isClick) {
                  _getVCode();
                };
              }
          )
        );

    }
    Future _getVCode() async {
    bool isSuccess = await widget.getVCode();
    if (isSuccess != null && isSuccess && _isClick) {
      _isClick = false;
      startCountdown();
    };
  }

  // void ClickOkBtn() async {
  //
  // }

  //开始倒计时
  void startCountdown() {

    setState(() {
      if (_countDownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _btnStr = '重新获取(${_countDownNum--}s)';
      _countDownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countDownNum > 0) {
            _btnStr = '重新获取(${_countDownNum--}s)';

          } else {
            _isClick = true;
            _btnStr = _normalText;
            _countDownNum = _normalTime;
            _countDownTimer.cancel();
            _countDownTimer = null;
          }
        });
      });
    });
  }

  //释放掉Timer
  @override
  void dispose() {
    _countDownTimer?.cancel();
    _countDownTimer = null;
    super.dispose();
  }

}