import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import '../Home/child/clockChild.dart';


class clockPage extends StatefulWidget{


  clockPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return clockPageState();
  }

}

class clockPageState extends State<clockPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.NavMainColor,
        title: Text("上课打卡"),
        brightness: Brightness.dark,
        actions: [
          TextButton(child:  Image.asset("images/buqia.png",
            width: 25, height: 25,),onPressed:(){
            NavigatorUtils.pushNamed(context, "cardlist");
          })
        ],
      ),
      body: Center(
          child: TapBoxA(),
      ),
    );
  }
}





