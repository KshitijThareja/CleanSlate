import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:hms/screens/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/home.dart';
import 'package:hms/animations/animations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();

  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).push(CustomPageRoute(child: IntroScreen()));
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(242, 51, 62, 1),
                    Color.fromRGBO(255, 129, 13, 0.7900000214576721),
                  ]),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 400,
                    scale: 2.5,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 460,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: TextField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                              ),
                                              labelText: "Email",
                                              prefixIcon: Icon(Icons.mail),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          controller: _emailTextController),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: TextField(
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              left: 10.0,
                                              right: 10.0,
                                            ),
                                            labelText: "Password",
                                            prefixIcon: Icon(Icons.lock),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          controller: _passwordTextController),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 0, 10),
                                    child: firebaseUIButton(context, "Sign In",
                                        () {
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _emailTextController.text,
                                              password:
                                                  _passwordTextController.text)
                                          .then((value) {
                                        Navigator.of(context).push(
                                            CustomPageRoute(
                                                child: HomeScreen()));
                                      }).onError((error, stackTrace) {
                                        print("Error ${error.toString()}");
                                      });
                                    }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have account?",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                            CustomPageRoute(
                                                child: const SignupScreen()));
                                          },
                                          child: const Text(
                                            " Sign Up",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
