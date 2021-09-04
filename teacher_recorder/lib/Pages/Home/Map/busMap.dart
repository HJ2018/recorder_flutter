import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:teacher_recorder/component/BMTool/map_base_page_state.dart';
import 'package:teacher_recorder/component/BMTool/alert_dialog_utils.dart';
import 'package:teacher_recorder/component/BMTool/utils.dart';
import '../Map/detail/route_detail_page.dart';
import 'package:teacher_recorder/component/BMTool/route_plan_search_result_item.dart';
import 'package:teacher_recorder/component/BMTool/route_info_footer.dart';
import 'package:teacher_recorder/component/BMTool/bus_route_model.dart';

class ShowBusRouteSearchPage extends StatefulWidget {

  String StartTitle;
  String endTitle;
  ShowBusRouteSearchPage(this.StartTitle,this.endTitle);
  @override
  _ShowBusRouteSearchPageState createState() => _ShowBusRouteSearchPageState(this.StartTitle,this.endTitle);
}

class _ShowBusRouteSearchPageState
    extends BMFBaseMapState<ShowBusRouteSearchPage> {
  /// 起点
  // final _startController = TextEditingController(text: "华帝润园");

  /// 终点
  // final _endController = TextEditingController(text: "合肥火车站");

  /// 城市
  final _cityController = TextEditingController(text: "合肥市");

  String StartTitle;
  String endTitle;
  _ShowBusRouteSearchPageState(this.StartTitle,this.endTitle);

  /// 路线 polyline
  BMFPolyline _polyline;

  bool _isShowSearchResultList = false;
  bool _isShowRouteInfoFooter = false;
  BusRouteModel _routeModel;

  List<BusRouteModel> _routes = [];



  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      // backgroundColor: Color(0xFFf7f7f7),
      body: Stack(
        children: [
          generateMap(),
          _searchResultListView(),
          _routeInfoFooter(),
        ],
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _onTapSearch();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // _onTapSearch();

  }
  /// 检索
  void _onTapSearch() async {
    /// 起点
    BMFPlanNode startNode = BMFPlanNode(name: this.StartTitle);

    /// 终点
    BMFPlanNode endNode = BMFPlanNode(name: this.endTitle);

    BMFTransitRoutePlanOption option = BMFTransitRoutePlanOption(
      from: startNode,
      to: endNode,
      city: _cityController.text,
    );

    /// 检索对象
    BMFTransitRouteSearch routeSearch = BMFTransitRouteSearch();

    /// 检索结果回调
    routeSearch.onGetTransitRouteSearchResult(
        callback: _onGetTransitRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch.transitRouteSearch(option);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetTransitRouteSearchResult(
      BMFTransitRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      RshowToast(context, error);
      print(error);
      return;
    }

    print(result.toMap());

    _routes.clear();

    result.routes.forEach((element) {
      BusRouteModel model = BusRouteModel.withModel(element);
      _routes.add(model);
    });

    setState(() {
      _isShowSearchResultList = true;
      _isShowRouteInfoFooter = false;
    });
  }

  /// 路线 Polyline
  void _addRoutePolyline() {
    List<BMFMarker> markers = [];

    /// 起点marker
    BMFMarker startMarker = BMFMarker(
      position: _routeModel.startNode.location,
      title: _routeModel.startNode.title,
      icon: "images/icon_start.png",
    );
    markers.add(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker(
      position: _routeModel.endNode.location,
      title: _routeModel.endNode.title,
      icon: "images/icon_end.png",
    );
    markers.add(endMarker);

    /// 入口marker
    _routeModel.transferSteps.forEach((element) {
      BMFMarker marker = BMFMarker(
        position: element.entrace.location,
        title: element.instruction,
        icon: "images/gongjiaozhan.png",
      );
      markers.add(marker);
    });

    /// 添加marker
    myMapController?.addMarkers(markers);

    /// 添加路线polyline
    if (_polyline != null) {
      myMapController?.removeOverlay(_polyline.Id);
    }

    _polyline = BMFPolyline(
      width: 8,
      coordinates: _routeModel.routeCoordinates,
      indexs: [0],
      textures: ["images/traffic_texture_smooth.png"],
      dottedLine: false,
    );
    myMapController?.addPolyline(_polyline);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds =
    getVisibleMapRect(_polyline.coordinates);

    myMapController?.setVisibleMapRectWithPaddingHandler(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.only(top: 55.0, bottom: 70, left: 10, right: 10),
      animated: true,
    );
    myMapController.zoomOut();
  }

  /// 点击搜索结果列表item
  void _onTapRoutePlanSearchResultItem(int idx) {
    setState(() {
      _isShowSearchResultList = false;
      _isShowRouteInfoFooter = true;
      _routeModel = _routes[idx];
    });

    _addRoutePolyline();
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

  /// 搜索结果列表
  Widget _searchResultListView() {
    return Positioned(
      top: 160,
      left: 0,
      right: 0,
      bottom: 10,
      child: Visibility(
        visible: _isShowSearchResultList,
        child: Container(
          color: Color(0xFFf7f7f7),
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: _routes.length,
          ),
        ),
      ),
    );
  }

  /// 搜索结果列表item
  Widget _itemBuilder(BuildContext context, int index) {
    BusRouteModel routeModel = _routes[index];

    return Padding(padding: EdgeInsets.only(top: 8),child:  RoutePlanSearchResultItem(
      duration: routeModel.duration,
      distance: routeModel.distance,
      vehicleInfoTitles: routeModel.vehicleInfoTitles,
      passStationNum: routeModel.passStationNum,
      stationName: routeModel.stationName,
      onTap: () => _onTapRoutePlanSearchResultItem(index),
    ),);

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


























// import 'package:flutter/material.dart';
//
//
// class _myapp extends StatefulWidget {
//   @override
//   _myappState createState() => _myappState();
// }
//
// class _myappState extends State<_myapp> {
//   List sampleData = new List();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     sampleData.add(new RadioModel(false, 'A', ));
//     sampleData.add(new RadioModel(false, 'B', ));
//     sampleData.add(new RadioModel(false, 'C', ));
//     sampleData.add(new RadioModel(false, 'D', ));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Row(
//       children:List<Widget>.generate(sampleData.length, (index){
//         return InkWell(
//           child: _buttonstyle(sampleData[index]),
//           onTap: (){
//             setState(() {
//               sampleData.forEach((element) => element.isSelected = false);
//               print(sampleData[index].buttonText);
//               sampleData[index].isSelected = true;
//             });
//           },
//         );
//       }
//       ),
//     );
//   }
//   Widget _buttonstyle(sampleData) {
//     return Container(
//       padding: EdgeInsets.only(right: 20),
//       child: Stack(
//         children: [
//           Container(
//             height: 20,
//             width: 30,
//             padding: EdgeInsets.symmetric(vertical: 10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(4)),
//               border: Border.all(width: 1,color: sampleData.isSelected? Colors.blue:Colors.grey),
//             ),
//           ),
//           Container(
//             height: 20,
//             width: 30,
//             child: Center(child: Text("${sampleData.buttonText}")),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 按钮样式
//
//
// class RadioModel {
//   bool isSelected;
//   final String buttonText;
//
//   RadioModel(this.isSelected, this.buttonText,);
// }