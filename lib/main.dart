import 'package:flutter/material.dart';
import 'package:hms/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hms/screens/signup.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: SignupScreen(),
      ),
    );
  }
}
