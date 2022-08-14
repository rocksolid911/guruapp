import 'package:flutter/material.dart';
import 'package:guruapp/Screen/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(fontFamily: 'AdventPro'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}