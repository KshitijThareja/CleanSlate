import 'package:flutter/material.dart';
import 'package:hms/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Sample Code'),
//         ),
//         bottomNavigationBar: NavigationBarTheme(
//             data: NavigationBarThemeData(
//               indicatorColor: Color.fromARGB(255, 235, 94, 12),
//               labelTextStyle: MaterialStateProperty.all(
//                 TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               ),
//             ),
//             child: NavigationBar(
//               height: 60,
//               destinations: [
//                 NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//                 NavigationDestination(
//                     icon: Icon(Icons.person), label: 'Account'),
//               ],
//             )));
//   }
// }
