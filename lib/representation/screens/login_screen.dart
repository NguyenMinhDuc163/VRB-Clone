import 'dart:io';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/representation/screens/main_app.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/user_model.dart';
import '../../provider/dialog_provider.dart';
import '../widgets/bottom_bar_widget.dart';
import 'package:local_auth/local_auth.dart';

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
    super.dispose();
  }

  Future<void> _authenticate() async {
    try{
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate for testing',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if(authenticated){
        Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
        await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
        Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
        Navigator.of(context).pushNamed(MainApp.routeName);

      }
      else{
        print("khong thuc hien duoc");
      }
    } catch(e){
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    print(availableBiometrics);
    if(!mounted){
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
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
                      SizedBox(
                        width: 80,
                        height: 50,
                      ),
                      Expanded(
                        child: Image.asset(AssetPath.logo_1x),
                      ),
                      InkWell(
                        //TODO language
                        // onTap: _toggleImage,
                        onTap: (){
                          if (context.locale == Locale('vi')) {
                            context.setLocale(Locale('en'));
                          } else {
                            context.setLocale(Locale('vi'));
                          }
                        },
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
                              // Image.asset(AssetPath.avatar),
                              Consumer<UserModel>(
                                  builder: (context, user, child) {
                                    return Container(
                                      width: 80, // Đảm bảo kích thước của ảnh bằng nhau
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white, // Màu nền của hình tròn
                                      ),
                                      child: ClipOval(
                                        child: InkWell(
                                          onTap: (){
                                            Provider.of<UserModel>(context, listen: false).pickAndSetAvatar(context);
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
                                context.watch<UserModel>().userName.toString(),
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
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: LocaleKeys.userName.tr(),
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
                                decoration:  InputDecoration(
                                    hintText: LocaleKeys.passWord.tr(),
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
                                  LocaleKeys.register.tr(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blue.shade900),
                                ),
                                onTap: () {},
                              ),
                            ),
                            Container(
                              child: InkWell(
                                child: Text(
                                  LocaleKeys.forgot.tr(),
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
                                onTap: () async {
                                  checkLogin(context);Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
                                      await Future.delayed(const Duration(milliseconds: 200)); // Đợi trong 2 giây
                                      Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
                                  Navigator.of(context)
                                      .pushNamed(MainApp.routeName);
                                  setState(() {
                                    _islogin = true;
                                  });
                                },
                                child: Align(
                                    child:Text(
                                            LocaleKeys.signIn.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                         ),
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
      ),
    );
  }
  Future<void> checkLogin(BuildContext context) async {
    Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
    await Future.delayed(const Duration(milliseconds: 200)); // Đợi trong 2 giây
    Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
  }
}
