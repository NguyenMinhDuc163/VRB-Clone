
import 'package:flutter/material.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/location_screen.dart';
import 'package:vrb_client/representation/screens/main_app.dart';
import 'package:vrb_client/routes.dart';

void main()  {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VRB",
      theme: ThemeData(

      ),
      // home:  const HomeScreen(),
      // home:  const MainApp(),
      home:  const LocationScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
    );
  }
}