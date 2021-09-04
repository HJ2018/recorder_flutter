
import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/My/child/MyFeedbackchiild.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';

class Myfeedback extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return MyfeedbackState();
  }

}

class MyfeedbackState extends State<Myfeedback>{

  var account ='';
  FocusNode blankNode = FocusNode();

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
          title: Text("意见反馈"),
          brightness: Brightness.dark,
        ),
        body: _CellItem(),
      ),
    );
  }

  Widget _CellItem() {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return _cellContent(index);
          // return
        });
  }

  Widget _cellContent(int index){


    if(index == 0){
      return Padding(padding: EdgeInsets.only(left: 10,top: 25,right: 10,bottom: 10),
        child: MyTextInput(
            hint: "请输入你的意见。。",
            height: 200,
            onChanged: (str) {
              print("$str");
            }),
        );

    } else if(index == 1){

      return Padding(padding: EdgeInsets.only(left: 30,top: 60,right: 30),
        child: FlatButton(
          color: KColor.NavMainColor,
          textColor: Colors.white,
          minWidth: MediaQuery.of(context).size.width-80,
          height: 50,
          child: new Text('提交'),
          onPressed: () {

          },
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
      );

    }
  }
}