import 'package:flutter/material.dart';
import 'package:teacher_recorder/Pages/Home/Map/driveMap.dart';
import 'package:teacher_recorder/Pages/Home/Map/ridingMap.dart';
import 'package:teacher_recorder/Pages/Home/Map/busMap.dart';


class orderRouteMap extends StatefulWidget {

  String start;
  String end;

  orderRouteMap(this.start,this.end);

  @override
  _orderRouteMapState createState() => _orderRouteMapState(this.start ,this.end);
}

class _orderRouteMapState extends State<orderRouteMap> {

  int Mapindex = 0;
  List sampleData = new List();

  String start;
  String end;
  _orderRouteMapState(this.start,this.end);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(true, '骑行', ));
    sampleData.add(new RadioModel(false, '公交', ));
    sampleData.add(new RadioModel(false, '驾车', ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _chooseMap(),
          _contentTop(),
        ],
      ),
    );
  }

  Widget _chooseMap(){

    if(Mapindex == 0){
     return ShowRidingRouteSearchPage(this.start,this.end);
    }else if(Mapindex == 1){
      return ShowBusRouteSearchPage(this.start,this.end);
    }else if(Mapindex == 2){
      return ShowDrivingRouteSearchPage(this.start,this.end);
    }
  }

  Widget _contentTop(){

    return Positioned(
      left: 15,
      right: 15,
      top: 30+MediaQuery.of(context).padding.top,
      child:Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(child: Row(
              children: [

                Expanded(child:Padding(padding: EdgeInsets.all(10),
                  child: IconButton(
                  icon: new Icon(Icons.arrow_back_ios),
                  tooltip: 'Increase volume by 10%',
                  onPressed: () {
                    // ...
                    Navigator.pop(context);
                  },
                ),),flex: 1,),

                Expanded(child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Padding(padding: EdgeInsets.only(left: 5,top: 10),child: Text("起: ${start}",style: TextStyle(fontWeight: FontWeight.bold),),),flex: 1,),
                    Expanded(child: Padding(padding: EdgeInsets.only(left: 5,),child: Text("终: ${end}",style: TextStyle(fontWeight: FontWeight.bold)),),flex: 1,),
                  ],
                ),flex: 4,),
              ],
            ),flex: 2,),

            Expanded(
              child:Padding(padding: EdgeInsets.only(left: 35,right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List<Widget>.generate(sampleData.length, (index){
                    return InkWell(
                      child: _buttonstyle(sampleData[index]),
                      onTap: (){
                        setState(() {
                          sampleData.forEach((element) => element.isSelected = false);
                          print(sampleData[index].buttonText);
                          sampleData[index].isSelected = true;
                          Mapindex = index;
                        });
                      },
                    );
                  }
                  ),
                ),
              ),flex: 1,),
          ],
        ),
      )
    );
  }

  Widget _buttonstyle(sampleData) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Container(
            height: 25,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25/2)),
              color: sampleData.isSelected? Colors.grey:Colors.white,
              // border: Border.all(width: 1,color: sampleData.isSelected? Colors.blue:Colors.grey),
            ),
          ),
          Container(
            height: 25,
            width: 50,
            // padding: Padding(padding: EdgeInsets.only(left: 35)),
            child: Center(child: Text("${sampleData.buttonText}",style: TextStyle(
              color: sampleData.isSelected? Colors.white:Colors.black,
            ),)),
          ),
        ],
      ),
    );
  }

}



class RadioModel {
  bool isSelected;
  final String buttonText;
  RadioModel(this.isSelected, this.buttonText,);
}