import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:teacher_recorder/Pages/Home/child/BMlocationTool.dart';
import 'package:teacher_recorder/component/BMTool/map_base_page_state.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'dart:async';
import 'package:teacher_recorder/component/Tool/colors.dart';

class mapPage extends StatefulWidget{


  mapPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _mapPageState();

  }

}

class _mapPageState extends BMFBaseMapState<mapPage>{



  Map<String, Object> _loationResult;

  StreamSubscription<Map<String, Object>> _locationListener;

  BaiduLocation _baiduLocation; // 定位结果

  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

  /// 是否展示定位图层
  bool _showUserEnabled = true;

  /// 我的位置
  BMFUserLocation _userLocation;

  /// 定位点样式
  BMFUserLocationDisplayParam _displayParam;


  @override
  void initState() {
    super.initState();

    /// 动态申请定位权限
    _locationPlugin.requestPermission();

    /// 设置ios端ak, android端ak可以直接在清单文件中配置
    LocationFlutterPlugin.setApiKey("pG0QFKQ9S7bpz5MoHqunY7rFuN45yAhP");

    _locationListener = _locationPlugin
        .onResultCallback()
        .listen((Map<String, Object> result) {
      setState(() {
        _loationResult = result;
        if (_showUserEnabled) {
          updateUserLocation();
          updatUserLocationDisplayParam();
        }
        try {
          _baiduLocation = BaiduLocation.fromMap(result); // 将原生端返回的定位结果信息存储在定位结果类中
          print("===================================================${_baiduLocation}");
        } catch (e) {
          print(e);
        }

      });
    });

  }

  @override
  void dispose() {
    super.dispose();

    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
      print("==================");
    }
    if (null != _locationListener) {
      _locationListener.cancel(); // 停止定位
      print("+++++++++++++++++");
    }
  }

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (controller != null){
      /// 地图加载回调
      myMapController?.setMapDidLoadCallback(callback: () {
        print('mapDidLoad-地图加载完成');

        myMapController?.showUserLocation(_showUserEnabled);

        if (_showUserEnabled) {
          updateUserLocation();
          updatUserLocationDisplayParam();
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    if (null != _locationPlugin && _loationResult == null) {
      BMLocationTool.setLocOption(_locationPlugin);
      _locationPlugin.startLocation();

    }

    if (_showUserEnabled != null && _loationResult != null) {
      updateUserLocation();
      updatUserLocationDisplayParam();
    }

    super.build(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.NavMainColor,
        brightness: Brightness.dark,
        title: Text("位置"),
      ),
      body: generateMap(),
    );
  }


  @override
  Container generateMap() {
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: (mapController) {
          onBMFMapCreated(mapController);
        },
        mapOptions: initMapOptions(),
      ),
    );
  }

  /// 设置地图参数
  @override
  BMFMapOptions initMapOptions() {

    BMFMapOptions mapOptions = BMFMapOptions(
      center:  BMFCoordinate(31.805538679101623, 117.23100881428248),
      zoomLevel: 18,
      maxZoomLevel: 18,
      minZoomLevel: 1,
      // mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
    );
    return mapOptions;
  }

  /// 更新位置
  void updateUserLocation() {

    BMFCoordinate coordinate = BMFCoordinate( _loationResult["latitude"],  _loationResult["longitude"]);
    BMFLocation location = BMFLocation(
        coordinate: coordinate,
        altitude: 0,
        horizontalAccuracy: 5,
        verticalAccuracy: -1.0,
        speed: -1.0,
        course: -1.0
    );
    BMFUserLocation userLocation = BMFUserLocation(
      location: location,
    );
    _userLocation = userLocation;
    myMapController.setCenterCoordinate(_userLocation.location.coordinate, true);
    myMapController?.updateLocationData(_userLocation);
  }

  /// 更新定位图层样式
  void updatUserLocationDisplayParam() {
    BMFUserLocationDisplayParam displayParam = BMFUserLocationDisplayParam(
        locationViewOffsetX: 0,
        locationViewOffsetY: 0,
        accuracyCircleFillColor: Colors.red,
        accuracyCircleStrokeColor: Colors.blue,
        isAccuracyCircleShow: true,
        locationViewImage: 'images/teeachericon.png',
        locationViewHierarchy:
        BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_BOTTOM);

    _displayParam = displayParam;
    myMapController?.updateLocationViewWithParam(_displayParam);
  }

}