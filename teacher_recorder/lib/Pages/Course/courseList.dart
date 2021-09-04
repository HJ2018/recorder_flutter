
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../Course/Model/RecordListModel.dart';
import '../Course/Model/RecordDetailModel.dart';
import 'package:percent_indicator/percent_indicator.dart';

var pageIndex = 0; //页数
var groupData = [];

class ListViewGroupPage extends StatefulWidget {

  final String _passValue;
  final String studentName;
  final String content;
  ListViewGroupPage(this._passValue,this.studentName,this.content);
  @override
  _ListViewGroupPageState createState() => _ListViewGroupPageState(_passValue,this.studentName,this.content);
}

class _ListViewGroupPageState extends State<ListViewGroupPage>
    with SingleTickerProviderStateMixin {


  final String value;
  final String studentName;
  final String content;
  EasyRefreshController _controller = EasyRefreshController();

  RecordListModel Model;
  RecordDetailModel headModel;
  _ListViewGroupPageState(this.value,this.studentName,this.content);


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getHeadData();
  }


  void getHeadData() async {

    print("================value=================$value");
    DataUtils.RoomDetailData({"classRoomId": value},
        success: (result) {
          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);

          // print("=================================$json");
          setState(() {
            headModel = RecordDetailModel.fromJson(json);
          });
        }, fail: (code) {});
  }

  void getNewData() async{
    pageIndex = 1;
    print("pageIndex- ${pageIndex}");

    print("================value=================$value");
    DataUtils.RecordListData({"page": pageIndex, "pageSize": 10, "classRoomId": value},
        success: (result) {
          print(result);
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = RecordListModel.fromJson(json);
          setState(() {
            groupData = Model.data.records;
            _controller.resetLoadState();
          });
        }, fail: (code) {});
  }

  void getMoreData() {
    pageIndex++;
    print("======$pageIndex");
    DataUtils.RecordListData({"page": pageIndex, "pageSize": 10, "classRoomId": value},
        success: (result) {
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          Model = RecordListModel.fromJson(json);
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.NavMainColor,
        title: Text("课程列表"),
        brightness: Brightness.dark,
        actions: [
          TextButton(child:  Text("加课",style: TextStyle(
              color: Colors.white,
              fontSize: 17
          ),),onPressed:(){
            String Name = Uri.encodeComponent("${studentName}");
            String detailsContent = Uri.encodeComponent("${content}");
            NavigatorUtils.pushNamed(context,
                "${"cardDetails"}?classRoomId=${value}&classCourseId=${""}&studentName=${Name}&content=${detailsContent}");
          })
        ],
      ),
//      body: _content(),
      body: _refresh(),
    );

  }

  //刷新
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
      child: _content(),
      onRefresh: () async {
        getNewData();
      },
      onLoad: () async {
        getMoreData();
      },
    );
  }
  // content
  Widget _content() {
    return ListView.builder(
        itemCount: groupData.length + 1,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              //处理点击事件
              if(index > 0){
                NavigatorUtils.pushNamed(context, "${"courseDetatils"}?classRoomId=${value}");
              }
              },
            child:index == 0 ? _topHeader() :_listData(groupData[index-1])
          );
          // return
        });
  }

  Widget _topHeader() {
    return Container(
        padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 15)),
            InkWell(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: double.infinity,
                  height: 150,
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
                                            child:Text(headModel == null? "--":headModel.data.studentName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),
                                            child:Text("${headModel == null? "--":headModel.data.studentName} ｜ ${headModel == null? "--":headModel.data.gradeName}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),
                                            child: weizhiTitle(headModel == null? "--":headModel.data.address, "images/weizhi.png",),
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
                                            headModel == null? "--":headModel.data.subjectName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),flex: 1,)

                                  ],
                                ),flex:3),

                                Expanded(child:Row(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    // Text("", style: TextStyle(color: Colors.grey)),
                                    SizedBox(width: 8),
                                    LinearPercentIndicator(
                                      width:  MediaQuery.of(context).size.width - 120,
                                      lineHeight: 10.0,
                                      animation: true,
                                      percent: double.parse(headModel == null? "1":headModel.data.consumeHours.toString()) / double.parse(headModel == null? "1":headModel.data.totalHours.toString()),
                                      backgroundColor: Color(0xFFDCDCE6),
                                      progressColor: KColor.NavMainColor,
                                    ),
                                    SizedBox(width: 8),
                                    Text('${headModel == null? "0":headModel.data.consumeHours}/${headModel == null? "0":headModel.data.totalHours}', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),flex: 1,)
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

  Widget _listData(Record model){

    return Container(
      padding: EdgeInsets.all(10),

      child: StickyHeader(
        header: Container(
          height: 35.0,
          // color: Color.fromARGB(20, 80, 190, 115),
          // alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color:  Color.fromARGB(20, 80, 190, 115),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 232, 242, 236),
                    blurRadius: 0.5, //阴影模糊程度
                    spreadRadius: 1.0 //阴影扩散程度
                )
              ]
          ),

          child: Row(
            children: <Widget>[

              Padding(padding: EdgeInsets.only(left: 15)),
              Text("${model.classDate} " ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

            ],
          ),
        ),
        content: Container(
          height: 150,
          decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(12, 168, 168, 168),
                    blurRadius: 0.5, //阴影模糊程度
                    spreadRadius: 1.0 //阴影扩散程度
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Text("${model.studentName}" ,style: TextStyle(fontSize: 17),),
              Expanded(child: Row(
                children: [
                  Expanded(child: Padding(padding: EdgeInsets.only(left: 15,top: 5),
                  child: Text("${model.studentName}" ,style: TextStyle(fontSize: 18),),
                  ),flex: 1,),

                  Expanded(child: Padding(padding: EdgeInsets.only(left:  (MediaQuery.of(context).size.width-20)/2 -60,top: 5),
                    child: Text("160¥" ,style: TextStyle(fontSize: 17,color: Colours.red),),
                  ),flex: 1,),
                ],
              ),flex: 1,),

              Expanded(child: Padding(padding: EdgeInsets.only(left: 15,top: 5),
                child:Row(
                  children: [
                    Expanded(child: Text("课时: ${model.hours}h",style: TextStyle(fontSize: 14)),flex: 1,),
                    Expanded(child: Text("上课时间: ${model.beginTime}-${model.endTime}",style: TextStyle(fontSize: 15)),flex: 2,),
                  ],
                ),
              ),flex: 1,),

              Expanded(child: Padding(padding: EdgeInsets.only(left: 15,top: 5),
              child: Text("上课地址: ${model.startClassAddress}",overflow: TextOverflow.ellipsis,
                  maxLines: 1,style: TextStyle(fontSize: 14)),
              ),flex: 1,),

              Expanded(child: Padding(padding: EdgeInsets.only(left: 15,top: 5),
              child: Text("下课地址: ${model.endClassAddress}",overflow: TextOverflow.ellipsis,
                  maxLines: 1,style: TextStyle(fontSize: 14)),
              ),flex: 1,),

            ],
          ),
        ),
      ),
    );
  }

  Widget cell() {
    return
      Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 15)),
        InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              width: double.infinity,
              height: 210,
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
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(padding: EdgeInsets.only(top: 15),
                                        child:Text(headModel == null? "--":headModel.data.studentName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 10),
                                        child:Text("${headModel == null? "--":headModel.data.studentName} ｜ ${headModel == null? "--":headModel.data.gradeName}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 10),
                                        child: weizhiTitle(headModel == null? "--":headModel.data.address, "images/weizhi.png",),
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
                                        headModel == null? "--":headModel.data.subjectName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),flex: 1,)

                              ],
                            ),flex:3),

                            Expanded(child:Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 10)),
                                // Text("", style: TextStyle(color: Colors.grey)),
                                SizedBox(width: 8),
                                LinearPercentIndicator(
                                  width:  MediaQuery.of(context).size.width - 140,
                                  lineHeight: 10.0,
                                  animation: true,
                                  percent: double.parse(headModel.data.consumeHours.toString()) / double.parse(headModel.data.totalHours.toString()),
                                  backgroundColor: Color(0xFFDCDCE6),
                                  progressColor: KColor.NavMainColor,
                                ),
                                SizedBox(width: 8),
                                Text('${headModel.data.consumeHours}/${headModel.data.totalHours}', style: TextStyle(color: Colors.grey)),
                              ],
                            ),flex: 1,)
                          ],
                        ),
                      )
                  ),
                ],
              ),
            )
        )
      ],
    );
  }

}
