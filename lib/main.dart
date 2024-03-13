
import 'package:flutter/material.dart';
import 'package:vrb_client/representation/screens/location_screen.dart';
import 'package:vrb_client/representation/screens/location_screen_test.dart';
import 'package:vrb_client/routes.dart';
import 'package:vrb_client/test.dart';

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
      // home:  const LocationScreenTest(),
      // home:  ExampleExpert(),
      home:  const LocationScreen(),
      // home:  MapScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
    );
  }
}