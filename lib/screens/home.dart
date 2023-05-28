import 'package:flutter/material.dart';
import 'package:hms/screens/login.dart';
import 'package:hms/screens/signup.dart';
import 'package:hms/animations/animations.dart';

class IntroScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-1.1759113073349, 2.255218075224082e-16),
              end: Alignment(7.200380253914021e-17, 1.1759113073349),
              colors: [
                Color.fromARGB(255, 208, 8, 70),
                Color.fromARGB(255, 235, 64, 52),
              ]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 70,
              child: Image.asset(
                'assets/logo.png',
                scale: 2,
                height: 400,
                alignment: Alignment.center,
              ),
            ),
            const Positioned(
              top: 470,
              left: 29,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "HMS",
                  style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Manrope',
                      color: Colors.white),
                ),
              ),
            ),
            const Positioned(
              top: 550,
              left: 20,
              child: Text(
                '"Track, Prioritize and Solve issues seamlessly!"',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Manrope',
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: 600,
              left: 18,
              right: 18,
              child: SizedBox(
                // width: screenWidth * 1,
                width: 360,
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 50),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      foregroundColor: const Color.fromARGB(248, 255, 255, 255),
                      backgroundColor: const Color.fromARGB(255, 208, 8, 70),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 160, 53, 60)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40)),
                  onPressed: () {
                    Navigator.of(context)
                        .push(CustomPageRoute(child: const LoginScreen()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Manrope',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 690,
              left: 18,
              right: 18,
              child: Center(
              child: SizedBox(
                // width: screenWidth * 1,
                width: 360,
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 50),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      foregroundColor: const Color.fromARGB(248, 255, 255, 255),
                      backgroundColor: const Color.fromARGB(255, 39, 58, 122),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 39, 58, 122)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40)),
                  onPressed: () {
                    Navigator.of(context)
                        .push(CustomPageRoute(child: const SignupScreen()));
                  },
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Manrope',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
