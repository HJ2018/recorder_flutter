import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;
import 'package:teacher_recorder/component/Route/routes_old.dart' as luyou;
import 'package:teacher_recorder/component/Route/application.dart';
import 'package:teacher_recorder/Pages/login/pages/code_login_page.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:teacher_recorder/component/Route/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flustars/flustars.dart';
import 'package:teacher_recorder/component/Tool/jh_storage_utils.dart';
import 'package:teacher_recorder/Pages/index/index.dart';
import 'package:teacher_recorder/data/apis.dart';
import 'package:teacher_recorder/component/Tool/colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

//main()=> runApp(MyApp());

//屏幕宽度高度：MediaQuery.of(context).size.width
//屏幕宽度高度：MediaQuery.of(context).size.height
//屏幕状态栏高度：MediaQueryData.fromWindow(WidgetBinding.instance.window).padding.top。


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil.getInstance();
  APIs.UDID();

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        'pG0QFKQ9S7bpz5MoHqunY7rFuN45yAhP', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    // Android 目前不支持接口设置Apikey,
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }

  runApp(new MyApp());

}
/*
* 无状态的 StatelessWidget
* 有状态的 StatefulWidget
* */

class MyApp extends StatefulWidget {

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final FluroRouter router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, //只能纵向
      DeviceOrientation.portraitDown,//只能纵向
    ]);
    return OKToast(
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           accentColor: KColor.NavMainColor,
         ),
         navigatorKey: NavRouter.navigatorKey, //设置在这里
         routes: {
           '/CodeLoginPage': (ctx) => CodeLoginPage(),
         },
         home: SwitchRootWidget(),
         onGenerateRoute: Application.router.generator,
         onUnknownRoute: (RouteSettings settings) =>
             MaterialPageRoute(builder: (context) => luyou.UnknownPage()),

         localizationsDelegates: [
           GlobalMaterialLocalizations.delegate,
           GlobalWidgetsLocalizations.delegate,
           GlobalMaterialLocalizations.delegate,
           GlobalWidgetsLocalizations.delegate,
           GlobalCupertinoLocalizations.delegate,
           const FallbackCupertinoLocalisationsDelegate()
         ],
         // supportedLocales: [ Locale('zh', 'CN')],
         supportedLocales: [
           const Locale('zh', 'CN'),
           const Locale('en', 'US'),
         ],


       ),

    );

  }


  Widget SwitchRootWidget() {
    var token = AppSettingUtils.getStringWithKey(KEY.TOKEN_KEY);
    if( token == null || token == ''){
      return CodeLoginPage();
    }else{
      return IndexPage();
    }
  }
}

