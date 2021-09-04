import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teacher_recorder/Pages/Home/child/BMlocationTool.dart';
import 'dart:io' show Platform;
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'dart:async';
import 'package:teacher_recorder/component/Tool/date_util.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../model/homeModel.dart';
import 'package:teacher_recorder/component/Tool/jh_dialog.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';


class TapBoxA extends StatefulWidget {

  @override
  TapBoxAState createState() {
    return TapBoxAState();
  }
}

class TapBoxAState extends State<TapBoxA> {


  Map<String, Object> _loationResult;
  BaiduLocation _baiduLocation; // 定位结果
  StreamSubscription<Map<String, Object>> _locationListener;
  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();
  String addressname ="--";

  BMFCoordinate startCoord;
  BMFCoordinate endCoord;

  HomeModel Model;

  bool aActive = true;


  @override
  void initState() {
    super.initState();

    /// 动态申请定位权限
    _locationPlugin.requestPermission();

    /// 设置ios端ak, android端ak可以直接在清单文件中配置
    LocationFlutterPlugin.setApiKey("pG0QFKQ9S7bpz5MoHqunY7rFuN45yAhP");

    _locationListener = _locationPlugin
        .onResultCallback()
        .listen((Map<String, Object> result) {
      setState(() {
        _loationResult = result;
        try {
          _baiduLocation = BaiduLocation.fromMap(result); // 将原生端返回的定位结果信息存储在定位结果类中
          print(_baiduLocation);
        } catch (e) {
          print(e);
        }
      });
    });

    getData();

  }

  void getData() async {

    DataUtils.DakahomeData({},success: (data){
      print("返回数据： ============>>>>>>  $data");
      Map<String, dynamic> json = Map<String, dynamic>.from(data);
      setState(() {
        Model = HomeModel.fromJson(json);
        if(Model.data.courseVo.takingClassState == "1"){
          // setState(() {
            aActive = false;
          // });
        }else{
          // setState(() {
            aActive = true;
          // });
        }
      });
      // print("返回数据： ============>>>>>>    +++${Model.data.courseVo.address}====" );
    }, fail: (error){
    });
  }


