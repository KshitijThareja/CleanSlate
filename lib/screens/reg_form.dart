// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/animations/animations.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RegForm());
}

class RegForm extends StatefulWidget {
  @override
  State<RegForm> createState() => RegFormState();
}

class RegFormState extends State<RegForm> {
  File? imageFile;
  var imageUrl;
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  final TextEditingController _roomnoTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  String? email = FirebaseAuth.instance.currentUser?.email;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  var selectedType;
  var today = DateTime.now();
  var dateFormat = DateFormat('dd-MM-yyyy');
  late String currentDate = dateFormat.format(today);
  late String dtString = today.toString();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> _complaintType = <String>[
    'Electricity',
    'Plumbing',
    'Carpentry',
    'Cleaning',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Registration"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 243, 81, 81),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(child: HomeScreen()));
            },
          ),
        ),
        body: Form(
          key: formKey,
          // autovalidate: true,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: SizedBox(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 243, 81, 81),
                        )),
                        contentPadding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        labelText: "Room Number",
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 243, 81, 81)),
                        prefixIcon: Icon(Icons.numbers),
                        prefixIconColor: Color.fromARGB(255, 243, 81, 81),
                        hintStyle: TextStyle(color: Colors.grey)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Room number is Required';
                      }
                      return null;
                    },
                    controller: _roomnoTextController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 243, 81, 81),
                        )),
                        contentPadding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        labelText: "Description",
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 243, 81, 81)),
                        prefixIcon: Icon(Icons.pending),
                        prefixIconColor: Color.fromARGB(255, 243, 81, 81),
                        hintStyle: TextStyle(color: Colors.grey)),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Description is Required';
                      }
                      return null;
                    },
                    controller: _descriptionTextController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.arrow_drop_down),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        // color: Colors.orange[900],
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: DropdownButton(
                          items: _complaintType
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (selectedComplaintType) {
                            setState(() {
                              selectedType = selectedComplaintType;
                            });
                          },
                          icon: const Padding(
                            padding: EdgeInsets.only(
                              left: 1,
                              right: 8,
                            ),
                            child: Icon(Icons.arrow_circle_down_sharp),
                          ),
                          value: selectedType,
                          isExpanded: false,
                          underline: Container(),
                          hint: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Complaint Type',
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (imageFile != null)
                    Container(
                      width: 640,
                      height: 280,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        image: DecorationImage(
                          image: FileImage(imageFile!),
                        ),
                      ),
                    ),
                  if (imageFile == null)
                    Container(
                      width: 640,
                      height: 280,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                      ),
                      child:
                          const Text('Click the camera button to add images'),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 243, 81, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Camera'),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 640,
                            maxWidth: 480,
                            imageQuality: 10,
                          );
                          if (file?.path != null) {
                            setState(() {
                              imageFile = File(file!.path);
                            });
                          }
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');
                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);
                          try {
                            //Store the file
                            await referenceImageToUpload
                                .putFile(File(file!.path));
                            //Success: get the download URL
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            print('Image URL: ${imageUrl.toString()}');
                            //Success: add the image to the list
                            // setState(() {
                          } catch (error) {
                            //Some error occurred
                          }
                        },
                        // getImage(source: ImageSource.camera),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 243, 81, 81),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text('Submit'),
                          onPressed: () {
                            CollectionReference collref = FirebaseFirestore
                                .instance
                                .collection('clients');
                            collref.add(
                              {
                                'complaintType': selectedType,
                                'description': _descriptionTextController.text,
                                'roomno': _roomnoTextController.text,
                                'date': currentDate,
                                'email': email,
                                'status': "Pending",
                                'datetime': dtString,
                                'image': imageUrl,
                              },
                            );
                            Navigator.pop(context);
                            // var collection =
                            //     FirebaseFirestore.instance.collection('clients');
                            // collection
                            //     .doc(uid) // <-- Document ID
                            //     .set(
                            //       {
                            //         'complaintType': selectedType,
                            //         'description': _descriptionTextController.text,
                            //         'roomno': _roomnoTextController.text,
                            //         'date': currentDate,
                            //         'email': email,
                            //       },
                            //     ) // <-- Your data
                            //     .then((_) => print('Added'))
                            //     .catchError((error) => print('Add failed: $error'));
                          }),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  // void getImage({required ImageSource source}) async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? file = await imagePicker.pickImage(source: source);
  //   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDirImages = referenceRoot.child('images');
  //   Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
  //   try {
  //     //Store the file
  //     await referenceImageToUpload.putFile(File(file!.path));
  //     //Success: get the download URL
  //     var imageUrl = await referenceImageToUpload.getDownloadURL();
  //     // print(imageUrl);
  //   } catch (error) {
  //     //Some error occurred
  //   }
  //   if (file?.path != null) {
  //     setState(() {
  //       imageFile = File(file!.path);
  //     });
  //   }
  // }
}
