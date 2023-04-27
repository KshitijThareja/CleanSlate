import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:hms/screens/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, 370),
                end: Alignment(430, 0),
                colors: [
                  Color.fromRGBO(216, 75, 40, 0.788),
                  Color.fromRGBO(255, 129, 13, 0.7900000214576721)
                ]),
          ),
          child: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 300,
                scale: 3,
              )
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
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
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: TextField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                            ),
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail),
                            hintStyle: TextStyle(color: Colors.grey)),
                        controller: _emailTextController),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: TextField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: TextStyle(color: Colors.grey),
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
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: firebaseUIButton(context, "Sign In", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?",
                        style: TextStyle(color: Colors.black)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
