import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:teacher_recorder/Pages/Order/Model/MatchingListModel.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';

var pageIndex = 0; //页数
var groupData = [];

class auditPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _auditPageState();
  }
}

class _auditPageState extends State<auditPage> {


  EasyRefreshController _controller = EasyRefreshController();


  MatchingListModel Model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getNewData() async{
    pageIndex = 1;
    print("pageIndex- ${pageIndex}");

    DataUtils.MatchingListData({"page": pageIndex, "pageSize": 10, "state":"0"},
        success: (result) {
          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model =  MatchingListModel.fromJson(json);
          setState(() {
            groupData = Model.data.records;
            _controller.resetLoadState();
          });

        }, fail: (code) {});
  }

  void getMoreData() {
    pageIndex++;
    print("======$pageIndex");
    DataUtils.MatchingListData({"page": pageIndex, "pageSize": 10,"state":"0"},
        success: (result) {

          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = MatchingListModel.fromJson(json);
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
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: KColor.NavMainColor,
      //   title: Text("接单"),
      //   brightness: Brightness.dark,
      // ),
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
        child:  Text("暂无审核数据...",textAlign: TextAlign.center,style:  TextStyle(fontSize: 17.0,color: Colors.grey)),
      );

    }else{
      return ListView.separated(
        itemCount: groupData.length,
        itemBuilder:(context, index) {

          return new GestureDetector(
            onTap: () {
              //处理点击事件
              Record model = groupData[index];
              String start = Uri.encodeComponent(model.tutorAddress==null? "置地广场写字楼":model.tutorAddress);
              String end = Uri.encodeComponent(model.address);
              NavigatorUtils.pushNamed(context, "${"orderRouteMap"}?start=${start}&end=${end}");

            },
            child:_ContentItem(groupData[index]),
          );



        },

        separatorBuilder: (context, index) {
          return Divider(
            height: .5,
            indent: 15,
            endIndent: 15,
            color: Colors.white,
          );
        },
      );
    }
  }

  Widget _ContentItem(Record model){

    return Container(
      // height: 200,
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
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width-220,
                      child: Text("${model.address}",textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1,style: TextStyle(fontSize: 18.0)),
                    ),
                    //distance
                    Text("距离:${model.distance==null?"0":model.distance}km",style: TextStyle(fontSize: 12.0)),
                  ],
                ),

                Text("审核中",style:  TextStyle(color: Colors.orange),),

              ],
            ),

            SizedBox(height: 5),
            Text("${model.grade} ｜ ${model.subject} ｜ ${model.studentSex}",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 10),

            RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "要求：",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "${model.tutorRequirement}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14),
                  )
                ]
            )),
            SizedBox(height: 10),
            RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "学员情况：",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "${model.studentSituation}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14),
                  )
                ]
            )),
          ],
        )
    );
  }


}


