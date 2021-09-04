
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:flutter/services.dart';
import 'package:teacher_recorder/component/Tool/jh_dialog.dart';
import 'package:teacher_recorder/component/Tool/jh_progress_hud.dart';
import 'package:teacher_recorder/data/data_utils.dart';


TextEditingController _textController = TextEditingController();

class PayWithdraw extends StatefulWidget{

  final String amount;

  const PayWithdraw({Key key, this.amount}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return PayWithdrawState(this.amount);
  }

}

class PayWithdrawState extends State<PayWithdraw>{

  String allPaytitle;
  final String amount;

  FocusNode blankNode = FocusNode();

  PayWithdrawState(this.amount);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _textController.text = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.text = "";
  }


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
          title: Text("薪资提现"),
          brightness: Brightness.dark,
        ),
        body: _CellItem(),
      ),
    );
  }

  // content
  Widget _CellItem() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _cellContent(index);
          // return
        });
  }

  Widget _cellContent(int index){

    if (index == 0){
      return Container(
        height: MediaQuery.of(context).size.height*0.23,
        color: Color.fromARGB(40, 190, 190, 190),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "提现账号  ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text: "18256586683",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ]
            )),
            SizedBox(height: 10),

            Padding(padding: EdgeInsets.only(left: getTextSize("提现账号", TextStyle(fontSize: 16))-15),
              child:Text("24小时内到账",style: TextStyle(color: Colors.grey),),
            ),
          ],
        )
      );
    } else if(index == 1){
      return Padding(padding: EdgeInsets.only(left: 15,top: 10),
        child: Text("提现金额",style: TextStyle(fontSize: 16,color: Colors.black),),
      );
    } else if(index == 2){
      return Container(
        // height: MediaQuery.of(context).size.height*0.2,
        child: Column(
          children: [
            SizedBox(height: 20,),


        TextField(
          keyboardType: TextInputType.datetime,
          style: TextStyle(fontSize: 28.0,color: Colors.black,fontWeight: FontWeight.bold),
          controller: _textController,

          decoration: InputDecoration(
            hintText:  "请输入金额",
            hintStyle: TextStyle(fontSize: 28,color: Colors.grey),
            prefixIcon: Container(child:Padding(padding: EdgeInsets.only(left: 15,top: 7),
              child:Text("¥",style:TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),),),
            isDense: true,
          ),
        )
          ],
        ),
      );
    }else if(index == 3){
      return Padding(padding: EdgeInsets.only(left: 15,top: 10),

        child: RichText(text: TextSpan(
            children: [
              TextSpan(
                text: "当前可提现薪资${this.amount}元 ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14),
              ),
              TextSpan(
                text: "全部提现",
                style: TextStyle(
                    color: KColor.NavMainColor,
                    fontSize: 14),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('点击了服务条款');
                    setState(() {
                      _textController.text = this.amount;
                    });

                  },
              )
            ]
        )),
      );
    } else{
      return Padding(padding: EdgeInsets.only(left: 30,top: 60,right: 30),
      child: FlatButton(
        color: KColor.NavMainColor,
        textColor: Colors.white,
        minWidth: MediaQuery.of(context).size.width-80,
        height: 50,
        child: new Text('提现'),
        onPressed: () {
          String text = _textController.text;
          print("===${text}");
          PayWithdrawData();
        },
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
      ),
      );
    }

  }

  static double getTextSize(String text, TextStyle style) {
    TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
    );
    painter.layout();
    return painter.size.width;
  }

  void PayWithdrawData() async{

    DataUtils.ApplywithdrawaData({"money":_textController.text},success: (data){

      print("返回数据：${_textController.text} ============>>>>>>  $data");

      if(data["code"] == 200){
        JhDialog.show(context, title: "提示", content:"提现成功，金额:${_textController.text},24小时内到账" ,  onConfirm: () {
          Navigator.pop(context);
        });

      }
    },fail: (code){
    });

  }

}