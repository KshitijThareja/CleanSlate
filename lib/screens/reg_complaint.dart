import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hms/screens/reg_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegForm()));

            // Add your onPressed code here!
          },
          label: const Text('Register complaint'),
          icon: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 243, 81, 81),
        ),
      ),
      body: UserInformation(),
      // body: Column(
      //   children: [
      //     Card(
      //       // Define the shape of the card
      //       color: Color.fromARGB(255, 236, 236, 236),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(4),
      //       ),
      //       // Define how the card's content should be clipped
      //       clipBehavior: Clip.antiAliasWithSaveLayer,
      //       // Define the child widget of the card
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           // Add padding around the row widget
      //           Padding(
      //             padding: const EdgeInsets.all(15),
      //             child: Row(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 // Add an image widget to display an image
      //                 Image.asset(
      //                   "assets/relaxing-man.jpg",
      //                   height: 100,
      //                   width: 100,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 // Add some spacing between the image and the text
      //                 Container(width: 20),
      //                 // Add an expanded widget to take up the remaining horizontal space
      //                 Expanded(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       // Add some spacing between the top of the card and the title
      //                       Container(height: 5),
      //                       // Add a title widget
      //                       Text(
      //                         "Cards Title 1",
      //                         style: TextStyle(
      //                           fontSize: 24,
      //                           color: Colors.grey[700],
      //                         ),
      //                       ),
      //                       // Add some spacing between the title and the subtitle
      //                       Container(height: 5),
      //                       // Add a subtitle widget
      //                       Text(
      //                         'Sample text',
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.grey[700],
      //                         ),
      //                       ),
      //                       // Add some spacing between the subtitle and the text
      //                       Container(height: 10),
      //                       // Add a text widget to display some text
      //                       Text(
      //                         'Lorem ipsum doler set amet',
      //                         maxLines: 2,
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.grey[700],
      //                         ),
      //                         //
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      // body: Column(
      //   children: [
      //     Card(
      //       color: Color.fromARGB(255, 236, 236, 236),

      //       // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(8),
      //       ),
      //       // Set the clip behavior of the card
      //       clipBehavior: Clip.antiAliasWithSaveLayer,
      //       // Define the child widgets of the card
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
      //           Image.asset(
      //             'assets/relaxing-man.jpg',
      //             height: 160,
      //             width: double.infinity,
      //             fit: BoxFit.cover,
      //           ),
      //           // Add a container with padding that contains the card's title, text, and buttons
      //           Container(
      //             padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 // Display the card's title using a font size of 24 and a dark grey color
      //                 Text(
      //                   "Cards Title 2",
      //                   style: TextStyle(
      //                     fontSize: 24,
      //                     color: Colors.grey[800],
      //                   ),
      //                 ),
      //                 // Add a space between the title and the text
      //                 Container(height: 10),
      //                 // Display the card's text using a font size of 15 and a light grey color
      //                 Text(
      //                   'Sample text',
      //                   style: TextStyle(
      //                     fontSize: 15,
      //                     color: Colors.grey[700],
      //                   ),
      //                 ),
      //                 // Add a row with two buttons spaced apart and aligned to the right side of the card
      //                 Row(
      //                   children: <Widget>[
      //                     // Add a spacer to push the buttons to the right side of the card
      //                     const Spacer(),
      //                     // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
      //                     TextButton(
      //                       style: TextButton.styleFrom(
      //                         foregroundColor: Colors.transparent,
      //                       ),
      //                       child: const Text(
      //                         "SHARE",
      //                         style: TextStyle(color: Colors.red),
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                     // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
      //                     TextButton(
      //                       style: TextButton.styleFrom(
      //                         foregroundColor: Colors.transparent,
      //                       ),
      //                       child: const Text(
      //                         "EXPLORE",
      //                         style: TextStyle(color: Colors.red),
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //           // Add a small space between the card and the next widget
      //           Container(height: 5),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class UserInformation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('clients')
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
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
            return Card(
              elevation: 2.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1.0, color: Colors.black))),
                    child:
                        const Icon(Icons.pending_actions, color: Colors.black),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right,
                      color: Colors.black, size: 30.0),
                  title: Row(
                    children: [
                      const Text("Type: "),
                      Text(data['complaintType']),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Text("Date added: "),
                      Text(data['date']),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
