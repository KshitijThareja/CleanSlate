import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/animations/animations.dart';
import 'package:hms/screens/my_homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
        title: const Text("HMS"),
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      labelText: "Room Number",
                      prefixIcon: Icon(Icons.numbers),
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
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      labelText: "Description",
                      prefixIcon: Icon(Icons.pending),
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
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Icon(Icons.arrow_drop_down),

                  DropdownButton(
                      items: _complaintType
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ))
                          .toList(),
                      onChanged: (selectedComplaintType) {
                        setState(() {
                          selectedType = selectedComplaintType;
                        });
                      },
                      value: selectedType,
                      isExpanded: false,
                      hint: const Text(
                        'Complaint Type',
                        style: TextStyle(color: Colors.black),
                      )),
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
                    child: const Text('Image should appear here'),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text('Camera'),
                      onPressed: () => getImage(source: ImageSource.camera),
                    ),
                  ),
                ),
            ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  CollectionReference collref =
                      FirebaseFirestore.instance.collection('clients');
                  collref.add(
                    {
                      'complaintType': selectedType,
                      'description': _descriptionTextController.text,
                      'roomno': _roomnoTextController.text,
                      'date': currentDate,
                      'email': email,
                      'status': "Pending",
                      'datetime': dtString,
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
             })
          ],
        ),
      ],
      ),
    ));
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
