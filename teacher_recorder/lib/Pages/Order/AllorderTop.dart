import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/Order/child/auditOrderList.dart';
import 'package:teacher_recorder/Pages/Order/child/failureOrderList.dart';
import 'package:teacher_recorder/Pages/Order/child/orderList.dart';
import 'package:teacher_recorder/Pages/Order/child/succeedOrderList.dart';

import 'package:teacher_recorder/component/Tool/jh_top_tabbar.dart';


class AllorderTopPag extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllorderTopState();
  }
}

class _AllorderTopState extends State<AllorderTopPag> {



  List<JhTopTabBarModel> model = [
    JhTopTabBarModel(title: '全部', widget: orderPage()),
    JhTopTabBarModel(title: '审核', widget: auditPage()),
    JhTopTabBarModel(title: '成功', widget: SucceedPage()),
    JhTopTabBarModel(title: '失败', widget: failurePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return JhTopTabBar(
      title: '接单',
      tabModelArr: model,
      switchPageCallBack: (index){
          print('切换到第$index页');
        },
      );

  }
}



class HomeContent extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Text("data");
  }
}

