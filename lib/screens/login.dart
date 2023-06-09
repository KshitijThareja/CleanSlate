// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hms/screens/signup.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:hms/screens/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/home.dart';
import 'package:hms/animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/screens/admin/my_homepage.dart';
import 'package:hms/screens/forgot.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool _obscureText = true;

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
                  begin: Alignment(-1.1759113073349, 2.255218075224082e-16),
                  end: Alignment(7.200380253914021e-17, 1.1759113073349),
                  colors: [
                    Color.fromARGB(255, 208, 8, 70),
                    Color.fromARGB(255, 235, 64, 52),
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
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(255, 160, 53, 60),)),
                                              contentPadding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                              ),
                                              floatingLabelStyle:
                                              TextStyle(color: Color.fromARGB(255, 160, 53, 60)),
                                              labelText: "Email",
                                              prefixIcon: Icon(Icons.mail),
                                              prefixIconColor: Color.fromARGB(255, 208, 8, 70),
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
                                          obscureText: _obscureText,
                                          decoration: InputDecoration(
                                            focusedBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(255, 160, 53, 60),)),
                                            contentPadding:
                                                const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10.0,
                                            ),
                                            floatingLabelStyle:
                                            const TextStyle(color: Color.fromARGB(255, 160, 53, 60)),
                                            labelText: "Password",
                                            prefixIcon: const Icon(Icons.lock),
                                            prefixIconColor: const Color.fromARGB(255, 208, 8, 70),
                                            // ignore: sort_child_properties_last
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(_obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          controller: _passwordTextController),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CustomPageRoute(
                                                    child:
                                                        const ForgotScreen()));
                                          },
                                          child: const Text(
                                            "Forgot Password?",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // const Padding(
                                  //   padding: EdgeInsets.fromLTRB(20, 40, 20, 0),

                                  //   child:
                                  //   Text(
                                  //     "Forgot Password?",
                                  //     style: TextStyle(color: Colors.grey),
                                  //   ),

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
                                        route();
                                      }).onError((error, stackTrace) {
                                        print("Error ${error.toString()}");
                                      });
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('users');
                                      collection
                                          .doc(_emailTextController
                                              .text) // <-- Document ID
                                          .update(
                                            {
                                              'password':
                                                  _passwordTextController.text,
                                            },
                                          ) // <-- Your data
                                          .then((_) => print('Updated'))
                                          .catchError((error) =>
                                              print('Update failed: $error'));
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
                                                    child:
                                                        const SignupScreen()));
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

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('userType') == "Warden") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminHomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
