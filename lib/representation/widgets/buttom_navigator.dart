// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:flutter/material.dart';
//
// class ButtonNavigator extends StatefulWidget {
//   const ButtonNavigator({super.key});
//   CurvedNavigationBarState _bottomNavigationKey;
//   @override
//   State<ButtonNavigator> createState() => _ButtonNavigatorState();
// }
//
// class _ButtonNavigatorState extends State<ButtonNavigator> {
//   @override
//   Widget build(BuildContext context) {
//     return CurvedNavigationBar(
//       key: _bottomNavigationKey,
//       index: 0,
//       items: [
//         CurvedNavigationBarItem(
//           child: Image.asset(AssetPath.icoHome),
//           label: 'Trang Chủ',
//         ),
//         CurvedNavigationBarItem(
//           child: Image.asset(AssetPath.icoGift2),
//           label: 'Đổi quà',
//         ),
//         CurvedNavigationBarItem(
//           child: Image.asset(AssetPath.icoQR),
//           label: 'QR',
//         ),
//         CurvedNavigationBarItem(
//           child: Image.asset(AssetPath.icoNotification),
//           label: 'Thông báo',
//         ),
//         CurvedNavigationBarItem(
//           child: Image.asset(AssetPath.icoSetting),
//           label: 'Cài đặt',
//         ),
//       ],
//       color: Colors.white,
//       buttonBackgroundColor: Colors.white,
//       backgroundColor: Colors.red.shade200,
//       animationCurve: Curves.easeInOut,
//       animationDuration: Duration(milliseconds: 600),
//       onTap: (index) {
//         setState(() {
//           _page = index;
//         });
//       },
//       letIndexChange: (index) => true,
//     ),;
//   }
// }
