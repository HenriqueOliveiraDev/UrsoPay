
import 'package:app_pandapay/view/screen/add.dart';
import 'package:app_pandapay/view/screen/home.dart';
import 'package:app_pandapay/view/screen/introduction.dart';
import 'package:app_pandapay/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 100,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
            size: 120,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
