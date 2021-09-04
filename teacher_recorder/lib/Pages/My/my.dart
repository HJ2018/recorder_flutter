import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/My/Model/UserDataModel.dart';
import 'package:teacher_recorder/data/data_utils.dart';
import '../My/child/myItem.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';

class MyPage extends StatefulWidget{


  MyPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPageState();
  }

}

class MyPageState extends State<MyPage>{


  UserDataModel Model;

  Future<void> _refresh() async{

    return  getHomeData();

  }


  void getHomeData() async {

    DataUtils.getByUserData({},success: (data){
      print("返回数据： ============>>>>>>  $data");
      Map<String, dynamic> json = Map<String, dynamic>.from(data);

      setState(() {
        Model = UserDataModel.fromJson(json);
      });

    }, fail: (error){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: KColor.NavMainColor,
            title: Text("我的"),
            brightness: Brightness.dark,
          ),
          body: _MyItemtab(Model),
        ),
        onRefresh: _refresh
    );

  }

  Widget _MyItemtab(UserDataModel model){

   return ListView.separated(
      itemBuilder: (BuildContext context , int index) {

//          double itemH;
//          if (index == 0){ itemH = 200; }else itemH = 48;
        if (index == 0){
          return Container(
            height: 200,
            child: myItemWidget(itemIdx:index,model: model),
            // color: Colors.blue,
          );
        }else{
          return Container(
            height: 135,
            child: myItemWidget(itemIdx:index,model: model,),
//            color: Color.fromARGB(20, 192, 192, 192),
          );
        }

      },
      separatorBuilder:(BuildContext context , int index) {

        double h;
        if (index == 0){ h = 15; }else h = 1;
        return Container(
          height: 0,
          color: Color.fromARGB(100, 192, 192, 192),
        );
      } ,
      itemCount: 3,
    );
  }
}