  @override
  Widget build(BuildContext context) {

    if (null != _locationPlugin && _loationResult == null) {
      BMLocationTool.setLocOption(_locationPlugin);
      _locationPlugin.startLocation();

    }
    if (null != _locationPlugin && _loationResult != null) {
      _locationPlugin.stopLocation();
      startCoord=BMFCoordinate(_loationResult["latitude"],_loationResult["longitude"]);
    }

    if(Model != null && Model.data !=null){
      endCoord=BMFCoordinate(double.parse(Model.data.courseVo.latitude),double.parse(Model.data.courseVo.longitude));
    }

    // print("${_loationResult["errorCode"]}====${_loationResult}");
    //
    if (_loationResult != null && _loationResult["errorCode"] == null) {

      // print('==================$_loationResult:' );
      String string;
      if (Platform.isIOS) {
        string = _loationResult["address"];
        List lists = [];
        if (string != null){
          lists = string.split('|');
        }
        if(lists.length > 1) {
          addressname = "当前位置:${lists[lists.length - 2]}${lists[lists.length - 1]}";
        }
      } else if (Platform.isAndroid) {
        addressname = "当前位置:${_loationResult["locationDetail"]}";
      }
    }

    return Container(

        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            Expanded(
                flex: 2,
                child:Padding(padding: EdgeInsets.only(left: 15,top: 10,right: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width-30,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(12, 168, 168, 168),
                              blurRadius: 0.5, //阴影模糊程度
                              spreadRadius: 1.0 //阴影扩散程度
                          )
                        ]
                    ),
                    child: TopSum(),
                  ),
                ),
            ),

            Expanded(
              flex: 2,
              child: Padding(padding: EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width-30,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(12, 168, 168, 168),
                            blurRadius: 0.5, //阴影模糊程度
                            spreadRadius: 1.0 //阴影扩散程度
                        )
                      ]
                  ),
                  child: TopWeeks(),
                ),
              ),

            ),

            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Expanded(child: GestureDetector(

                      onTap:() {
                        Future.delayed(Duration.zero,(){
                          getDistance();
                        });
                      },
                      child: selsctBtn(aActive),
                    ),flex: 4,),

                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap:() {
                            NavigatorUtils.pushNamed(context, "mapPage");
                          },
                          child: Text(addressname),
                        )
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }


  getDistance() async {

    if(addressname == "--"){
      JhDialog.show(context,title: "提示",content: "请检查位置服务是否打卡。。",hiddenCancel: true);
    }else{
      if (Model == null){
        msgAlterK('正在获取学生位置！');
      }else{
        dakaAlterK(aActive, aActive? "开始上课" : "结束上课");
      }
    }
  }
  //

  void msgAlterK( msg){

    JhDialog.show(context,title: "提示",
        content: msg,
        rightText: '好的',hiddenCancel: true);
  }

  void dakaAlterK(aActive , msg) async{

    double distance = await BMFCalculateUtils.getLocationDistance(startCoord,endCoord);
    // print("==========$distance");

    JhDialog.show(context, title: "提示", content:msg ,  onConfirm: () {

      if(aActive == false){
       endData();
      }else{
        if(distance <1000 && distance>0){
          beginsData();
        }else{
          msgAlterK('请到指定学生位置打卡！');
        }

      }
    });
  }

  void endData() async {

    Map<String, dynamic> parameters = {
      'classRoomId': Model.data.courseVo.classRoomId,  //课堂ID
      'courseId': Model.data.courseVo.id,  //课程ID
      'longitude': _loationResult["longitude"], //经度
      'latitude': _loationResult["latitude"], //纬度
      'address': addressname, //打卡地址
    };
     DataUtils.endDakaData(parameters,success: (data){
      if(data["code"] == 200){

        pushVc();
        Future.delayed(Duration(milliseconds: 10), () {
          setState (() {
            aActive = true;
          });
        });
      }
    }, fail: (error){
    });

  }

 void pushVc() {
    NavigatorUtils.pushNamedResult(
       context, '${"FeedBack"}?classRecordId=${Model.data.courseVo.classRoomId}',
           (value) {
         JhDialog.show(context, title: "提示", content:"提交成功，赶快分享到微信群里吧！！" ,  onConfirm: () {
           NavigatorUtils.pushNamed(context, "${"courseDetatils"}?classRoomId=${value}");
         });
       });
}

  void beginsData() async {

    Map<String, dynamic> parameters = {
      'classRoomId': Model.data.courseVo.classRoomId,  //课堂ID
      'courseId': Model.data.courseVo.id,  //课程ID
      'longitude': _loationResult["longitude"], //经度
      'latitude': _loationResult["latitude"], //纬度
      'address': addressname, //打卡地址
    };
    DataUtils.beginDakaData(parameters,success: (data){
      if(data["code"] == 200){
        // print("返回数据： ============>>>>>>  ${data["code"]}");
        setState(() {
          aActive = false;
        });
      }
    }, fail: (error){
    });
  }

  Widget selsctBtn(aActive){

    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 150.0,
        height: 150.0,
        child: Text(
          aActive ? '开始上课' : '结束上课',
          style: TextStyle(fontSize: 28.0, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            color: aActive ? KColor.NavMainColor : Colors.grey
        ),
      ),
    );
  }

  Widget TopSum() {


    String newStr = DateUtil.formatZHDateTime(DateUtil.getNowDateStr(), DateFormat.ZH_YEAR_MONTH, "-" );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child:Padding(padding: EdgeInsets.only(left: 15,top: 10),
          child:Text(
              "${newStr}汇总" , style: TextStyle(
            fontSize: 20,)
          ),
        ), flex: 3,),

        // Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(child:
        Row(
          children: [
            Expanded(child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("${Model==null? 0:Model.data.monthVo.hours}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text("消耗课时(小时) ",style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                  ),)
                ],
              ),
            ),flex: 1),

            Expanded(child:
            Center(
              child: Column(
                children: [

                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("${Model==null? 0:Model.data.monthVo.hoursCost}¥",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text("课时费(元)",style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                  ),)
                ],
              ),
            ),flex: 1),

            Expanded(child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("${Model==null? 0:Model.data.monthVo.transferNum}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),),

                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text("调课(次)",style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                  ),),
                ],
              ),
            ),flex: 1)
          ],
        ), flex: 5,),
      ],
    );
  }


  Widget TopWeeks() {


    String newStr = DateUtil.formatZHDateTime(DateUtil.getNowDateStr(), DateFormat.ZH_YEAR_MONTH, "-" );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child:Padding(padding: EdgeInsets.only(left: 15,top: 10),
          child:Text(
              "一周课程" , style: TextStyle(
            fontSize: 20,)
          ),
        ), flex: 3,),

        // Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(child:
        Row(
          children: [
            Expanded(child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("${Model==null? 0:Model.data.weekVo.totalHours}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text("总课时(小时) ",style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                  ),)
                ],
              ),
            ),flex: 1),

            Expanded(child:
            Center(
              child: Column(
                children: [

                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("${Model==null? 0:Model.data.weekVo.consumeHours}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text("已上课时(小时)",style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                  ),)
                ],
              ),
            ),flex: 1),

            Expanded(child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text("${Model==null? 0:Model.data.weekVo.surplusHours}",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),),

                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text("剩余课时(小时)",style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                  ),),
                ],
              ),
            ),flex: 1)
          ],
        ), flex: 5,),
      ],
    );
  }


}

