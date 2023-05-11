import 'package:flutter/material.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:hms/screens/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/home.dart';
import 'package:hms/animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/screens/admin/my_homepage.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen();

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
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  // final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  // final TextEditingController _usernameTextController = TextEditingController();
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
                height: 450,
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
                                  'RESET PASSWORD',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                          ),
                                          labelText: "Email",
                                          prefixIcon: Icon(Icons.mail),
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                      controller: _emailTextController),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(48.0),
                                child: firebaseUIButton(
                                    context, "Reset Password", () {
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: _emailTextController.text)
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                }),
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
//   void route() {
//     User? user = FirebaseAuth.instance.currentUser;
//     var kk = FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.email)
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         if (documentSnapshot.get('userType') == "Warden") {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AdminHomeScreen(),
//             ),
//           );
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomeScreen(),
//             ),
//           );
//         }
//       } else {
//         print('Document does not exist on the database');
//       }
//     });
//   }
// }
