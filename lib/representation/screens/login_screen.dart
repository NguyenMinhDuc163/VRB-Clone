import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/representation/screens/contact_helper.dart';
import 'package:vrb_client/representation/screens/exchange_rate_screen.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/interest_screen.dart';
import 'package:vrb_client/representation/screens/location_screen.dart';
import 'package:vrb_client/representation/screens/main_app.dart';
import 'package:vrb_client/representation/screens/qr_code_screen.dart';

import '../widgets/bottom_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = '/splash_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPressed = false;
  bool _obscureText = true;
  bool _islogin = false;
  int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _toggleImage() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(AssetPath.blockWhite),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AssetPath.backgroundBottom),
          ),
          Positioned(bottom: 0, child: BottomBarWidget()),
          Positioned(
            top: 50, // Đặt giá trị top cho Row
            left: 0, // Đặt giá trị left cho Row
            right: 0, // Đặt giá trị right cho Row
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 50,
                    ),
                    Expanded(
                      child: Image.asset(AssetPath.logo_1x),
                    ),
                    InkWell(
                      onTap: _toggleImage,
                      child: Container(
                        width: 80,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        child: _isPressed
                            ? Image.asset(AssetPath.buttonLanguage)
                            : Image.asset(AssetPath.buttonLanguage),
                      ),
                    ),
                  ],
                ),
                (_islogin)
                    ? Container(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Image.asset(AssetPath.avatar),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Nguyen Van A",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: kMediumPadding,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          children: [
                            SizedBox(
                              height: kMediumPadding * 4,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Tên truy Cập ',
                                        border: InputBorder.none),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.user),
                                  onPressed: _toggleVisibility,
                                ),
                              ],
                            ),
                            Container(
                              height: 1, // Chiều cao của đường line
                              color: Colors.grey, // Màu của đường line
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: _obscureText,
                              decoration: const InputDecoration(
                                  hintText: 'Nhập mật khẩu',
                                  border: InputBorder.none),
                            ),
                          ),
                          IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: _toggleVisibility,
                          ),
                        ],
                      ),
                      Container(
                        height: 1, // Chiều cao của đường line
                        color: Colors.grey, // Màu của đường line
                      ),
                      const SizedBox(
                        height: kMinPadding * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: InkWell(
                              child: Text(
                                "Quên mật khẩu?",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blue.shade900),
                              ),
                              onTap: () {},
                            ),
                          ),
                          Container(
                            child: InkWell(
                              child: Text(
                                "Đăng ký mở tài khoản",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blue.shade900),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 270,
                            height: 45,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFF19226D).withOpacity(0.9),
                                    const Color(0xFFED1C24).withOpacity(0.8),
                                  ],
                                  stops: [0.5, 1],
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _islogin = true;
                                });
                                Navigator.of(context)
                                    .pushNamed(MainApp.routeName);
                              },
                              child: const Align(
                                  child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //TODO van tay
                              Navigator.of(context)
                                  .pushNamed(ExchangeRateScreen.routeName);
                            },
                            child: Image.asset(AssetPath.fingerprintButton),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Align(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _islogin = false;
                            });
                          },
                          child: Text(
                            " Đăng nhập tài khoản khác",
                            style: TextStyle(
                                color: Colors.blue.shade900, fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: 0,
      //   items: [
      //     CurvedNavigationBarItem(
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.of(context).pushNamed(ExchangeRateScreen.routeName);
      //         },
      //         child: Image.asset(AssetPath.tiGia),
      //       ),
      //       label: 'Tỉ giá',
      //     ),
      //     CurvedNavigationBarItem(
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.of(context).pushNamed(InterestScreen.routeName);
      //         },
      //         child: Image.asset(AssetPath.laiSuat),
      //       ),
      //       label: 'Lãi xuất',
      //     ),
      //     CurvedNavigationBarItem(
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.of(context).pushNamed(QRCodeScreen.routeName);
      //         },
      //         child: Image.asset(AssetPath.icoQR),
      //       ),
      //       label: 'QR',
      //     ),
      //     CurvedNavigationBarItem(
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.of(context).pushNamed(LocationScreen.routeName);
      //         },
      //         child: Image.asset(AssetPath.notificationBing),
      //       ),
      //       label: 'Thông báo',
      //     ),
      //     CurvedNavigationBarItem(
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.of(context).pushNamed(ContactHelper.routeName);
      //         },
      //         child: Image.asset(AssetPath.headPhone),
      //       ),
      //       label: 'Liên hệ',
      //     ),
      //   ],
      //   color: Colors.white,
      //   buttonBackgroundColor: Colors.white,
      //   backgroundColor: Colors.red.shade200,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: Duration(milliseconds: 600),
      //   onTap: (index) {
      //     setState(() {
      //       _page = index;
      //     });
      //   },
      //   letIndexChange: (index) => true,
      // ),
    );
  }
}
