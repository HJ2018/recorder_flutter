import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../Home/model/CardListMidel.dart';

var pageIndex = 0; //页数
var groupData = [];
class CardList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return CardListState();
  }

}

class CardListState extends State<CardList>{

  EasyRefreshController _controller = EasyRefreshController();

  CardListModel Model;

  void getNewData() async{
    pageIndex = 1;
    print("pageIndex- ${pageIndex}");

    DataUtils.NOCourseListData({"page": pageIndex, "pageSize": 10, },
        success: (result) {
          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = CardListModel.fromJson(json);
          setState(() {
            groupData = Model.data.records;
            _controller.resetLoadState();
          });

        }, fail: (code) {});
  }

  void getMoreData() {
    pageIndex++;
    print("======$pageIndex");
    DataUtils.NOCourseListData({"page": pageIndex, "pageSize": 10},
        success: (result) {

          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = CardListModel.fromJson(json);
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
        title: Text("补卡列表"),
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

          return new GestureDetector(
              onTap: () {
                Record model = groupData[index];
                String studentName = Uri.encodeComponent("${model.studentName}");
                String content = Uri.encodeComponent("${model.grade} | ${model.subject}");
                NavigatorUtils.pushNamed(context,
                    "${"cardDetails"}?classRoomId=${model.classRoomId}&classCourseId=${model.id}&studentName=${studentName}&content=${content}");
              },
              child:_dataList(groupData[index]),
          );
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

  Widget _dataList(Record model){
   return Container(
      padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 15)),
          InkWell(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: double.infinity,
                height: 120,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(12, 168, 168, 168),
                          blurRadius: 0.5, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                      )
                    ]
                ),

                child: Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child:Container(
                          // padding: EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Expanded(child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(padding: EdgeInsets.only(top: 15),
                                          child:Text(model == null? "--":model.studentName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10),
                                          child:Text("${model == null? "--":model.grade} ｜ ${model == null? "--":model.subject}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10),
                                          child: weizhiTitle(model == null? "--":model.address, "images/weizhi.png",),
                                        )
                                      ],
                                    ),
                                  ),flex: 3,),
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "待补卡",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),flex: 1,)

                                ],
                              ),flex:3),

                            ],
                          ),
                        )

                    ),
                  ],
                ),
              )
          )
        ],
      ),

    );
  }

}
