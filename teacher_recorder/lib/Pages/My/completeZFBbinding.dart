import 'package:flutter/material.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/jh_dialog.dart';


class completeBingDing extends StatefulWidget{
  
  final String accont;

  const completeBingDing({Key key, this.accont}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return completeBingDingState(this.accont);
  }

}

class completeBingDingState extends State<completeBingDing>{
  
  FocusNode blankNode = FocusNode();

  final String accont;

  completeBingDingState(this.accont);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(

      behavior: HitTestBehavior.translucent,
      onTap:() {
        FocusScope.of(context).requestFocus(blankNode);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColor.NavMainColor,
          title: Text("绑定支付宝"),
          brightness: Brightness.dark,
        ),
        body: _CellItem(),
      ),
    );

  }

  Widget _CellItem() {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return _cellContent(index);
          // return
        });
  }

  Widget _cellContent(int index){


    if(index == 0){
      return Padding(padding: EdgeInsets.only(left: 15,top: 40),
        child: Text("当前绑定账号",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
      );
    } else if(index == 1){

      return Padding(padding: EdgeInsets.only(top: 25,left: 15),
        child: Container(
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  "images/zhifubao.png",
                  width: 25,
                  height: 25,
                ),
                Expanded(
                  child: Text(
                    "  $accont",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Divider(height: 1.0,indent: 0.0,color: Colors.grey,),
          ],
        )
    ),);

    }else if(index == 2){
      return Padding(padding: EdgeInsets.only(left: 15,top: 25,right: 10),

        child: RichText(text: TextSpan(
            children: [
              TextSpan(
                text: "* ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14),
              ),
              TextSpan(
                text: "该账号已绑定支付宝，如需更换请联系我们工作人员",
                style: TextStyle(
                    color: KColor.NavMainColor,
                    fontSize: 12),
              )
            ]
        )),
      );
    }else if(index == 3){
      return Padding(padding: EdgeInsets.only(left: 30,top: 60,right: 30),
        child: FlatButton(
          color: KColor.NavMainColor,
          textColor: Colors.white,
          minWidth: MediaQuery.of(context).size.width-80,
          height: 50,
          child: new Text('更换'),
          onPressed: () {
            JhDialog.show(context,title: "提示",content: "请联系我们工作人员。。",hiddenCancel: true);
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
