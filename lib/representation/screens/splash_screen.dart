import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = '/splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirectIntroScreen(); // doi tre 2s
  }

  void redirectIntroScreen() async{
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 5,
                child: Column(
                  children: [
                    Image.asset(
                      AssetPath.blockUp,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetPath.logoBank),
                        const SizedBox(
                          height: 20,
                        ),
                         Text(
                          LocaleKeys.intro1.tr(),
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                         Text(
                          LocaleKeys.intro2.tr(),
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
              flex: 4,
                child: Container(
                    width: double.infinity,
                    child: Image.asset(
                      AssetPath.blockDown,
                      fit: BoxFit.fill,
                    ))),
          ],
        ),
      ),
    );
  }
}
