import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrb_client/representation/screens/contact_helper.dart';
import 'package:vrb_client/representation/screens/exchange_rate_screen.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/interest_screen.dart';
import 'package:vrb_client/representation/screens/location_screen.dart';
import 'package:vrb_client/representation/screens/login_screen.dart';
import 'package:vrb_client/representation/screens/main_app.dart';
import 'package:vrb_client/representation/screens/payment_screen.dart';
import 'package:vrb_client/representation/screens/qr_code_screen.dart';
import 'package:vrb_client/representation/screens/search_location_screen.dart';
import 'package:vrb_client/representation/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  PaymentScreen.routeName: (context) => const PaymentScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),

  ExchangeRateScreen.routeName: (context) => const ExchangeRateScreen(),
  InterestScreen.routeName: (context) => const InterestScreen(),
  ContactHelper.routeName: (context) => const ContactHelper(),
  QRCodeScreen.routeName: (context) => const QRCodeScreen(),
  LocationScreen.routeName: (context) => const LocationScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginScreen.routeName: (context) => const LoginScreen(),


  // noi tong hop ca routes
};

// MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {}
MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SearchLocationScreen.routeName:
      if (settings.arguments != null && settings.arguments is Map<String, dynamic>) {
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        if (arguments.containsKey('searchTerms') && arguments.containsKey('titleField')) {
          List<String> searchTerms = arguments['searchTerms'] as List<String>;
          String titleField = arguments['titleField'] as String;
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => SearchLocationScreen(searchTerms: searchTerms, titleField: titleField),
          );
        }
      }
      return null; // Trả về null nếu không có tham số được truyền hoặc kiểu không phù hợp
    default:
      return null;
  }
}


