import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/My/Model/UserDataModel.dart';
import 'package:teacher_recorder/Pages/login/pages/code_login_page.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/jh_dialog.dart';
import 'package:teacher_recorder/component/Tool/jh_storage_utils.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';

class myItemWidget extends StatelessWidget{

   int itemIdx;
   UserDataModel model;
   myItemWidget({Key key , this.itemIdx ,this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(itemIdx == 0){
      return Container(
        child:
        Stack(
          overflow: Overflow.visible,
          alignment: const Alignment(0, 0.6),
          children: <Widget>[
            Positioned(
              left: 0, top: 0, right: 0, bottom: 60,
              child: Container(
                child: userData(model: model,),
              ),
            ),
            Positioned(
              left: 15, right: 15, height: 65,
              child: Container(
                child:costExpanded(model: model,),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(12, 168, 168, 168),
                            // offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                            blurRadius: 0.5, //阴影模糊程度
                            spreadRadius: 1.0 //阴影扩散程度
                        )
                      ]
                ),
              ),
            )
          ],
        )
      );
    }else{

      if(itemIdx == 1){
        return changyongWidget(context,model);
      }else if(itemIdx == 2){
        return otherWidget(context);
      }
    }
  }

}


// 常用功能
Widget changyongWidget(BuildContext contex ,UserDataModel model) {
  return Container(
    margin: EdgeInsets.only(top: 15),
    width: MediaQuery.of(contex).size.width,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(top: 8, left: 13),
          child: Text(
            "常用功能",
            style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Wrap(
            spacing: 30.0, // 主轴(水平)方向间距
            runSpacing: 25.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //模式
            children: <Widget>[

              GestureDetector(
                onTap: (){
                  print("1111");
                  // model.data.settlementHours

                  NavigatorUtils.pushNamed(contex, "${"PayTixian"}?amount=${model==null?"0":model.data.settlementHours}");
                  // NavigatorUtils.pushNamed(contex, "PayTianx");
                },
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 25,
                          height: 25,
                          child: Image(
                            image: AssetImage('images/tixian.png'),
                          )),
                      SizedBox( height: 10, ),
                      Text("薪资提现",style: TextStyle(fontSize: 14 )),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  NavigatorUtils.pushNamed(contex, "HistaryPay");
                },
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 25,
                          height: 25,
                          child: Image(
                            image: AssetImage('images/xinziguanli.png'),
                          )),
                      SizedBox( height: 10, ),
                      Text("提现记录",style: TextStyle(fontSize: 14 )),

                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                  if(model.data.paymentAccountState == "0"){
                    NavigatorUtils.pushNamed(contex, "binding");
                  }else{
                    NavigatorUtils.pushNamed(contex,"${"completeBingDing"}?completeBingDing=${model.data.paymentAccount}");
                  }
                },
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 25,
                          height: 25,
                          child: Image(
                            image: AssetImage('images/bangdingxinxi.png'),
                          )),
                      SizedBox( height: 10, ),
                      Text("绑定支付宝",style: TextStyle(fontSize: 14 )),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
// 其它功能
Widget otherWidget(BuildContext contex ) {
  return Container(
    margin: EdgeInsets.only(top: 15),
    width: MediaQuery.of(contex).size.width,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, left: 13),
          child: Text(
            "其它功能",
            style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Wrap(
            spacing: 30.0, // 主轴(水平)方向间距
            runSpacing: 25.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //模式
            children: <Widget>[

              GestureDetector(
                onTap: (){
                  NavigatorUtils.pushNamed(contex, "Myfeedback");
                },
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 25,
                          height: 25,
                          child: Image(
                            image: AssetImage('images/yijian.png'),
                          )),
                      SizedBox( height: 10, ),
                      Text("意见反馈",style: TextStyle(fontSize: 14 )),
                    ],
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: (){
                  NavigatorUtils.jumpWebViewPage(contex, "关于我们", "https://mp.weixin.qq.com/s/0ZPCVceX1_LssuWMDIpJzA");
                },
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 25,
                          height: 25,
                          child: Image(
                            image: AssetImage('images/guanyu.png'),
                          )),
                      SizedBox( height: 10, ),
                      Text("关于我们",style: TextStyle(fontSize: 14 )),

                    ],
                  ),
                ),
              ),

              // GestureDetector(
              //
              //   onTap: (){
              //
              //   },
              //   child: Container(
              //     // color: Colors.red,
              //     child: Column(
              //       children: <Widget>[
              //         Container(
              //             width: 24,
              //             height: 24,
              //             child: Image(
              //               image: AssetImage('images/gengxin.png'),
              //             )),
              //         SizedBox( height: 10, ),
              //         Text("版本更新",style: TextStyle(fontSize: 14 )),
              //
              //       ],
              //     ),
              //   ),
              // ),

              GestureDetector(

                onTap: (){

                  _ExitSing(contex);
                },
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 24,
                          height: 24,
                          child: Image(
                            image: AssetImage('images/tuichu.png'),
                          )),
                      SizedBox( height: 10, ),
                      Text("退出登陆",style: TextStyle(fontSize: 14 )),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}


