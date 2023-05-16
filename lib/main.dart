import 'package:flutter/material.dart';
import 'package:hms/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  initializeAsyncOperations();
}

Future<void> initializeAsyncOperations() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: IntroScreen(),
          image: Image.asset('assets/logo.png'),
          photoSize: 100.0,
          gradientBackground: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(242, 51, 62, 1),
                Color.fromRGBO(255, 129, 13, 0.7900000214576721),
              ]),
        ));
  }
}
