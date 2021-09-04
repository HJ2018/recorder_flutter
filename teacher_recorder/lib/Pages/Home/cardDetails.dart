import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/My/child/MyFeedbackchiild.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/jh_dialog.dart';
import 'package:teacher_recorder/component/Tool/jh_picker_tool.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';


class CardDetails extends StatefulWidget{


  String classRoomId;
  String classCourseId;
  String studentName;
  String content;


  CardDetails({Key key ,
    this.classRoomId,
    this.classCourseId,
    this.studentName,
    this.content
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return CardDetailsState(
        this.classRoomId,
        this.classCourseId,
        this.studentName,
        this.content);
  }

}

class CardDetailsState extends State<CardDetails>{


  String classRoomId;
  String classCourseId;
  String studentName;
  String content;

  CardDetailsState(
      this.classRoomId,
      this.classCourseId,
      this.studentName,
      this.content
      );

  FocusNode blankNode = FocusNode();

  String startTime = "";
  String endTime ="";
  String noteContent ="";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(

      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(blankNode);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColor.NavMainColor,
          title: Text(classCourseId.length>0?"补卡申请":"加课申请"),
          brightness: Brightness.dark,
        ),
        body: _cellItem(),
      ),
    );
  }


  Widget _cellItem(){

    return Column(
      children: [

        Expanded(child:  ListView.separated(
          itemCount: 4,
          itemBuilder:(context, index) {

            return _dataList(index);
          },

          separatorBuilder: (context, index) {
            return Divider(
              height: .5,
              color: Colors.white,
            );
          },
        ),flex: 4,),

        Padding(padding: EdgeInsets.only(bottom: 40),child:FlatButton(
          color: KColor.NavMainColor,
          textColor: Colors.white,
          minWidth: MediaQuery.of(context).size.width-80,
          height: 50,
          child: new Text('提交'),
          onPressed: () {
            submitData();
          },
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ))

      ],
    );
  }

  void submitData() async{


    if(startTime ==""){
      JhDialog.show(context,title: "提示",content: "请输入上课时间。。。",hiddenCancel: true);
      return;
    }
    if(endTime == ""){
      JhDialog.show(context,title: "提示",content: "请输入下课时间。。。",hiddenCancel: true);
      return;
    }
    DataUtils.patchRecordData({
      "classRoomId":classRoomId,
      "classCourseId":classCourseId,
      "classBeginTime":startTime,
      "classEndTime":endTime,
      "remark":noteContent,
    },success: (data){

      if(data["code"] == 200){
        JhDialog.show(context, title: "提示", content:classCourseId==null?"加课成功!":"补卡成功!" ,  onConfirm: () {
          NavigatorUtils.pushNamed(context, "${"FeedBack"}?classRoomId=${data["data"]}");
        });

      }
    },fail: (code){
    });
  }

  Widget _dataList(int index){

    if(index == 0){
      return Container(
        padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 5),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 15)),
            InkWell(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: double.infinity,
                  height: 100,
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
                                            child:Text(studentName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 10),
                                            child:Text(content,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ),
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
                                            classCourseId.length>0?"补卡":"加课",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 24),
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
    }else if(index == 1){
      return Padding(padding: EdgeInsets.only(left: 10,top: 5,right: 10),
        child:Container(
          padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
          width: double.infinity,
          height: 44,
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
          child: Row(
            children: [
              Text("开始时间",style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(left: 15)),
              Container(
                child: GestureDetector(
                  onTap: (){

                    JhPickerTool.showDatePicker(
                        context,
                        dateType: DateType.YMD_AP_HM,
                        clickCallback: (var str,var time){
                          print(str);
                          setState(() {
                            startTime = str;
                          });
                        }
                    );
                  },
                  child: Text(startTime.length == 0? "请选择上课时间。。":startTime,style: TextStyle(color: startTime.length == 0? Colors.grey:Colors.black)),
                ),
              )
            ],
          ),
        ),);
    }else if(index == 2){
      return Padding(padding: EdgeInsets.only(left: 10,bottom: 10,right: 10,top: 5),
        child:Container(
          padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
          width: double.infinity,
          height: 44,
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
          child: Row(
            children: [
              Text("结束时间",style: TextStyle(fontWeight: FontWeight.bold),),
              Padding(padding: EdgeInsets.only(left: 15)),
              Container(
                child: GestureDetector(
                  onTap: (){
                    JhPickerTool.showDatePicker(
                        context,
                        dateType: DateType.YMD_HM,
                        clickCallback: (var str,var time){
                          print(str);
                          setState(() {
                            endTime = str;
                          });
                        }
                    );
                  },
                  child: Text(endTime.length == 0? "请选择下课课时间。。":endTime,style: TextStyle(color:endTime.length == 0? Colors.grey:Colors.black)),
                ),
              )
            ],
          ),
        ),);
    } else if(index == 3){
      return Padding(padding: EdgeInsets.only(left: 5,top: 10,right: 5,bottom: 10),
        child: MyTextInput(
            hint: "备注",
            height: 120,
            onChanged: (str) {
              print("$str");
              noteContent = str;
            }),
      );
    }
  }

}
