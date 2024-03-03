import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/payment_screen.dart';

final Map<String, WidgetBuilder> routes = {
  PaymentScreen.routeName: (context) => const PaymentScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),

  // noi tong hop ca routes
};
MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {}