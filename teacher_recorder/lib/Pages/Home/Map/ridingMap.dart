import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:teacher_recorder/component/BMTool/map_base_page_state.dart';
import 'package:teacher_recorder/component/BMTool/riding_route_model.dart';
import 'package:teacher_recorder/component/BMTool/alert_dialog_utils.dart';
import 'package:teacher_recorder/component/BMTool/route_info_footer.dart';
import 'package:teacher_recorder/component/BMTool/utils.dart';
import '../Map/detail/route_detail_page.dart';

class ShowRidingRouteSearchPage extends StatefulWidget {

  String StartTitle;
  String endTitle;
  ShowRidingRouteSearchPage(this.StartTitle,this.endTitle);
  @override
  _ShowRidingRouteSearchPageState createState() =>
      _ShowRidingRouteSearchPageState(this.StartTitle,this.endTitle);
}

class _ShowRidingRouteSearchPageState
    extends BMFBaseMapState<ShowRidingRouteSearchPage> {
  // final _startController = TextEditingController(text: "华地润园");
  // final _endController = TextEditingController(text: "尚泽大都会");

  final CityTitle = "合肥市";

   String StartTitle;
   String endTitle;

  _ShowRidingRouteSearchPageState(this.StartTitle,this.endTitle);
  BMFPolyline _polyline;

  bool _isShowRouteInfoFooter = false;
  bool _isRideTypeSelected = false;
  RidingRouteModel _routeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _onTapSearch();
    // _onTapSearch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
          generateMap(),
        _routeInfoFooter(),
          ],
      ),
    );
  }


  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //
  //
  // }
  /// 检索
  void _onTapSearch() async {
    /// 起点
    BMFPlanNode startNode = BMFPlanNode(
      name: this.StartTitle,
      cityName: CityTitle,
    );

    /// 终点
    BMFPlanNode endNode = BMFPlanNode(
      name: this.endTitle,
      cityName: CityTitle,
    );

    BMFRidingRoutePlanOption option =
    BMFRidingRoutePlanOption(from: startNode, to: endNode, ridingType: _isRideTypeSelected ? 0 : 1);

    /// 检索对象
    BMFRidingRouteSearch routeSearch = BMFRidingRouteSearch();

    /// 检索结果回调
    routeSearch.onGetRidingRouteSearchResult(
        callback: _onGetRidingRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch.ridingRouteSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetRidingRouteSearchResult(
      BMFRidingRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      RshowToast(context, error);
      print(error);
      return;
    }

    print(result.toMap());

    /// 所有骑行路线中第一条路线
    BMFRidingRouteLine firstLine = result.routes[0];
    _routeModel = RidingRouteModel.withModel(firstLine);

    _isShowRouteInfoFooter = true;
    setState(() {});

    /// 移除marker
    myMapController?.cleanAllMarkers();

    /// 起点marker
    BMFMarker startMarker = BMFMarker(
      position: _routeModel.startNode.location,
      title: _routeModel.startNode.title,
      icon: "images/icon_start.png",
    );

    myMapController?.addMarker(startMarker);
    /// 终点marker
    BMFMarker endMarker = BMFMarker(
      position: _routeModel.endNode.location,
      title: _routeModel.endNode.title,
      icon: "images/icon_end.png",
    );
    myMapController?.addMarker(endMarker);

    List<BMFCoordinate> coordinates = [];
    for (BMFRidingStep step in firstLine.steps) {
      if (null == step) {
        continue;
      }

      /// 路线经过的路段坐标点
      if (null != step.points) {
        coordinates.addAll(step.points);
      }
    }

    if (_polyline != null) {
      myMapController?.removeOverlay(_polyline.Id);
    }

    /// 添加路线polyline
    _polyline = BMFPolyline(
      coordinates: coordinates,
      width: 8,
      indexs: [0],
      textures: ["images/traffic_texture_smooth.png"],
      dottedLine: false,
    );
    myMapController?.addPolyline(_polyline);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds = getVisibleMapRect(coordinates);
    myMapController?.setVisibleMapRectWithPaddingHandler(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.only(top: 65.0, bottom: 70, left: 10, right: 10),
      animated: true,
    );
    myMapController.zoomOut();
  }

  /// 点击详情
  void _onTapDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouteDetailPage(
          routeModel: _routeModel,
        ),
      ),
    );
  }

  /// 路线信息
  Widget _routeInfoFooter() {
    return Positioned(
      left: 15,
      right: 15,
      bottom: 15,
      child: Visibility(
        visible: _isShowRouteInfoFooter,
        child: RouteInfoFooter(
          duration: _routeModel?.duration,
          distance: _routeModel?.distance,
          onTapDetailBtn: _onTapDetail,
        ),
      ),
    );
  }
}
