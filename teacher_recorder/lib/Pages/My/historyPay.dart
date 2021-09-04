import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../My/Model/withdrawalListModel.dart';

var pageIndex = 0; //页数
var groupData = [];
class HistoryPay extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return HistoryPayState();
  }

}

class HistoryPayState extends State<HistoryPay>{

  EasyRefreshController _controller = EasyRefreshController();

  WithdrawalListModel Model;

  void getNewData() async{
    pageIndex = 1;
    print("pageIndex- ${pageIndex}");

    DataUtils.WithdrawalListData({"page": pageIndex, "pageSize": 10, },
        success: (result) {
          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = WithdrawalListModel.fromJson(json);
          setState(() {
            groupData = Model.data.records;
            _controller.resetLoadState();
          });

        }, fail: (code) {});
  }

  void getMoreData() {
    pageIndex++;
    print("======$pageIndex");
    DataUtils.WithdrawalListData({"page": pageIndex, "pageSize": 10},
        success: (result) {

          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = WithdrawalListModel.fromJson(json);
          var moreData = Model.data.records;
          setState(() {
            if (moreData.length > 0) {
              _controller.finishLoad();
              groupData = groupData + moreData;
            } else {
              _controller.finishLoad(noMore: true);
            }
          });
        }, fail: (code) {});
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.NavMainColor,
        title: Text("提现记录"),
        brightness: Brightness.dark,
      ),
      body: _refresh(),
    );
  }

  Widget _refresh() {
    return EasyRefresh(
      header: ClassicalHeader(
        enableInfiniteRefresh: false,
        refreshText: '下拉刷新',
        refreshReadyText: '释放刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
        noMoreText: '没有更多',
        showInfo: false,
      ),
      footer: ClassicalFooter(
        loadingText:"加载中...",
        loadedText:"加载完成",
        noMoreText: "没有更多",
        showInfo: false,
      ),
      controller: _controller,
      firstRefresh: true,
      child: _cellItem(),
      onRefresh: () async {
        getNewData();
      },
      onLoad: () async {
        getMoreData();
      },
    );
  }

  Widget _cellItem(){

    if(groupData.length==0){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        //    alignment: Alignment.center,
        child:  Text("暂无数据",textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: Colors.grey)),
      );

    }else{
      return  ListView.separated(
        itemCount: groupData.length,
        itemBuilder:(context, index) {
          return _dataList(groupData[index]);
        },

        separatorBuilder: (context, index) {
          return Divider(
            height: .5,
            color: Colors.white,
          );
        },
      );
    }
  }


  Widget _dataList(Record Data){

    return Container(
        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: EdgeInsets.only(left: 15,top: 8,right: 15,bottom: 15),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: Colors.black12,
                blurRadius: 0.5, //阴影模糊程度
                // spreadRadius: 1,//阴影扩散程度
              )
            ]
        ),
        // color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${Data.startTime}",style: TextStyle(fontSize: 18.0)),
                Text("${Data.state == "2"? "提现成功":"处理中"}",style: TextStyle(color: Data.state == "2"? KColor.NavMainColor:Colors.red)),

              ],
            ),

            SizedBox(height: 15),
            RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "交易金额: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text: "${Data.money}¥",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,fontWeight: FontWeight.bold),
                  )
                ]
            )),
            SizedBox(height: 8),
            Text("提现方式: 支付宝",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 8),
            Text("提现账号: ${Data.account}"),
            SizedBox(height: 8),
            Text("交易单号: ${Data.orderNo}"),
          ],
        )
    );
  }

}
