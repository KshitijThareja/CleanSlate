import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:hms/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hms/animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  var imageUrl;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = " ";

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Edit Account"), backgroundColor: primary),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (file?.path != null) {
                    setState(() {
                      imageFile = File(file!.path);
                    });
                  }
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('profile');
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                  try {
                    //Store the file
                    await referenceImageToUpload.putFile(File(file!.path));
                    //Success: get the download URL
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  } catch (error) {
                    //Some error occurred
                  }
                  var collection =
                      FirebaseFirestore.instance.collection('users');
                  collection
                      .doc(FirebaseAuth.instance.currentUser!
                          .email) // <-- Doc ID where data should be updated.
                      .update(
                        {
                          'image': imageUrl,
                        },
                      ) // <-- Your data
                      .then((_) => print('Added'))
                      .catchError((error) => print('Add failed: $error'));
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      if (imageFile != null)
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(
                            child: CircleAvatar(
                              foregroundImage: FileImage(imageFile!),
                              radius: 80,
                            ),
                          ),
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      //   child: Container(
                      //     height: 120,
                      //     width: 120,
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: primary,
                      //         image: DecorationImage(
                      //             image: FileImage(imageFile!),
                      //             fit: BoxFit.fill)),
                      //   ),
                      // ),
                      if (imageFile == null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                          child: Container(
                            height: 120,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 40, 80, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            // minimumSize: const Size.fromWidth(70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Colors.black,
                            foregroundColor:
                                Colors.white, // foreground (text) color
                          ),
                          child: const Text("Submit"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
