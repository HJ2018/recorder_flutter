import 'package:flutter/material.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/jh_dialog.dart';
import 'package:teacher_recorder/component/Tool/jh_login_textfield.dart';
import 'package:teacher_recorder/component/Tool/jh_progress_hud.dart';
import 'package:teacher_recorder/data/data_utils.dart';


class BingDingZFB extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return BingDingZFBState();
  }

}

class BingDingZFBState extends State<BingDingZFB>{

  var account ='';
  FocusNode blankNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(

      behavior: HitTestBehavior.translucent,
      onTap:() {
        FocusScope.of(context).requestFocus(blankNode);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColor.NavMainColor,
          title: Text("绑定支付宝"),
          brightness: Brightness.dark,
        ),
        body: _CellItem(),
      ),
    );

  }

  Widget _CellItem() {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return _cellContent(index);
          // return
        });
  }

  Widget _cellContent(int index){


    if(index == 0){
      return Padding(padding: EdgeInsets.only(left: 15,top: 30),
        child: Text("填写账号",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
      );
    } else if(index == 1){

      return Padding(padding: EdgeInsets.only(top: 25),
      child:JhLoginTextField(
          text:account,
          hintText: "请输入支付宝账号",
          TtextStyle: TextStyle(fontSize: 17.0,color:Colors.black),
          isShowDeleteBtn: true,
          leftWidget: Container(
            child: Image.asset(
              "images/zhifubao.png",
              width: 10, height: 10,
            ),
          ),
          keyboardType:TextInputType.datetime,
          inputCallBack: (value)=> account=value
      ),
      );

    }else if(index == 2){
      return Padding(padding: EdgeInsets.only(left: 15,top: 10,right: 10),

        child: RichText(text: TextSpan(
            children: [
              TextSpan(
                text: "* ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14),
              ),
              TextSpan(
                text: "绑定支付宝请注意查看账号，绑定成功后不能修改，如有错误请联系我们工作人员",
                style: TextStyle(
                    color: KColor.NavMainColor,
                    fontSize: 12),
              )
            ]
        )),
      );
    }else if(index == 3){
      return Padding(padding: EdgeInsets.only(left: 30,top: 60,right: 30),
        child: FlatButton(
          color: KColor.NavMainColor,
          textColor: Colors.white,
          minWidth: MediaQuery.of(context).size.width-80,
          height: 50,
          child: new Text('绑定'),
          onPressed: () {
            BingdingZFBData();
          },
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
      );
    }

  }

  void BingdingZFBData() async{


    if(account.length == 0){
      JhDialog.show(context,title: "提示",content: "请输入支付宝账号。。",hiddenCancel: true);
    }else{
      JhDialog.show(context,title: "提示",content:"是否确定绑定 $account 账号",onConfirm: (){

        DataUtils.ApplywithdrawaData({"payAccount":account},success: (data){

          print("返回数据：${account} ============>>>>>>  $data");

          if(data["code"] == 200){
            JhDialog.show(context, title: "提示", content:"绑定成功，账号:${account}" ,  onConfirm: () {
              Navigator.pop(context);
            });

          }
        },fail: (code){
        });
      });
    }
  }

}