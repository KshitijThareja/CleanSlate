import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/login.dart';
import 'package:hms/screens/admin/account_edit.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hms/animations/animations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/screens/forgot.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AccountScreen());
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Color primary = const Color(0xffeef444c);
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where(
        'email',
        isEqualTo: FirebaseAuth.instance.currentUser?.email,
      )
      // .orderBy('datetime', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      (data['image'] == null)
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                              child: Container(
                                height: 120,
                                width: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primary,
                                  shape: BoxShape.circle,
                                  // borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                            )
                          :
                          // : Image.network(data['image']),
                          Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Center(
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(data['image']),
                                  radius: 80,
                                ),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                // maximumSize: Size.fromWidth(45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: Colors.black),
                              ),
                              label: const Text(
                                "Change",
                                style: TextStyle(color: Colors.black),
                              ),
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 24.0,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(CustomPageRoute(
                                    child: const EditAccountScreen()));
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor:
                                const Color.fromARGB(255, 249, 246, 245),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 243, 81, 81),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  "Username:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data['username'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor:
                                const Color.fromARGB(255, 249, 246, 245),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.question_mark,
                                color: Color.fromARGB(255, 243, 81, 81),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  "User Type:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text(
                                data['userType'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor:
                                const Color.fromARGB(255, 249, 246, 245),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.mail,
                                color: Color.fromARGB(255, 243, 81, 81),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Text(
                                  "Email:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data['email'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(65, 20, 65, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      // minimumSize: const Size.fromWidth(70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: const Color.fromARGB(
                          255, 243, 81, 81), // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    child: const Text("Logout"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        print("Signed Out");
                        Navigator.of(context)
                            .push(CustomPageRoute(child: const LoginScreen()));
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(65, 20, 65, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      // minimumSize: const Size.fromWidth(70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: const Color.fromARGB(
                          255, 243, 81, 81), // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    child: const Text("Reset Password"),
                    onPressed: () {
                      Navigator.of(context)
                          .push(CustomPageRoute(child: const ForgotScreen()));
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
