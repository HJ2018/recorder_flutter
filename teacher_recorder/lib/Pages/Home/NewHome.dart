import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teacher_recorder/Pages/Home/clockController.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:teacher_recorder/component/Tool/jh_progress_hud.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../Home/child/marqueeTool/flutter_marquee.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import '../Home/model/HomeindexModel.dart';


class NewHomePage extends StatefulWidget{


  NewHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewHomePageState();
  }

}

class NewHomePageState extends State<NewHomePage>{

  List imgList = [
    // "https://gitee.com/iotjh/Picture/raw/master/cat.png",
    // "https://gitee.com/iotjh/Picture/raw/master/lufei2.png",
    // "https://gitee.com/iotjh/Picture/raw/master/swiper/picture0.jpeg",
  ];

  List linkUrlList = [];

  List titleList = [];

  HomeindexModel Model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getHomeData();
  }

  void getHomeData() async {

    DataUtils.NewHomeData({},success: (data){
      print("返回数据： ============>>>>>>  $data");
      Map<String, dynamic> json = Map<String, dynamic>.from(data);

      setState(() {
        Model = HomeindexModel.fromJson(json);
        if(imgList.length == 0){
          Model.data.activityList.forEach((item) {
            imgList.add(item.imgUrl);
          });
        }
        if(linkUrlList.length == 0){
          Model.data.activityList.forEach((item) {
            linkUrlList.add(item.linkUrl);
          });
        }
        if(titleList.length == 0){
          Model.data.activityList.forEach((item) {
            titleList.add(item.title);
          });
        }

      });

    }, fail: (error){});
  }

  Future<void> _refresh() async{
    return getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColor.NavMainColor,
          title: Text("首页"),
          brightness: Brightness.dark,
        ),
        body: Center(
          child: _content(),
        ),
      ),
      onRefresh:_refresh,
    );
  }


  // content
  Widget _content() {

    return ListView.builder(
        itemCount: Model==null?0:Model.data.courseVo.studentName==""? Model.data.matchingList.length+2: Model.data.matchingList.length+3,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              //处理点击事件
              if (Model.data.courseVo.studentName == "") {
                if(index >1){
                  _jump(index-2);
                }

              } else {
                if(index == 1){
                  // NavigatorUtils.pushNamed(context, "clock");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return clockPage();
                  })).then((value){
                    getHomeData();
                  });

                }else if(index >2){
                  _jump(index-3);

                }
                print("------$index");
              }
            },
            child:Model.data.courseVo.studentName==""? _cellItem2(index):_cellItem1(index),
          );
          // return
        });

  }

   _jump(int index){

     String start = Uri.encodeComponent(Model.data.matchingList[index].tutorAddress==null? "置地广场写字楼":Model.data.matchingList[index].tutorAddress);
     String end = Uri.encodeComponent(Model.data.matchingList[index].address);
     NavigatorUtils.pushNamed(context, "${"orderRouteMap"}?start=${start}&end=${end}");
  }

  Widget _cellItem1 (index){

    if(index == 0){
     return _topHeader();
    }else if(index ==1){
      return  _OneCell();
    }else if( index == 2){
      return _TwoCell();
    } else{
      return _TheerCell(index-3);
    }
  }

  Widget _cellItem2 (index){

    if(index == 0){
      return _topHeader();
    }else if( index == 1){
      return _TwoCell();
    } else{
      return _TheerCell(index-2);
    }
  }

  Widget _OneCell(){
    return Padding(padding: EdgeInsets.only(left: 15,top: 10,right: 15),
      child: Container(
        width: MediaQuery.of(context).size.width-30,
        height: 120,
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
        child: _Nextcourse(),
      ),
    );
  }
  Widget _TwoCell(){
    return Container(
      height: 55,
      child: Padding(padding: EdgeInsets.only(left: 15,top: 20),
        child: Text("附近学生" ,style:TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold) ,),
      ),
    );
  }
  Widget _TheerCell(int index){
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
                      child: Text("${Model.data.matchingList[index].address}",textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1,style: TextStyle(fontSize: 18.0)),
                    ),
                    Text("距离:${Model.data.matchingList[index].distance==null?"0":Model.data.matchingList[index].distance}km",style: TextStyle(fontSize: 12.0)),

                  ],
                ),

                new FlatButton(
                  color:Model.data.matchingList[index].applyState == "1"? KColor.kTextGrayColor:KColor.NavMainColor,
                  textColor: Colors.white,
                  minWidth: 50,
                  height: 32,

                  child: new Text(Model.data.matchingList[index].applyState == "1"?'已接单':"接单"),
                  onPressed: () {
                    if(Model.data.matchingList[index].applyState == "1"){
                      JhProgressHUD.showText("已接单。。");
                    }else{

                      DataUtils.GrabOrderData({"matchingId" : Model.data.matchingList[index].id},success: (data){
                        print("返回数据： ============>>>>>>  $data");
                        Map<String, dynamic> json = Map<String, dynamic>.from(data);

                        if(data["code"] == 200){
                          JhProgressHUD.showText("抢单成功。。。");
                          setState(() {
                            Model.data.matchingList[index].applyState = "1";
                          });
                        }
                      }, fail: (error){});
                    }
                  },
                )
              ],
            ),

            SizedBox(height: 5),
            Text("${Model.data.matchingList[index].grade} ｜ ${Model.data.matchingList[index].subject} ｜ ${Model==null?"":Model.data.matchingList[index].studentSex}",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0)),
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
                    text: Model.data.matchingList[index].tutorRequirement,
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
                    text:Model.data.matchingList[index].studentSituation,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14),
                  )
                ]
            )),
            SizedBox(height: 10),
            Row(
              children: [
              ],
            )
          ],
        )
    );
  }

  Widget _topHeader() {
    return Container(
        // padding: EdgeInsets.all(15),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              height: 200,
              child: Swiper(
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(imgList[index]),
                          fit: BoxFit.fill,
                        )),
                  );
                },
                onTap: (index) {
                  print('点击了第${index}');
                  NavigatorUtils.jumpWebViewPage(context, titleList[index], linkUrlList[index]);
                },
                // 分页指示器
                pagination: SwiperPagination(
                  // 位置 Alignment.bottomCenter 底部中间
                    alignment: Alignment.bottomCenter,
                    // 距离调整
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    builder: DotSwiperPaginationBuilder(
                      // 点之间的间隔
                        space: 5,
                        // 没选中时的大小
                        size: 5,
                        // 选中时的大小
                        activeSize: 6,
                        // 没选中时的颜色
                        color: Colors.grey,
                        // 选中时的颜色
                        activeColor: Colors.white)),
                // 页面控制器 左右翻页按钮
