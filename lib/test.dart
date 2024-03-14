// import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: BottomSheetExample(),
//       ),
//     );
//   }
// }
//
// class BottomSheetExample extends StatefulWidget {
//   @override
//   _BottomSheetExampleState createState() => _BottomSheetExampleState();
// }
//
// class _BottomSheetExampleState extends State<BottomSheetExample> {
//   final ScrollController _scrollController = ScrollController();
//   double _expandedHeight = 500.0;
//   double _bottomSheetOffset = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _scrollListener() {
//     setState(() {
//       _bottomSheetOffset = _scrollController.offset;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableBottomSheet(
//       background: Container(
//         color: Colors.blue,
//       ),
//       persistentHeaderHeight: 50,
//       expandedHeight: _expandedHeight,
//       persistentHeader: InkWell(
//         onTap: () {
//           ExpandableBottomSheet.of(context).controller.toggle();
//         },
//         child: Container(
//           color: Colors.grey,
//           child: Center(
//             child: Text(
//               'Tap Here',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//       expandableContent: ListView.builder(
//         controller: _scrollController,
//         itemCount: 50,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Item $index'),
//           );
//         },
//       ),
//       anchorColor: Colors.white,
//       backgroundCornerRadius: 50,
//       persistentFooter: Container(
//         color: Colors.white,
//         height: 50,
//         child: Center(
//           child: Text('Footer'),
//         ),
//       ),
//       bottomOffset: _bottomSheetOffset,
//     );
//   }
// }
