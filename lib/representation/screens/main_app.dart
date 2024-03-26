import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/payment_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  static String routeName = '/main_app';
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: HomeScreen(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            child: Image.asset(AssetPath.icoHome),
            label: LocaleKeys.home.tr(),
          ),
          CurvedNavigationBarItem(
            child: Image.asset(AssetPath.icoGift2),
            label: LocaleKeys.gift.tr(),
          ),
          CurvedNavigationBarItem(
            child: Image.asset(AssetPath.icoQR),
            label: 'QR',
          ),
          CurvedNavigationBarItem(
            child: Image.asset(AssetPath.icoNotification),
            label: LocaleKeys.notiHome.tr(),
          ),
          CurvedNavigationBarItem(
            child: Image.asset(AssetPath.icoSetting),
            label: LocaleKeys.setting.tr(),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.red.shade200,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
