import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/assets_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String routeName = '/splash_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
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
                    const Text(
                      "Kết nối thành công",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const Text(
                      "Đồng hành phát triển",
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
