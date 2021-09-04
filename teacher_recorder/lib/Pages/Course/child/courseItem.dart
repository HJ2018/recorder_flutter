import 'package:flutter/material.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import '../Model/courseModel.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CourseItemWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Text("");
  }


  //cell
  Widget cell(context, Datum item) {
    return
      Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 15)),
        InkWell(
          onTap: () => _jumpTop(context, item),
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
                                        child:Text(item == null? "--":item.studentName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 10),
                                        child:Text("${item == null? "--":item.studentName} ｜ ${item == null? "--":item.gradeName}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 10),
                                        child: weizhiTitle(item == null? "--":item.address, "images/weizhi.png",),
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
                                  item == null? "--":item.subjectName,
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
                                  percent: double.parse(item.consumeHours.toString()) / double.parse(item.totalHours.toString()),
                                  backgroundColor: Color(0xFFDCDCE6),
                                  progressColor: KColor.NavMainColor,
                                ),
                                SizedBox(width: 8),
                                Text('${item.consumeHours}/${item.totalHours}', style: TextStyle(color: Colors.grey)),
                              ],
                            ),flex: 1,)
                          ],
                        ),
                        )


                    ),
                    Container(
                      color: Color(0xFFE6E6E6),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child:
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "images/icon.png",
                            width: 40,
                          ),
                        ),
                        title: Text(
                          "下次课2021年8月5日",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Colors.black26),
                      ),
                    ),
                  ],
                ),
          )
        )
      ],
    );
  }

  _jumpTop(context, item) {
    String studentName = Uri.encodeComponent("${item.studentName}");
    String content = Uri.encodeComponent("${item.gradeName} | ${item.subjectName}");
    NavigatorUtils.pushNamed(context, "${"courseList"}?classRoomId=${item.classRoomId}&studentName=${studentName}&content=${content}");
  }


}