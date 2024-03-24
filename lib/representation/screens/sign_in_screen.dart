// import 'package:flutter/material.dart';
//
// import '../../core/constants/assets_path.dart';
// import '../../core/constants/dimension_constants.dart';
// import '../widgets/bottom_bar_widget.dart';
//
// class SignInSceen extends StatefulWidget {
//   const SignInSceen({super.key});
//
//   @override
//   State<SignInSceen> createState() => _SignInSceenState();
// }
//
// class _SignInSceenState extends State<SignInSceen> {
//   bool _isPressed = false;
//   void _toggleImage() {
//     setState(() {
//       _isPressed = !_isPressed;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
//       onTap: () {
//         // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
//         FocusScope.of(context).requestFocus(FocusNode());
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               child: Image.asset(AssetPath.blockWhite),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: Image.asset(AssetPath.backgroundBottom),
//             ),
//             Positioned(bottom: 0, child: BottomBarWidget()),
//             Positioned(
//               top: 50, // Đặt giá trị top cho Row
//               left: 0, // Đặt giá trị left cho Row
//               right: 0, // Đặt giá trị right cho Row
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 80,
//                         height: 50,
//                       ),
//                       Expanded(
//                         child: Image.asset(AssetPath.logo_1x),
//                       ),
//                       InkWell(
//                         onTap: _toggleImage,
//                         child: Container(
//                           width: 80,
//                           height: 50,
//                           padding: EdgeInsets.all(8),
//                           child: _isPressed
//                               ? Image.asset(AssetPath.buttonLanguage)
//                               : Image.asset(AssetPath.buttonLanguage),
//                         ),
//                       ),
//                     ],
//                   ),
//                  Container(
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         // Image.asset(AssetPath.avatar),
//                         Container(
//                           width: 80, // Đảm bảo kích thước của ảnh bằng nhau
//                           height: 80,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white, // Màu nền của hình tròn
//                           ),
//                           child: ClipOval(
//                             child: InkWell(
//                               onTap: (){}
//                             ),
//                           ),
//                         )
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           context.watch<UserModel>().userName.toString(),
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                         const SizedBox(
//                           height: kMediumPadding,
//                         ),
//                       ],
//                     ),
//                   )
//                   SizedBox(
//                     height: kDefaultPadding,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 obscureText: _obscureText,
//                                 decoration: const InputDecoration(
//                                     hintText: 'Nhập mật khẩu',
//                                     border: InputBorder.none),
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(_obscureText
//                                   ? Icons.visibility
//                                   : Icons.visibility_off),
//                               onPressed: _toggleVisibility,
//                             ),
//                           ],
//                         ),
//                         Container(
//                           height: 1, // Chiều cao của đường line
//                           color: Colors.grey, // Màu của đường line
//                         ),
//                         const SizedBox(
//                           height: kMinPadding * 2,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               child: InkWell(
//                                 child: Text(
//                                   "Quên mật khẩu?",
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.blue.shade900),
//                                 ),
//                                 onTap: () {},
//                               ),
//                             ),
//                             Container(
//                               child: InkWell(
//                                 child: Text(
//                                   "Đăng ký mở tài khoản",
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.blue.shade900),
//                                 ),
//                                 onTap: () {},
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: kDefaultPadding * 3,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(8),
//                               width: 270,
//                               height: 45,
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors: [
//                                       const Color(0xFF19226D).withOpacity(0.9),
//                                       const Color(0xFFED1C24).withOpacity(0.8),
//                                     ],
//                                     stops: [0.5, 1],
//                                   ),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(15))),
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     _islogin = true;
//                                   });
//                                   checkLogin();
//                                   Navigator.of(context)
//                                       .pushNamed(MainApp.routeName);
//                                 },
//                                 child: Align(
//                                     child: _ischecklogin
//                                         ? CircularProgressIndicator(
//                                       color: Colors.white,
//                                     ) :Text(
//                                       "Đăng nhập",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                 ),
//                               ),
//                             ),
//                             //TODO van tay
//                             InkWell(
//                               onTap: _authenticate,
//                               child: Image.asset(AssetPath.fingerprintButton),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: kDefaultPadding,
//                         ),
//                         Align(
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 _islogin = false;
//                               });
//                             },
//                             child: Text(
//                               " Đăng nhập tài khoản khác",
//                               style: TextStyle(
//                                   color: Colors.blue.shade900, fontSize: 14),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );;
//   }
// }
