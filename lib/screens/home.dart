import 'package:hms/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
import 'package:hms/animations/animations.dart';

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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(242, 51, 62, 1),
                  Color.fromRGBO(255, 129, 13, 0.7900000214576721)
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                child: Image.asset(
                  'assets/logo.png',
                  height: 300,
                  scale: 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Text(
                  'HMS',
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 46.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'Track, Prioritize and Solve issues Seamlessly!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 26.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(130, 50),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          foregroundColor:
                              const Color.fromARGB(248, 255, 255, 255),
                          backgroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40)),
                      onPressed: () {
                        Navigator.of(context)
                            .push(CustomPageRoute(child: const LoginScreen()));
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(130, 50),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          foregroundColor:
                              const Color.fromARGB(248, 255, 255, 255),
                          backgroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                      onPressed: () {
                        Navigator.of(context)
                            .push(CustomPageRoute(child: const SignupScreen()));
                      },
                      child: const Text("Signup"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
