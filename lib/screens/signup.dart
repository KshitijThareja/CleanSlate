// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:hms/screens/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/home.dart';
import 'package:hms/animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/screens/admin/my_homepage.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen();

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

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var selectedType;
  final List<String> _userType = <String>[
    'Warden',
    'Student',
  ];

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
                                  'SIGNUP',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                                        labelText: "Username",
                                        prefixIcon: Icon(Icons.person),
                                        prefixIconColor: Color.fromARGB(255, 208, 8, 70),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                      controller: _usernameTextController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(255, 160, 53, 60),)),
                                          contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                          ),
                                          labelText: "Email",
                                          floatingLabelStyle:
                                          TextStyle(color: Color.fromARGB(255, 160, 53, 60)),
                                          prefixIcon: Icon(Icons.mail),
                                          prefixIconColor: Color.fromARGB(255, 208, 8, 70),
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      controller: _emailTextController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                  child: TextField(
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(255, 160, 53, 60),)),
                                        contentPadding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                        ),
                                        labelText: "Password",
                                        floatingLabelStyle:
                                        const TextStyle(color: Color.fromARGB(255, 160, 53, 60)),
                                        prefixIcon: const Icon(Icons.lock),
                                        prefixIconColor: const Color.fromARGB(255, 208, 8, 70),
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
                                        hintStyle:
                                            const TextStyle(color: Colors.black),
                                      ),
                                      controller: _passwordTextController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(Icons.arrow_drop_down),
                                    Container(
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: DropdownButton(
                                          items: _userType
                                              .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 8, 0, 8),
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (selectedUserType) {
                                            setState(() {
                                              selectedType = selectedUserType;
                                            });
                                          },
                                          icon: const Padding(
                                            padding: EdgeInsets.only(
                                              left: 1,
                                              right: 8,
                                            ),
                                            child: Icon(
                                                Icons.arrow_circle_down_sharp),
                                          ),
                                          iconEnabledColor: Colors.black,
                                          underline: Container(),
                                          value: selectedType,
                                          isExpanded: false,
                                          hint: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'User Type',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: firebaseUIButton(context, "Sign up", () {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text)
                                      .then((value) {
                                    print("Created New Account");
                                    route();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }).onError((error, stackTrace) {
                                    print("Error ${error.toString()}");
                                  });

                                  var collection = FirebaseFirestore.instance
                                      .collection('users');
                                  collection
                                      .doc(_emailTextController
                                          .text) // <-- Document ID
                                      .set(
                                        {
                                          'email': _emailTextController.text,
                                          'password':
                                              _passwordTextController.text,
                                          'username':
                                              _usernameTextController.text,
                                          'userType': selectedType,
                                        },
                                      ) // <-- Your data
                                      .then((_) => print('Added'))
                                      .catchError((error) =>
                                          print('Add failed: $error'));
                                }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account?",
                                      style: TextStyle(color: Colors.black)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
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
