import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/provider/date_provider.dart';
import 'package:vrb_client/provider/dialog_provider.dart';
import 'package:vrb_client/provider/exchange_rate_provider.dart';
import 'package:vrb_client/provider/interest_provider.dart';
import 'package:vrb_client/provider/location_provider.dart';
import 'package:vrb_client/provider/selection_provider.dart';
import 'package:vrb_client/representation/demobutton.dart';
import 'package:vrb_client/representation/screens/home_screen.dart';
import 'package:vrb_client/representation/screens/login_screen.dart';
import 'package:vrb_client/representation/screens/main_app.dart';
import 'package:vrb_client/representation/screens/splash_screen.dart';
import 'package:vrb_client/routes.dart';
import 'package:vrb_client/test.dart';

import 'generated/codegen_loader.g.dart';
import 'models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => ExchangeRateProvider()),
      ChangeNotifierProvider(create: (_) => InterestProvider()),
      ChangeNotifierProvider(create: (_) => DateProvider()),
      ChangeNotifierProvider(create: (_) => SelectionProvider()),
      ChangeNotifierProvider(create: (_) => DialogProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),

    ],
    child: EasyLocalization(
      supportedLocales: [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: "VRB",
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(),
      home: const SplashScreen(),
      // home: const SearchBarApp(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
    );
  }
}
