import 'package:flutter/material.dart';

// import 'package:hms/Animation/FadeAnimation.dart';
// void main() => runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignUpScreen(),
//     )
// );
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
        // end: Alignment(430, 0),
        colors: [
          Color.fromRGBO(216, 75, 40, 0.788),
          Color.fromRGBO(255, 129, 13, 0.7900000214576721)
        ]),
    ),
        )
    );

  }
}
