// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:keyboard_actions/keyboard_actions.dart';
// import 'package:provider/provider.dart';
// import 'package:vrb_client/provider/login_provider.dart';
// import 'package:vrb_client/representation/widgets/textfield_keyboard_widget.dart';
//
// class keyboard extends StatefulWidget {
//   const keyboard({super.key});
//
//   @override
//   State<keyboard> createState() => _keyboardState();
// }
//
// class _keyboardState extends State<keyboard> {
//   TextInputType keyboardType = TextInputType.text;
//   FocusNode focusNode = FocusNode();
//   bool isCheckHeight = true;
//   bool isVisibleButtonSheet = false;
//
//   void _changeKeyboardType() {
//     setState(() {
//       if (keyboardType == TextInputType.text) {
//         keyboardType = TextInputType.number;
//         isCheckHeight = true;
//       } else {
//         keyboardType = TextInputType.text;
//         isCheckHeight = false;
//       }
//     });
//     focusNode.unfocus();
//     Future.delayed(Duration(milliseconds: 1), () {
//       FocusScope.of(context).requestFocus(focusNode);
//     });
//     print(isCheckHeight);
//   }
//
//   @override
//   void dispose() {
//     focusNode.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
//       onTap: () {
//         // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
//         FocusScope.of(context).requestFocus(FocusNode());
//         setState(() {
//           isVisibleButtonSheet = false;
//         });
//         isCheckHeight = true;
//         keyboardType = TextInputType.text;
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text('KeyBoard'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               TextField(
//                 keyboardType: keyboardType,
//                 focusNode: focusNode,
//                 onTap: () {
//                   setState(() {
//                     isVisibleButtonSheet = true;
//                   });
//                 },
//                 onSubmitted: (val){
//                   setState(() {
//                     isVisibleButtonSheet = false;
//                     isCheckHeight = true;
//                     keyboardType = TextInputType.text;
//                   }
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//
//         bottomSheet: Visibility(
//           visible: isCheckHeight,
//           replacement: Visibility(visible: isVisibleButtonSheet, child: _buildButton(255)),
//           child: Visibility(visible: isVisibleButtonSheet, child: _buildButton(355)),
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }
//
//   Widget _buildButton(double height) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       height: height,
//       color: Colors.grey.shade200,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 child: GestureDetector(
//                   onTap: (){
//                     _changeKeyboardType();
//                   },
//                   child: const Icon(
//                     FontAwesomeIcons.keyboard,
//                     size: 35,
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   focusNode.unfocus();
//                   isVisibleButtonSheet = false;
//                   isCheckHeight = false;
//                   keyboardType = TextInputType.text;
//                 },
//                 child: Icon(FontAwesomeIcons.xmark),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
// }
