import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/Order/AllorderTop.dart';
import '../Course/course.dart';
import '../My/my.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:teacher_recorder/Pages/Order/AllorderTop.dart';
import '../Home/NewHome.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int taBarIdx = 0;
  List<Widget> listController = [NewHomePage(),coursePage(),AllorderTopPag(),MyPage()];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      // 设置EasyRefresh的默认样式
      EasyRefresh.defaultHeader = ClassicalHeader(
        enableInfiniteRefresh: false,
        refreshText: '下拉刷新',
        refreshReadyText: '释放刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
        noMoreText: '没有更多',
        showInfo: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(

      body:IndexedStack(
        index: taBarIdx,
        children: listController,
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (int index){
          setState(() {
            taBarIdx = index;
          });
        },
        currentIndex: taBarIdx,
        selectedItemColor: KColor.NavMainColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("上课"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            title: Text("课程"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.reorder_rounded),
            title: Text("接单"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("我的"),
          ),

        ],),
    );
  }
}