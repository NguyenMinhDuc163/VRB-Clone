import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/login_screen.dart';
import 'package:vrb_client/representation/screens/main_app.dart';
import 'package:vrb_client/representation/screens/splash_screen.dart';
import 'package:vrb_client/routes.dart';

import 'models/user_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VRB",
      theme: ThemeData(),
      // home:  const LocationScreen(),
      // home:  const HomeScreen(),
      home: const LoginScreen(),
      // home:  const MainApp(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
    );
  }
}
