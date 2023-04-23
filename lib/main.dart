import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'screens/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 4,
        navigateAfterSeconds: const SignUpScreen(),
        image: Image.asset('assets/splash_screen/logo.png'),
        photoSize: 100.0,
        gradientBackground: const LinearGradient(
            begin: Alignment(0, 370),
            end: Alignment(430, 0),
            colors: [
              Color.fromRGBO(216, 75, 40, 0.788),
              Color.fromRGBO(255, 129, 13, 0.7900000214576721)
            ]),
        
      ),
    );
  }
}


