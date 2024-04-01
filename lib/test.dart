// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Persistent BottomSheet',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
//   int size = 0;
//   bool isKeyboard = false;
//   bool isSubmit = false;
//   TextInputType? keyboardType;
//   final FocusNode _focusNode1 = FocusNode();
//   final FocusNode _focusNode2 = FocusNode();
//   final TextEditingController _sharedController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _sharedController.dispose();
//     _focusNode1.dispose();
//     _focusNode2.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeMetrics() {
//     final bottomInset = MediaQuery.of(context).viewInsets.bottom;
//     if (bottomInset > 0) {
//       // Bàn phím được mở
//       setState(() {
//         size = 0;
//       });
//       print('Keyboard opened');
//     } else {
//       setState(() {
//         if(keyboardType == TextInputType.text){
//           size = 345;
//         }
//         else{
//           size = 250;
//         }
//       }
//       );
//       // Bàn phím được đóng
//       print('Keyboard closed');
//                       size = 250;
//     }
//   }
//   void _toggleFocus() {
//     setState(() {
//       if (_focusNode1.hasFocus) {
//         // Nếu TextField 1 đang được focus, chuyển focus sang TextField 2
//         size = 250;
//         FocusScope.of(context).requestFocus(_focusNode2);
//       } else {
//         // Ngược lại, focus vào TextField 1
//         size = 350;
//         FocusScope.of(context).requestFocus(_focusNode1);
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: ExpandableBottomSheet(
//         background: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.only(top: 100),
//             child: Stack(
//               children: [
//
//                 TextField(
//                   focusNode: _focusNode2,
//                   textInputAction: TextInputAction.go,
//                   controller: _sharedController,
//                   keyboardType:  TextInputType.number,
//                   onChanged: (value){
//                     setState(() {
//                       keyboardType = TextInputType.number;
//                       size = 250;
//                     });
//                     print("day la $keyboardType");
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Nhap du lieu',
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                 ),
//                 TextField(
//                   onTap: (){
//                     setState(() {
//                       size = 350;
//                     });
//                   },
//                   focusNode: _focusNode1,
//                   textInputAction: TextInputAction.go,
//                   controller: _sharedController,
//                   keyboardType: TextInputType.text,
//                   onChanged: (value){
//                     setState(() {
//                       keyboardType = TextInputType.text ;
//                       size = 350;
//                     });
//                     print("day la $keyboardType");
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Nhap du lieu',
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ),
//         expandableContent: Container(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           height: size.toDouble(),
//           color: Colors.grey.shade200,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: InkWell(
//                       onTap: _toggleFocus,
//                       child: Icon(FontAwesomeIcons.keyboard, size: 30,),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: (){
//                     },
//                     child: Icon(FontAwesomeIcons.xmark),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // persistentHeader: Container(
//         //   color: Colors.red,
//         // ),
//         persistentContentHeight: size.toDouble(),
//       ),
//     );
//
//
//   }
// }