void _ExitSing(BuildContext context) async{


  JhDialog.show(context,title: "提示",content:"是否确定退出登录。。",onConfirm: (){
    DataUtils.ExitSignData({},success: (data){
      print("返回数据： ============>>>>>>  $data");

      if(data["code"] == 200){
        AppSettingUtils.saveString(KEY.TOKEN_KEY,"");
        print(AppSettingUtils.getStringWithKey(KEY.TOKEN_KEY));
        Navigator.pushAndRemoveUntil(context,
            new MaterialPageRoute(builder: (BuildContext c) {
              return CodeLoginPage();
            }), (r) => r == null);
      }
    }, fail: (error){});
  });
}

//个人信息

class userData extends StatelessWidget{


  static String headurl = "http://doos-file-resource.oss-cn-shanghai.aliyuncs.com/tutor/default.jpg,";
  UserDataModel model;
  userData({Key key ,this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      color: KColor.NavMainColor,
      padding: EdgeInsets.only(bottom: 40),
      child:Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 25,top: 10),
              child: Center(
                  child:  Container(
                    child: GestureDetector(
                      onTap:() {

                        print("-----------");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          AppSettingUtils.getStringWithKey(KEY.HEADURL_KEY)==null?headurl:AppSettingUtils.getStringWithKey(KEY.HEADURL_KEY),
                          // "images/icon02.png",
                          width: 75,
                          height: 75,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border:Border.all(color: Colors.white, width: 1)
                    ),
                  )
              ),
            ),

            Padding(padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Text(AppSettingUtils.getStringWithKey(KEY.NAME_KEY) , style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white,),),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text("教龄：${AppSettingUtils.getStringWithKey(KEY.EXPER_KEY)}" , style: TextStyle(fontSize: 16, color: Colors.white,),),
                  Text("地址：${AppSettingUtils.getStringWithKey(KEY.ADDRESS_KEY)}" , style: TextStyle(fontSize: 16, color: Colors.white,),)
                ],
              ),
            ),
          ],
      )
    );
  }

}

//课时费
class costExpanded extends StatelessWidget{

  UserDataModel model;
  costExpanded({Key key ,this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

         child: Row(
           children: [
             Expanded(child: Center(
               child: Column(
                 children: [
                   Padding(padding: EdgeInsets.only(top: 10)),
                   Text("${model==null?"":model.data.totalHours}h",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                   ),),
                   Padding(padding: EdgeInsets.only(top: 3)),
                   Text("总课时",style: TextStyle(
                     fontSize: 12,
                     color: Colors.black,
                   ),)
                 ],
               ),
             ),flex: 1),

             Expanded(child:
             Center(
               child: Column(
                 children: [

                   Padding(padding: EdgeInsets.only(top: 10)),
                   Text("${model==null?"":model.data.settlementHours}h",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                   ),),
                   Padding(padding: EdgeInsets.only(top: 3)),
                   Text("可提课时",style: TextStyle(
                     fontSize: 12,
                     color: Colors.black,
                   ),)
                 ],
               ),
             ),flex: 1),

             Expanded(child: Center(
               child: Column(
                 children: [
                   Padding(padding: EdgeInsets.only(top: 10)),
                   Text("${model==null?"":model.data.settlementMoney}¥",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                   ),),

                   Padding(padding: EdgeInsets.only(top: 3)),
                   Text("可提课时费",style: TextStyle(
                     fontSize: 12,
                     color: Colors.black,
                   ),),
                 ],
               ),
             ),flex: 1)
           ],
         ),
       );
  }
}



