import 'package:fluro/fluro.dart';
import 'package:teacher_recorder/component/Route/router_init.dart';
import '../login/pages/code_login_page.dart';


class LoginRouter implements IRouterProvider{
  static String loginPage = 'LoginPage';

  @override
  void initRouter(FluroRouter router) {
    router.define("CodeLoginPage", handler: Handler(handlerFunc: (_, __) => CodeLoginPage()));
  }
}

