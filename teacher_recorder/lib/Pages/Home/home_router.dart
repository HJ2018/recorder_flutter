import 'package:fluro/fluro.dart';
import 'package:teacher_recorder/Pages/Home/cardList.dart';
import 'package:teacher_recorder/Pages/Home/orderRoute.dart';
import 'package:teacher_recorder/component/Route/router_init.dart';
import '../Home/clockController.dart';
import '../Home/mapController.dart';
import '../Home/CoursefeedBack.dart';
import 'cardDetails.dart';



class HomeRouter implements IRouterProvider{
  static String homePage = 'homePage';

  @override
  void initRouter(FluroRouter router) {

    router.define("mapPage", handler: Handler(handlerFunc: (_, __) => mapPage()));
    router.define("clock", handler: Handler(handlerFunc: (_, __) => clockPage()));
    router.define("orderRouteMap", handler:Handler(handlerFunc: (_, params) {
      print(params);
      final String start = params['start']?.first;
      final String end = params['end']?.first;
      return orderRouteMap(start,end);
    }));
    router.define("FeedBack", handler: Handler(handlerFunc: (_, params) {
      print(params);
      final String passValue = params['classRecordId']?.first;
      return FeedBack(passValue);
    }));
    router.define("cardlist", handler: Handler(handlerFunc: (_, __) => CardList()));

    router.define("cardDetails", handler: Handler(handlerFunc: (_, params) {
      print(params);
      final String classRoomId = params['classRoomId']?.first;
      final String classCourseId = params['classCourseId']?.first;
      final String studentName = params['studentName']?.first;
      final String content = params['content']?.first;
      return CardDetails(
        classCourseId: classCourseId,
        classRoomId: classRoomId,
        studentName: studentName,
        content: content,
      );
    }));

  }
}
