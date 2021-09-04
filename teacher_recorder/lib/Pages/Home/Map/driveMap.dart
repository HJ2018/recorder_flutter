import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:teacher_recorder/component/BMTool/map_base_page_state.dart';
import 'package:teacher_recorder/component/BMTool/alert_dialog_utils.dart';
import 'package:teacher_recorder/component/BMTool/utils.dart';
import '../Map/detail/route_detail_page.dart';
import 'package:teacher_recorder/component/BMTool/route_info_footer.dart';
import 'package:teacher_recorder/component/BMTool/drive_route_model.dart';

class ShowDrivingRouteSearchPage extends StatefulWidget {

  String StartTitle;
  String endTitle;
  ShowDrivingRouteSearchPage(this.StartTitle,this.endTitle);
  @override
  _ShowDrivingRouteSearchPageState createState() =>
      _ShowDrivingRouteSearchPageState(this.StartTitle,this.endTitle);
}

class _ShowDrivingRouteSearchPageState
    extends BMFBaseMapState<ShowDrivingRouteSearchPage> {
  final _startCityName = TextEditingController(text: "合肥市");
  // final _startPlanNodeName = TextEditingController(text: "华帝润园");
  final _endCityName = TextEditingController(text: "合肥市");
  // final _endPlanNodeName = TextEditingController(text: "合肥火车站"); // 地铁西二旗站


  String StartTitle;
  String endTitle;
  _ShowDrivingRouteSearchPageState(this.StartTitle,this.endTitle);

  BMFPolyline _polyline;
  bool _isShowSearchResultList = false;
  bool _isShowRouteInfoFooter = false;
  bool _isShowTrafficType = true;
  String _drivingPolicyTextValue = "最短时间";
  int _drivingPolicyIndex = 1;

  /// 驾车路线
  List<DriveRouteModel> _driveRoutes = [];
  DriveRouteModel _selectedDriveRouteModel;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // _onTapSearchDrivingRoute();
    // _otherSearchParamBar();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onTapSearchDrivingRoute();
    _otherSearchParamBar();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          generateMap(),
          _searchResultListView(),
          _routeInfoFooter(),
        ],
      ),
    );
  }

  /// 检索
  void _onTapSearchDrivingRoute() async {
    // 地名规划路线
    BMFPlanNode from = BMFPlanNode(
      cityName: _startCityName.text,
      name: this.StartTitle,
      // pt: BMFCoordinate(40.049879, 116.279853), // name 经纬度 二选一， 同时指定，经纬度优先
    );
    BMFPlanNode to = BMFPlanNode(
      cityName: _endCityName.text,
      name: this.endTitle,
      // pt: BMFCoordinate(39.989956, 116.323066), // name 经纬度 二选一， 同时指定，经纬度优先
    );

    /// 驾车检索参数设置
    BMFDrivingRoutePlanOption drivingRoutePlanOption =
    BMFDrivingRoutePlanOption(from: from, to: to);
    drivingRoutePlanOption.drivingRequestTrafficType = _isShowTrafficType
        ? BMFDrivingRequestTrafficType.PATH_AND_TRAFFICE
        : BMFDrivingRequestTrafficType.NONE;
    drivingRoutePlanOption.drivingPolicy =
    BMFDrivingPolicy.values[_drivingPolicyIndex];

    BMFDrivingRouteSearch drivingRouteSearch = BMFDrivingRouteSearch();

    /// 检索回调
    drivingRouteSearch.onGetDrivingRouteSearchResult(
        callback: _onGetBMFDrivingRouteResult);

    bool result =
    await drivingRouteSearch.dringRouteSearch(drivingRoutePlanOption);

    if (result) {
      print("发起检索成功");
    } else {
      print("发起检索失败");
    }
  }

  /// 检索结果回调
  void _onGetBMFDrivingRouteResult(
      BMFDrivingRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      RshowToast(context, error);
      print(error);
      return;
    }

    print(result.toMap());

    /// 驾车结果路线
    _driveRoutes.clear();
    result.routes.forEach((element) {
      DriveRouteModel model = DriveRouteModel.withModel(element);
      _driveRoutes.add(model);
    });

    setState(() {
      _isShowRouteInfoFooter = false;
      _isShowSearchResultList = true;
    });
  }

  /// 选择路线
  void _onTapRouteItem(int idx) {
    setState(() {
      _isShowSearchResultList = false;
      _isShowRouteInfoFooter = true;
      _selectedDriveRouteModel = _driveRoutes[idx];
    });

    _addRoutePolyline();
  }

  /// 点击详情
  void _onTapDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouteDetailPage(
          routeModel: _selectedDriveRouteModel,
        ),
      ),
    );
  }

  /// 路线 Polyline
  void _addRoutePolyline() {
    List<BMFMarker> markers = [];

    /// 起点marker
    BMFMarker startMarker = BMFMarker(
      position: _selectedDriveRouteModel.startNode.location,
      title: _selectedDriveRouteModel.startNode.title,
      icon: "images/icon_start.png",
    );
    markers.add(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker(
      position: _selectedDriveRouteModel.endNode.location,
      title: _selectedDriveRouteModel.endNode.title,
      icon: "images/icon_end.png",
    );
    markers.add(endMarker);

    /// 驾车途径点marker
    _selectedDriveRouteModel.wayPoints?.forEach((element) {
      BMFMarker marker = BMFMarker(
        position: element.pt,
        title: element.name,
        icon: "images/pin_red.png",
      );
      markers.add(marker);
    });

    /// 添加marker
    myMapController?.cleanAllMarkers();
    myMapController?.addMarkers(markers);

    /// 添加路线polyline
    if (_polyline != null) {
      myMapController?.removeOverlay(_polyline.Id);
    }

    _polyline = BMFPolyline(
      width: 8,
      coordinates: _selectedDriveRouteModel.routeCoordinates,
      indexs: _selectedDriveRouteModel.trafficIndexList,
      textures: _trafficTextures,
      dottedLine: false,
    );
    myMapController?.addPolyline(_polyline);

    /// 根据polyline设置地图显示范围
    BMFCoordinateBounds coordinateBounds =
    getVisibleMapRect(_polyline.coordinates);

    myMapController?.setVisibleMapRectWithPaddingHandler(
      visibleMapBounds: coordinateBounds,
      insets: EdgeInsets.only(top: 65.0, bottom: 70.0, left: 10, right: 10),
      animated: true,
    );
    myMapController.zoomOut();
  }
  /// 驾车策略
  Widget _otherSearchParamBar() {
    return Container(
      color: Color(0xFF22253D),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 30,
              child: Row(
                children: [
                  Text(
                    "驾车策略：",
                    style: _searchBarTextStyle,
                  ),
                  DropdownButton(
                    value: _drivingPolicyTextValue,
                    style: _searchBarTextStyle,
                    dropdownColor: Color(0xFF22253D),
                    iconEnabledColor: Colors.white,
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "躲避拥堵",
                          style: _searchBarTextStyle,
                        ),
                        value: "躲避拥堵",
                        onTap: () => _drivingPolicyIndex = 0,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "最短时间",
                          style: _searchBarTextStyle,
                        ),
                        value: "最短时间",
                        onTap: () => _drivingPolicyIndex = 1,
                      ),
                      DropdownMenuItem(
                        child: Text("最短路程"),
                        value: "最短路程",
                        onTap: () => _drivingPolicyIndex = 2,
                      ),
                      DropdownMenuItem(
                        child: Text("少走高速"),
                        value: "少走高速",
                        onTap: () => _drivingPolicyIndex = 3,
                      ),
                    ],
                    onChanged: _dropdownButtonOnChange,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Image.asset(
                      _isShowTrafficType
                          ? "resoures/selected_box.png"
                          : "resoures/unselected_box.png",
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "是否展示路况",
                      style: _searchBarTextStyle,
                    ),
                  ],
                ),
              ),
              onTap: () {
                _isShowTrafficType = !_isShowTrafficType;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 驾车策略下拉菜单
  void _dropdownButtonOnChange(value) {
    setState(() {
      _drivingPolicyTextValue = value;
    });
  }

  /// 搜索结果列表
  Widget _searchResultListView() {
    return Positioned(
      top: 160,
      left: 0,
      right: 0,
      bottom: 0,
      child: Visibility(
        visible: _isShowSearchResultList,
        child: Container(
          color: Color(0xFFf7f7f7),
          child: ListView.builder(
            itemBuilder: _itemBuilder,
            itemCount: _driveRoutes.length,
          ),
        ),
      ),
    );
  }

  /// 搜索结果列表item
  Widget _itemBuilder(BuildContext context, int index) {
    DriveRouteModel model = _driveRoutes[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "路线${index + 1}：",
                style: _itemTitleStyle,
              ),
              Text(
                "${model.duration}（${model.distance}）",
                style: _itemSubTitleStyle,
              ),
              Text(
                "🚥：${model.lightNum}个     拥堵长度：${model.congestionMetres}米",
                style: _itemSubTitleStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () => _onTapRouteItem(index),
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
          duration: _selectedDriveRouteModel?.duration,
          distance: _selectedDriveRouteModel?.distance,
          onTapDetailBtn: _onTapDetail,
        ),
      ),
    );
  }
}

final _searchBarTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

final _itemTitleStyle = TextStyle(
  color: Color(0xFF333333),
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

final _itemSubTitleStyle = TextStyle(
  color: Color(0xFF333333),
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

final _trafficTextures = [
  "images/traffic_texture_unknown.png",
  "images/traffic_texture_smooth.png",
  "images/traffic_texture_slow.png",
  "images/traffic_texture_congestion.png",
];
