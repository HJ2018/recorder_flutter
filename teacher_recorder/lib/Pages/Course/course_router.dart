import 'package:fluro/fluro.dart';
import 'package:teacher_recorder/component/Route/router_init.dart';

import '../Course/courseList.dart';
import '../Course/courseDetatils.dart';

class courseRouter implements IRouterProvider{
  static String coursePage = 'coursePage';

  @override
  void initRouter(FluroRouter router) {
    router.define("courseList", handler: Handler(handlerFunc:(_, params) {
    print(params);
    final String passValue = params['classRoomId']?.first;
    final String studentName = params['studentName']?.first;
    final String content = params['content']?.first;
    return ListViewGroupPage(passValue,studentName,content);
    }));
        // __) => ListViewGroupPage()));
    router.define("courseDetatils", handler: Handler(handlerFunc:(_, params) {
      print(params);
      final String passValue = params['classRoomId']?.first;
      return courseDetatils(passValue);
    }));
        // (_, __) => courseDetatils()));
  }
}
