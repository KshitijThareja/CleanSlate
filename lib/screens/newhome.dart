import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
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
        child: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          
        ),
      ),
    );
  }
}
