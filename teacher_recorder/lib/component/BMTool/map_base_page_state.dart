import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

/// State 基类
class BMFBaseMapState<T extends StatefulWidget> extends State<T> {


  BMFMapController myMapController;

  Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFf7f7f7),
      ),
    );
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    myMapController = controller;

    /// 地图加载回调
    myMapController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(31.811643, 117.230512),
      zoomLevel: 12,
    );
    return mapOptions;
  }

  /// 创建地图
  Container generateMap() {
    return Container(
      color: Colors.white,
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller);
        },
        mapOptions: initMapOptions(),

      ),
    );
  }

  /// 创建控制栏
  Widget generateControlBar() {
    throw UnimplementedError();
  }
}
