import 'package:firebase_auth/firebase_auth.dart';
import 'package:hms/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File _image;

//   @override
//   Widget build(BuildContext context) {

//     Future getImage() async {
//       var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//       setState(() {
//         _image = image;
//           print('Image Path $_image');
//       });
//     }

//     Future uploadPic(BuildContext context) async{
//       String fileName = basename(_image.path);
//        StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
//        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//        StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
//        setState(() {
//           print("Profile Picture uploaded");
//           Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//        });
//     }

//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               icon: Icon(FontAwesomeIcons.arrowLeft),
//               onPressed: () {
//                 Navigator.pop(context);
//               }),
//           title: Text('Edit Profile'),
//         ),
//         body: Builder(
//         builder: (context) =>  Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                       radius: 100,
//                       backgroundColor: Color(0xff476cfb),
//                       child: ClipOval(
//                         child: new SizedBox(
//                           width: 180.0,
//                           height: 180.0,
//                           child: (_image!=null)?Image.file(
//                             _image,
//                             fit: BoxFit.fill,
//                           ):Image.network(
//                             "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 60.0),
//                     child: IconButton(
//                       icon: Icon(
//                         FontAwesomeIcons.camera,
//                         size: 30.0,
//                       ),
//                       onPressed: () {
//                         getImage();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Username',
//                                 style: TextStyle(
//                                     color: Colors.blueGrey, fontSize: 18.0)),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Michelle James',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       child: Icon(
//                         FontAwesomeIcons.pen,
//                         color: Color(0xff476cfb),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Birthday',
//                                 style: TextStyle(
//                                     color: Colors.blueGrey, fontSize: 18.0)),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('1st April, 2000',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       child: Icon(
//                         FontAwesomeIcons.pen,
//                         color: Color(0xff476cfb),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Location',
//                                 style: TextStyle(
//                                     color: Colors.blueGrey, fontSize: 18.0)),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Paris, France',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       child: Icon(
//                         FontAwesomeIcons.pen,
//                         color: Color(0xff476cfb),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Text('Email',
//                         style:
//                             TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
//                     SizedBox(width: 20.0),
//                     Text('michelle123@gmail.com',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   RaisedButton(
//                     color: Color(0xff476cfb),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     elevation: 4.0,
//                     splashColor: Colors.blueGrey,
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.white, fontSize: 16.0),
//                     ),
//                   ),
//                   RaisedButton(
//                     color: Color(0xff476cfb),
//                     onPressed: () {
//                      uploadPic(context);
//                     },
                                     
//                     elevation: 4.0,
//                     splashColor: Colors.blueGrey,
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(color: Colors.white, fontSize: 16.0),
//                     ),
//                   ),
              
//                 ],
//               )
//             ],
//           ),
//         ),
//         ),
//         );
//   }
// }