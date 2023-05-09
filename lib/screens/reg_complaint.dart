import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hms/screens/reg_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("HOME"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 81, 81),
      ),
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
