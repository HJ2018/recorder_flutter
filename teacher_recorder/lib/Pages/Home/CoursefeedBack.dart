import 'package:flutter/material.dart';
import '../Home/child/feedBackTool.dart';
import '../Home/child/courseFeedBackItem.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:teacher_recorder/component/Tool/navigator_utils.dart';
import 'package:teacher_recorder/data/data_utils.dart';

class FeedBack extends StatefulWidget{

  final String _passValue;
  FeedBack(this._passValue);


  // FeedBack({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState


    return FeedBackStatue(_passValue);
  }

}

class FeedBackStatue extends State<FeedBack>{


  String value;
  String neirongStr;
  String zuoyeStr;
  String fankuiStr;
  FeedBackStatue(this.value);
  FocusNode blankNode = FocusNode();

  int calc_ranks(ranks) {
    double multiplier = .5;
    return (multiplier * ranks).round();
  }

  @override
  Widget build(BuildContext context) {

    print("接收传值 $value");
    double height =MediaQuery.of(context).size.height;
    // TODO: implement build
    return GestureDetector(

      behavior: HitTestBehavior.translucent,
      onTap:() {
        FocusScope.of(context).requestFocus(blankNode);
      },

      child:  Scaffold(
//          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: KColor.NavMainColor,
            title: Text("课后反馈"),
            brightness: Brightness.dark,

          ),
          body: Container(
            child: Container(
              child:Column(
                children: [
                  Expanded(
                      child: Padding(padding: EdgeInsets.only(bottom: 10),
                        child: ListView.separated(

                          itemBuilder: (BuildContext context , int index) {
                            double H;
                            if(index == 0){ H = 25;}else{ H = 150; }
                            return Container(
                              height: H,
                              child: CourseFeedBackItemWidget(
                                index
                                ,(one) {
                                  neirongStr = one;
                                }
                                ,(two) {
                                  zuoyeStr = two;}
                                ,(three) {
                                  fankuiStr = three;
                                },

                              ),
                            );
                          },
                          separatorBuilder:(BuildContext context , int index) {
                            return Container(
                              height: 0,
                            );
                          } ,
                          itemCount: 4,
                        ),
                      ),
                      flex: calc_ranks(height) - 45),


                  Padding(padding: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.height-30,
                      height: 50,
                      child: RawMaterialButton(
                        fillColor: KColor.NavMainColor,

                        child: Text("提交",style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          print("-----");
                          getData();
                        },

                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

      ),
    );
  }



  void getData() async {

    Map<String, dynamic> parameters = {
      'classRecordId': this.value,  //课堂ID
      'content': this.neirongStr,
      'task': this.zuoyeStr,
      'performance': this.fankuiStr,
    };

    DataUtils.feedbackData(parameters,success: (data){
      print("返回数据：$parameters ============>>>>>>  $data");
      if(data["code"] == 200){
        NavigatorUtils.goBackWithParams(context, data["data"]);
      }
    }, fail: (error){
    });
  }

}

