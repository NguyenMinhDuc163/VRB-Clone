import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/core/themes/app_colors.dart';
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


  @override
  void initState() {
    // TODO: implement initState
    LoginProvider login = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
    login.auth = LocalAuthentication();
    login.auth.isDeviceSupported().then((isSupported) {
      setState(() {
        login.supportState = isSupported;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _authenticate() async {
    DialogProvider dialog = Provider.of<DialogProvider>(context, listen: false);

    try {
      bool authenticated = await Provider.of<LoginProvider>(context, listen: false).auth.authenticate(
        localizedReason: 'Authenticate for testing',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        dialog.showLoadingDialog(context);
        await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
        dialog.hideLoadingDialog(context);
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
        await Provider.of<LoginProvider>(context, listen: false).auth.getAvailableBiometrics();
    print(availableBiometrics);
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Positioned(bottom: 0, child: BottomBarWidget()),
            Positioned.fill( // xu ly co dinh khi scrol
              top: 50, // Đặt giá trị top cho Row
              left: 0, // Đặt giá trị left cho Row
              right: 0, // Đặt giá trị right cho Row
              child: Padding(
                padding: EdgeInsets.only(bottom: keyboardHeight + 30), // padding động theo bàn phím
                child: SingleChildScrollView(
                  child: Consumer<LoginProvider>(builder: (context, login, _){
                    return Column(
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
                                login.setIsPressed(!login.isPressed);
                              },
                              child: Container(
                                  width: 65,
                                  height: 42,
                                  padding: EdgeInsets.all(8),
                                  child: !login.isPressed
                                      ? _buildIconLanguage(AssetPath.icoVN, "VN")
                                      : _buildIconLanguage(
                                      AssetPath.icoAmerica, "EN")),
                            ),
                          ],
                        ),
                        (login.islogin)
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
                                context.watch<UserModel>().userName.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              TextFieldKeyBoardWidget(
                                title: LocaleKeys.userName.tr(),
                                icon: FontAwesomeIcons.user,
                                onSubmitted: (String value) {
                                  print(value);
                                },
                              ),
                            ],
                          ),
                        )
                            : Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: kMediumPadding * 4,
                              ),
                              //TODO Textfield
                              TextFieldKeyBoardWidget(
                                title: LocaleKeys.userName.tr(),
                                icon: FontAwesomeIcons.user,
                                onSubmitted: (String value) {
                                  print(value);
                                },
                              ),
                              TextFieldKeyBoardWidget(
                                title: LocaleKeys.passWord.tr(),
                                icon: Icons.visibility,
                                onSubmitted: (String value) {
                                  print(value);
                                },
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: kDefaultPadding,
                        // ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                                      onTap: () {
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    child: Text(
                                      LocaleKeys.forgot.tr(),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.blue.shade900),
                                    ),
                                    onTap: () {
                                    },
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
                                        gradient: AppColor.gradient,
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
                                        login.setIslogin(true);
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
                                    login.setIslogin(false);
                                  },
                                  child: Text(
                                    LocaleKeys.signInAnother.tr(),
                                    style: TextStyle(
                                        color: Colors.blue.shade900, fontSize: 14),
                                  ),
                                ),
                              ),
                              // test scroll keyboard
                            ],
                          ),
                        ),
                      ],
                    );
                  },),
                ),
              ),
            ),
            const Positioned(bottom: 0, child: BottomBarWidget()),
          ],
        ),
      ),
    );
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
