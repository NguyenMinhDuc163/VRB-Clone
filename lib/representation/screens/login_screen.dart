import 'dart:io';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/provider/login_provider.dart';
import 'package:vrb_client/representation/screens/main_app.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/user_model.dart';
import '../../provider/dialog_provider.dart';
import '../../provider/location_provider.dart';
import '../widgets/bottom_bar_widget.dart';
import 'package:local_auth/local_auth.dart';

import '../widgets/textfield_keyboard_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = '/login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPressed = false;
  bool _obscureText = true;
  bool _islogin = false;
  bool _ischecklogin = false;
  late final LocalAuthentication auth;
  bool _supportState = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate for testing',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        Provider.of<DialogProvider>(context, listen: false)
            .showLoadingDialog(context);
        await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
        Provider.of<DialogProvider>(context, listen: false)
            .hideLoadingDialog(context);
        Navigator.of(context).pushNamed(MainApp.routeName);
      } else {
        print("khong thuc hien duoc");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print(availableBiometrics);
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    // lay kichh thuoc ca ban phimm
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
      onTap: () {
        // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                    // Text(LocaleKeys.you_have_pushed_the_button_this_many_times.tr()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 80,
                          height: 50,
                        ),
                        Expanded(
                          child: Image.asset(AssetPath.logo_1x),
                        ),
                        GestureDetector(
                          //TODO language
                          // onTap: _toggleImage,
                          onTap: () {
                            if (context.locale == Locale('vi')) {
                              context.setLocale(Locale('en'));
                            } else {
                              context.setLocale(Locale('vi'));
                            }
                            setState(() {
                              _isPressed = !_isPressed;
                            });
                          },
                          child: Container(
                              width: 65,
                              height: 42,
                              padding: EdgeInsets.all(8),
                              child: !_isPressed
                                  ? _buildIconLanguage(AssetPath.icoVN, "VN")
                                  : _buildIconLanguage(
                                      AssetPath.icoAmerica, "EN")),
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
                                // Image.asset(AssetPath.avatar),
                                Consumer<UserModel>(
                                    builder: (context, user, child) {
                                  return Container(
                                    width:
                                        80, // Đảm bảo kích thước của ảnh bằng nhau
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Colors.white, // Màu nền của hình tròn
                                    ),
                                    child: ClipOval(
                                      child: InkWell(
                                        onTap: () {
                                          Provider.of<UserModel>(context,
                                                  listen: false)
                                              .pickAndSetAvatar(context);
                                        },
                                        child: (user.avatar == AssetPath.avatar)
                                            ? Image.asset(user.avatar)
                                            : Image.file(File(user.avatar)),
                                      ),
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  context
                                      .watch<UserModel>()
                                      .userName
                                      .toString(),
                                  style: const TextStyle(
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
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: kDefaultPadding),
                            child: const Column(
                              children: [
                                SizedBox(
                                  height: kMediumPadding * 4,
                                ),
                                TextFieldKeyBoardWidget(),
                              ],
                            ),
                          ),
                    // SizedBox(
                    //   height: kDefaultPadding,
                    // ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kMinPadding * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: InkWell(
                                  child: Text(
                                    LocaleKeys.register.tr(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue.shade900),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  LocaleKeys.forgot.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade900),
                                ),
                                onTap: () {},
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
                                        const Color(0xFF19226D)
                                            .withOpacity(0.9),
                                        const Color(0xFFED1C24)
                                            .withOpacity(0.8),
                                      ],
                                      stops: [0.5, 1],
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: InkWell(
                                  onTap: () async {
                                    checkLogin(context);
                                    Provider.of<DialogProvider>(context,
                                            listen: false)
                                        .showLoadingDialog(context);
                                    await Future.delayed(const Duration(
                                        milliseconds: 200)); // Đợi trong 2 giây
                                    Provider.of<DialogProvider>(context,
                                            listen: false)
                                        .hideLoadingDialog(context);
                                    Navigator.of(context)
                                        .pushNamed(MainApp.routeName);
                                    setState(() {
                                      _islogin = true;
                                    });
                                  },
                                  child: Align(
                                      child: Text(
                                    LocaleKeys.signIn.tr(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              //TODO van tay
                              InkWell(
                                onTap: _authenticate,
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
                                LocaleKeys.signInAnother.tr(),
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
          // bottomSheet: Consumer<LoginProvider>(
          //   builder: (context, keyboard, child) {
          //     return _buildButton(keyboardHeight + 35) ;
          //   },
          // )
      ),
    );
  }

  Widget _buildButton(double height) {
    return Consumer<LoginProvider>(builder: (context, keyboard, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: height > 50 ? height : 0,
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      keyboard.switchKeyboard();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.keyboard,
                          size: 35,
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        SizedBox(
                          height: 35,
                          child: Center(
                            child: Text(
                              (keyboard.isChange)
                                  ? 'abc'
                                  : '123',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // keyboard.focusNode.unfocus();
                    FocusScope.of(context).requestFocus(FocusNode());
                    keyboard.setVisibleButtonSheet(false);
                  },
                  child: Icon(FontAwesomeIcons.xmark),
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildIconLanguage(String path, String name) {
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // Màu viền
            width: 2, // Độ dày của viền
          ),
        ),
        // width: 15,
        // height: 15,
        child: (name == "EN")
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    path,
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                  Container(
                      child: Text(
                    name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ))
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                    name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  Image.asset(
                    path,
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                ],
              ));
  }

  Future<void> checkLogin(BuildContext context) async {
    Provider.of<DialogProvider>(context, listen: false)
        .showLoadingDialog(context);
    await Future.delayed(const Duration(milliseconds: 200)); // Đợi trong 2 giây
    Provider.of<DialogProvider>(context, listen: false)
        .hideLoadingDialog(context);
  }
}
