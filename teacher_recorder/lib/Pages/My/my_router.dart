
import 'package:fluro/fluro.dart';
import 'package:teacher_recorder/Pages/My/MyFeedback.dart';
import 'package:teacher_recorder/Pages/My/Paywithdraw.dart';
import 'package:teacher_recorder/Pages/My/bindingZFB.dart';
import 'package:teacher_recorder/Pages/My/completeZFBbinding.dart';
import 'package:teacher_recorder/Pages/My/historyPay.dart';
import 'package:teacher_recorder/component/Route/router_init.dart';

class MyRouter implements IRouterProvider{

  @override
  void initRouter(FluroRouter router) {
    //Myfeedback
    router.define("binding", handler: Handler(handlerFunc: (_, __) => BingDingZFB()));
    router.define("HistaryPay", handler: Handler(handlerFunc: (_, __) => HistoryPay()));
    router.define("PayTixian", handler:Handler(handlerFunc: (_, params) {
      final String amount = params['amount']?.first;
      return PayWithdraw(amount: amount,);
    }));
        // handler: Handler(handlerFunc: (_, __) => PayWithdraw()));

    router.define("Myfeedback", handler: Handler(handlerFunc: (_, __) => Myfeedback()));
    router.define("completeBingDing", handler:Handler(handlerFunc: (_, params) {
      final String accont = params['accont']?.first;
      return completeBingDing(accont: accont,);
    }));
  }
}

