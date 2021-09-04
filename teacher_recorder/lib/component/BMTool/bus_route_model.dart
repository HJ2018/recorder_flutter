import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'base_route_model.dart';
import 'route_step_model.dart';

class BusRouteModel extends BaseRouteModel {
  String passStationNum;
  String stationName;
  List<String> vehicleInfoTitles = [];
  List<BMFTransitStep> transferSteps = [];
  List<RouteStepModel> steps = [];

  BusRouteModel.withModel(routeLine) : super.withModel(routeLine) {

    int stop = 0;

    routeLine.steps.forEach((element) {
      if (element.stepType != BMFTransitStepType.WAKLING) {
        stop += element.vehicleInfo?.passStationNum;
        vehicleInfoTitles.add(element.vehicleInfo?.title);
        routeCoordinates.addAll(element.points);
        transferSteps.add(element);
      }

      RouteStepModel stepModel = RouteStepModel(image: _stepImages[element.stepType.index], instruction: element.instruction);
      steps.add(stepModel);
    });
    passStationNum = "$stop站";
    if (routeLine.starting.title != null) {
      stationName = "${routeLine.starting.title}上车";
    }

    RouteStepModel startStepModel = RouteStepModel(image: "images/animation_green.png", instruction: "起点（我的位置）");
    RouteStepModel endStepModel = RouteStepModel(image: "images/animation_red.png", instruction: "终点（${endNode.title}）");
    steps.insert(0, startStepModel);
    steps.add(endStepModel);
  }
}

final _stepImages = [
  "images/bus.png",
  "images/subway.png",
  "images/walk.png",
];
