import 'package:flutter/material.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../Course/Model/classFeedbackModel.dart';

List TitleList = ["【上课内容】","【课后作业】","【课后反馈】"];

class courseDetatils extends StatefulWidget{

  final String _passValue;
  courseDetatils(this._passValue);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _courseDetatilsState(_passValue);
  }

}

class _courseDetatilsState extends State<courseDetatils>{


  
  List Contnt = [];
  String value;
  _courseDetatilsState(this.value);
  ClassFeedbackModel Model;

  @override
  void initState() {
    super.initState();

    getDatatilsData();
  }


  void getDatatilsData() async {

    DataUtils.RecordDetailData({ "recordId": value},
        success: (result) {
          Map<String, dynamic> json = Map<String, dynamic>.from(result);
          print("====================================$result");
          setState(() {
            Model = ClassFeedbackModel.fromJson(json);
            Contnt.add(Model.data.classContent);
            Contnt.add(Model.data.classHomework);
            Contnt.add(Model.data.classPerformance);
          });
        }, fail: (code) {});
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.NavMainColor,
        title: Text("课后反馈"),
        brightness: Brightness.dark,
      ),
      body: TableviewCell(Contnt),
    );
  }
}



Widget TableviewCell(List content) {

  return ListView.separated(

    itemBuilder: (BuildContext context , int index) {

      double H;
      Color color;
      if(index == 0){
        H = 130;
        color = Color.fromARGB(20, 192, 192, 192);
      }else if(index == 1){
        color = Color.fromARGB(80, 234, 244, 213);
      }else if(index == 2){
        color = Color.fromARGB(80, 205, 232, 232);
      }else if(index == 3){
        color = Color.fromARGB(80, 234, 244, 213);
      }

      return Container(
        child: index == 0 ? HedaView() : clleView(index-1 , content.length>0?content[index-1]:""),
        height: H,
        color:color,
      );
    },
    separatorBuilder:(BuildContext context , int index) {
      return Container(
        height: 1,
//          color: Color.fromARGB(100, 192, 192, 192),
      );
    } ,
    itemCount: 4,
  );
}

Widget HedaView(){

  return  Container(
    // color: Color.fromARGB(180, 192, 192, 192),
    child: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(child: Padding(padding: EdgeInsets.only(left: 10,top: 5),
            child: Text(
              "王老师",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),),
          ),flex: 1),

          Expanded(child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child:Padding(padding: EdgeInsets.only(left: 10,top: 10),
                child: Text(
                  "上课时间：2021-04-21 / 12:00 - 14:50",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  ),),
              ),flex: 1),

              Expanded(child:Padding(padding: EdgeInsets.only(bottom: 5,left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Text(
                      "上课时长：2h",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),),flex: 1),
                    Expanded(child:Text(
                      "学生：张三",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),),flex: 1),
                  ],
                ),
              ),flex: 1),
            ],
          ),flex: 2),

        ],
      ),),
  );
}

Widget clleView(int index , String content){

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(left:10,top: 10),
          child: Text(
            TitleList[index],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),),
        ),

        Padding(padding: EdgeInsets.only(left:15,top: 5,right: 10,bottom: 15),
          child: Text(
            "${content}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
            ),),
        ),
      ],
    ),
  );
}

