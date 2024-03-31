// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:keyboard_actions/keyboard_actions.dart';
// import 'package:provider/provider.dart';
// import 'package:vrb_client/provider/login_provider.dart';
// import 'package:vrb_client/representation/widgets/text_field_keyboard_widget.dart';
//
// class keyboard extends StatefulWidget {
//   const keyboard({super.key});
//
//   @override
//   State<keyboard> createState() => _keyboardState();
// }
//
// class _keyboardState extends State<keyboard> {
//   // TextInputType keyboardType = TextInputType.text;
//   // FocusNode focusNode = FocusNode();
//   // bool isCheckHeight = true;
//   // bool isVisibleButtonSheet = false;
//   //
//   // void _changeKeyboardType() {
//   //   setState(() {
//   //     if (keyboardType == TextInputType.text) {
//   //       keyboardType = TextInputType.number;
//   //       isCheckHeight = true;
//   //     } else {
//   //       keyboardType = TextInputType.text;
//   //       isCheckHeight = false;
//   //     }
//   //   });
//   //   focusNode.unfocus();
//   //   Future.delayed(Duration(milliseconds: 1), () {
//   //     FocusScope.of(context).requestFocus(focusNode);
//   //   });
//   //   print(isCheckHeight);
//   // }
//
//   // @override
//   // void dispose() {
//   //   focusNode.dispose();
//   //   super.dispose();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
//       onTap: () {
//         // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
//         FocusScope.of(context).requestFocus(FocusNode());
//         setState(() {
//           Provider.of<LoginProvider>(context, listen: false).setVisibleButtonSheet(false);
//         });
//         Provider.of<LoginProvider>(context, listen: false).setCheckHeight(true);
//         Provider.of<LoginProvider>(context, listen: false).setkeyboardType(TextInputType.text);
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text('Xin chao'),
//         ),
//         // body: Center(
//         //   child: Column(
//         //     children: [
//         //       TextField(
//         //         keyboardType: keyboardType,
//         //         focusNode: focusNode,
//         //         onTap: () {
//         //           setState(() {
//         //             isVisibleButtonSheet = true;
//         //           });
//         //         },
//         //         onSubmitted: (val){
//         //           setState(() {
//         //             isVisibleButtonSheet = false;
//         //             isCheckHeight = true;
//         //             keyboardType = TextInputType.text;
//         //           }
//         //           );
//         //         },
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         body: SingleChildScrollView(child: TextFieldKeyboardWidget()),
//         bottomSheet: Consumer<LoginProvider>(builder: (context, keyboard, child){
//           return Visibility(
//             visible: keyboard.isCheckHeight,
//             replacement: Visibility(visible: keyboard.isVisibleButtonSheet, child: _buildButton(250)),
//             child: Visibility(visible: keyboard.isVisibleButtonSheet, child: _buildButton(350)),
//           );
//         },),
//         bottomSheet: Visibility(
//           visible: isCheckHeight,
//           replacement: Visibility(visible: isVisibleButtonSheet, child: _buildButton(250)),
//           child: Visibility(visible: isVisibleButtonSheet, child: _buildButton(350)),
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }
//
//   Widget _buildButton(double height) {
//     return Consumer<LoginProvider>(builder: (context, keyboard,  child){
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         height: height,
//         color: Colors.grey.shade200,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   child: GestureDetector(
//                     onTap: (){
//                       keyboard.changeKeyboardType(context);
//                     },
//                     child: const Icon(
//                       FontAwesomeIcons.keyboard,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     keyboard.focusNode.unfocus();
//                     keyboard.setVisibleButtonSheet(false);
//                     keyboard.setCheckHeight(true);
//                     keyboard.setkeyboardType(TextInputType.text);
//                   },
//                   child: Icon(FontAwesomeIcons.xmark),
//                 )
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
// }
