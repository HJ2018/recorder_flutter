import 'dart:ui' as ui show window;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teacher_recorder/Pages/Course/child/courseItem.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../Course/Model/courseModel.dart';

class coursePage extends StatefulWidget {


 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _coursePageState();
  }
}

class _coursePageState extends State<coursePage> {


  CourseModel Model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCourseData();
  }

  void getCourseData() async {

    DataUtils.courseData({},success: (data){
      Map<String, dynamic> json = Map<String, dynamic>.from(data);
      print("返回数据： ============>>>>>>    +++${json}====" );
      setState(() {
        Model = CourseModel.fromJson(json);
      });
    }, fail: (error){
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.NavMainColor,
        title: Text("课程"),
        brightness: Brightness.dark,
       //  actions: [
       //   IconButton(icon: Icon(Icons.search), onPressed:(){
       //     NavigatorUtils.pushNamed(context, "courseList");
       //   })
       // ],
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {

    if(Model==null||Model.data.length==0){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        //    alignment: Alignment.center,
        child:  Text("您还没有课程，可以尝试抢单...",textAlign: TextAlign.center,style: TextStyle(fontSize: 17.0,color: Colors.grey)),
      );

    }else{
      return ListView.builder(
          itemCount: Model==null? 0:Model.data.length,
          // itemExtent: 150.0, //强制高度为100.0
          itemBuilder: (context, index) {
            return CourseItemWidget().cell(context, Model.data[index]);
            // _cell(context, dataArr[index]);
          });
    }

  }
}

