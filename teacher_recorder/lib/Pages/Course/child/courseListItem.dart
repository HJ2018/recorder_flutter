import 'package:flutter/material.dart';


class CourseListItemWidget extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Row(
          children: [
            Expanded(child:
            Padding(
        padding:
        EdgeInsets.only(
            top: 8,
            left: 20,
            right: 10
        ),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4月21  数学", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text("打卡时间：下午16:21"),

                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text("上课时长：2小时")
                  ],
                )
            ),
                flex: 5),




            Expanded(child:
                Column(
                  children: [
                    Expanded(child: Icon(Icons.arrow_forward_ios),flex: 1,)
                  ],
                )
              ,flex: 1)
          ],
        )
    );
  }
}