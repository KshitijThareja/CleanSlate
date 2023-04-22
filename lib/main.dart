import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
// import 'screens/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: SignUpScreen(),
      ),
    );
  }
}


