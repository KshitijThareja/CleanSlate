import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
import 'package:hms/screens/login.dart';

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
        child: const Main(),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, 370),
                end: Alignment(430, 0),
                colors: [
                  Color.fromRGBO(216, 75, 40, 0.788),
                  Color.fromRGBO(255, 129, 13, 0.7900000214576721)
                ]),
          ),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 400,
                scale: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(250, 39, 59, 112),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                child: const Text("Login"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(250, 39, 59, 112),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                child: const Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
