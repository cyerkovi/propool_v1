import 'package:flutter/material.dart';
import 'package:propool_v1/screens/sign_in_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SignInScreen(),
      // home: LoadingScreen(),
    );
  }
}