//          control: new SwiperControl(color: Colors.pink),
                scale: 0.9,
                // 两张图片之间的间隔
                viewportFraction: 0.9, // 当前视窗展示比例 小于1可见上一个和下一个视窗
              ),
            ),

            Row(
              children: [

                Padding(padding: EdgeInsets.only(left: 28),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Image.asset(
                      "images/tongzhi.png",
                      width: 15, height: 15,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8,top: 4,right: 4,bottom: 8),
                  height: 20,
                  width: MediaQuery.of(context).size.width-70,
                  child: FlutterMarquee(
                      texts:Model.data.broadcastList.toList(),
                      onChange: (i) {
                        print(i);
                      },
                      duration: 3),
                )
              ],
            )
          ],
        )

    );
  }

  Widget _Nextcourse() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            Expanded(child:Padding(padding: EdgeInsets.only(left: 15,top: 10),

              child:Model.data.courseVo.classCourseState == "0"?_NexClass("${Model.data.courseVo.nextClassDate} ${Model==null?"":Model.data.courseVo.nextClassDateTime}"):_Classing("${Model==null?"":Model.data.courseVo.nextClassDate} ${Model==null?"":Model.data.courseVo.nextClassDateTime}")
            ), flex: 4,),

            Expanded(child:Padding(padding: EdgeInsets.only(left: 15,top: 8),
              child: Image.asset(
                "images/next01.png",
                width: 25,
                height: 25,
              )
            ), flex: 1,),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 15),
                    child:Text("${Model.data.courseVo.studentName} ｜ ${Model.data.courseVo.grade}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15),
                    child: weizhiTitle("${Model.data.courseVo.address}", "images/weizhi.png",),
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
                    "${Model.data.courseVo.subject}",
                    style: TextStyle(
                        fontSize: 20),
                  ),
                ],
              ),
            ),flex: 1,)

          ],
        )

      ],
    );
  }

  Widget _NexClass(String content){

   return RichText(text: TextSpan(
        children: [
          TextSpan(
            text: "下次课程 ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16),
          )
        ]
    ));
  }

  Widget _Classing(String content){

   return RichText(text: TextSpan(
        children: [
          TextSpan(
            text: "上课中 ",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 16),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16),
          )
        ]
    ));
  }
}