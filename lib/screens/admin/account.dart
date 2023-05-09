import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = " ";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance.ref();

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  pickUploadProfilePic();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 80, bottom: 24),
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primary,
                  ),
                  child: Center(
                    child: profilePicLink == " "
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 80,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(profilePicLink),
                          ),
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
