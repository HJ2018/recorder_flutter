// import 'package:flutter/material.dart';
//
//
// class CourseDetailsItemWidget extends StatelessWidget{
//
//
//   int rowindex;
//   CourseDetailsItemWidget(this.rowindex);
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     if(rowindex == 0){
//       return ListOneWidget();
//
//     }if(rowindex == 1){
//       return Container(
//         child: ListTwoWidget(),
//       );
//     }if(rowindex == 2){
//       return Container(
//         child: ListThreeWidget(),
//       );
//     }if(rowindex == 3){
//       return Container(
//         child: ListFourWidget(),
//       );
//     }
//   }
// }
//
//
// class ListOneWidget extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     return Container(
//       // color: Color.fromARGB(180, 192, 192, 192),
//       child: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(child: Padding(padding: EdgeInsets.only(left: 10,top: 5),
//             child: Text(
//               "王老师",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),),
//           ),flex: 1),
//
//           Padding(padding: EdgeInsets.only(top: 5)),
// //                        margin
//           Expanded(child: Padding(padding: EdgeInsets.only(left: 10),
//             child: Text(
//               "上课时间：2021-04-21 / 12:00 - 14:50",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 16,
//               ),),
//           ),flex: 1),
//
//
//           Expanded(child:Padding(padding: EdgeInsets.only(top: 0,bottom: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(child: Padding(padding: EdgeInsets.only(left: 10),
//                   child: Text(
//                     "上课时长：2h",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),),
//                 ),flex: 1),
//
//
//                 Expanded(child: Padding(padding: EdgeInsets.only(left: 10),
//                   child: Text(
//                     "学生：张三",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),),
//                 ),flex: 1),
//               ],
//             ),
//           ),flex: 1),
//         ],
//       ),),
//     );
//   }
// }
//
// class ListTwoWidget extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(padding: EdgeInsets.only(left:10,top: 10),
//             child: Text(
//               "【上课内容】",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.blue,
//               ),),
//           ),
//
//           Padding(padding: EdgeInsets.only(left:15,top: 5,right: 10,bottom: 15),
//             child: Text(
//               "教学内容：四年级下册前四个单元字词和古诗词复习，阅读理解指导课后反馈：在期中考试前再将不熟悉的诗词背诵熟悉一下，阅读几篇优秀的有关“奇思妙思”和“我的动物朋友”的作文为自己积累一下素材，学习别人的作文结构和逻辑。",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 15,
//               ),),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class ListThreeWidget extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(padding: EdgeInsets.only(left:10,top: 10),
//             child: Text(
//               "【作业】",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.blue,
//               ),),
//           ),
//
//           Padding(padding: EdgeInsets.only(left:15,top: 5,right: 10,bottom: 15),
//             child: Text(
//               "教学内容：四年级下册前四个单元字词和古诗词复习，阅读理解指导课后反馈：",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 15,
//               ),),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ListFourWidget extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(padding: EdgeInsets.only(left:10,top: 10),
//             child: Text(
//               "【课后反馈】",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.blue,
//               ),),
//           ),
//
//           Padding(padding: EdgeInsets.only(left:15,top: 5,right: 10,bottom: 15),
//             child: Text(
//               "教学内容：四年级下册前四个单元字词和古诗词复习，阅读理解指导课后反馈：",
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontSize: 15,
//               ),),
//           ),
//         ],
//       ),
//     );
//   }
// }