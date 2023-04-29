import 'package:flutter/material.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:hms/screens/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(242, 51, 62, 1),
                  Color.fromRGBO(255, 129, 13, 0.7900000214576721)
                ]),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                'assets/logo.png',
                height: 330,
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      controller: _usernameTextController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: firebaseUIButton(context, "Sign up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
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
                            color: Colors.black, fontWeight: FontWeight.bold),
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
}
