import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/Home/child/feedBackTool.dart';

typedef neirongStr = void Function(String one);
typedef zuoyeStr = void Function(String two);
typedef fankuiStr = void Function(String three);

class CourseFeedBackItemWidget extends StatelessWidget{

  int rowindex;
  neirongStr oneBack;
  zuoyeStr twoBack;
  fankuiStr threeBack;
  CourseFeedBackItemWidget(this.rowindex,this.oneBack,this.twoBack,this.threeBack);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(rowindex == 0){
      return Container(

        child:Text("")
        // Padding(padding: EdgeInsets.only(left: 15 , top: 25),
        //   child: Text("课后反馈" , style: TextStyle(
        //     fontSize: 24,
        //     fontWeight:FontWeight.bold,
        //   ),),
        // ),
      );

    }if(rowindex == 1){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:commonTitle("上课内容","images/neirong.png"),
              flex: 1,
            ),

            Expanded(
                child:
                TextInput(
                    hint: "请输入你的上课内容",
                    height: 300,
                    onChanged: (str) {
                      // print("$str");
                      oneBack(str);
                    }),
              flex: 3,
            ),
          ],
        )



      );
    }if(rowindex == 2){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:commonTitle("课后作业","images/zuoye.png"),
              flex: 1,
            ),

            Expanded(
              child:TextInput(
                  hint: "请输入你的课后作业",
                  onChanged: (str) {
                    // print("$str");
                    twoBack(str);
                  }),
              flex: 4,
            ),
          ],
        )
      );
    }if(rowindex == 3){
      return Container(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:commonTitle("课后反馈","images/fankui.png"),
              flex: 1,
            ),

            Expanded(
              child:TextInput(
                  hint: "请输入你的课后反馈",
                  onChanged: (str) {
                    // print("$str");
                    threeBack(str);
                  }),
              flex: 4,
            ),
          ],
        )
      );
    }
  }
}

class commonTitle extends StatelessWidget{
  String title;
  String img;

  commonTitle(this.title, this.img);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:Padding(padding: EdgeInsets.only(left: 15),
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 18,
              // color: Colors.grey.shade700,
              fontWeight:FontWeight.bold,
            ),
            children: [
              WidgetSpan(
                child: Image.asset(
                  this.img,
                  width: 24,
                  height: 24,
                ),
              ),
              TextSpan(
                text: "  ${this.title}",
              )
            ],
          ),
        ),
      ),
    );
  }

}

class OntWidet extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
        child:Container(
          color: Color.fromARGB(150, 192, 192, 192),
//            width: 1000,
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
              ),flex: 3),

              // Padding(padding: EdgeInsets.only(top: 5)),
//                        margin
              Expanded(child: Padding(padding: EdgeInsets.only(left: 10),
                child: Text(
                  "上课时间：2021-04-21 / 12:00 - 14:50",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  ),),
              ),flex: 2),


              Expanded(child:Padding(padding: EdgeInsets.only(top: 0,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                 Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      "上课时长：2h",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                    Padding(padding: EdgeInsets.only(left: 25)),
                    Text(
                      "学生：张三",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                  ],
                ),
              ),flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

