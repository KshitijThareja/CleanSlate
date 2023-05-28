// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:hms/screens/reg_form.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 250, 250, 250),
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.pending_actions),
                    ),
                    Text("Pending"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.check_box),
                    ),
                    Text("Completed"),
                  ],
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          title: const Text("HOME"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 208, 8, 70),
        ),
        body: TabBarView(children: [
          PendingUserInformation(),
          CompleteUserInformation(),
        ]),
      ),
    );
  }
}

class PendingUserInformation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PendingUserInformationState createState() => _PendingUserInformationState();
}

class _PendingUserInformationState extends State<PendingUserInformation> {
  var today = DateTime.now();
  var dateFormat = DateFormat('dd-MM-yyyy');
  var timeFormat = DateFormat('kk:mm:ss');
  late String currentDate = dateFormat.format(today);
  late String currentTime = timeFormat.format(today);
  late String dtString = today.toString();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('clients')
      .where(
        'status',
        isEqualTo: 'Pending',
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
            return Card(
              elevation: 2.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: SizedBox(
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
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: const Text("Complaint Info"),
                                  content: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Image.network(
                                              data['image'],
                                              height: 200,
                                              width: 200,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Date added: "),
                                              Text(data['date']),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text("Type: "),
                                                Text(data['complaintType']),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Room number: "),
                                              Text(data['roomno']),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text("Description: "),
                                                Text(data['description']),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Status: "),
                                              Text(data['status']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <CupertinoDialogAction>[
                                    CupertinoDialogAction(
                                      /// This parameter indicates this action is the default,
                                      /// and turns the action's text to bold text.
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Back'),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        var collection = FirebaseFirestore
                                            .instance
                                            .collection('clients');
                                        collection
                                            .doc(document
                                                .id) // <-- Doc ID where data should be updated.
                                            .update(
                                              {
                                                'status': 'Completed',
                                                'cdate': currentDate,
                                                'ctime': currentTime,
                                              },
                                            ) // <-- Your data
                                            .then((_) => print('Added'))
                                            .catchError((error) =>
                                                print('Add failed: $error'));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Completed'),
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.keyboard_arrow_right)),
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

class CompleteUserInformation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CompleteUserInformationState createState() =>
      _CompleteUserInformationState();
}

class _CompleteUserInformationState extends State<CompleteUserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('clients')
      .where(
        'status',
        isEqualTo: 'Completed',
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
            return Card(
              elevation: 2.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: SizedBox(
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1.0, color: Colors.black))),
                    child: const Icon(Icons.check_box, color: Colors.black),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: const Text("Complaint Info"),
                                  content: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Image.network(
                                              data['image'],
                                              height: 200,
                                              width: 200,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Date added: "),
                                              Text(data['date']),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text("Type: "),
                                                Text(data['complaintType']),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Room number: "),
                                              Text(data['roomno']),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text("Description: "),
                                                Text(data['description']),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Status: "),
                                              Text(data['status']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <CupertinoDialogAction>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Back'),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        var collection = FirebaseFirestore
                                            .instance
                                            .collection('clients');
                                        collection
                                            .doc(document
                                                .id) // <-- Doc ID where data should be updated.
                                            .update(
                                              {
                                                'status': 'Pending',
                                              },
                                            ) // <-- Your data
                                            .then((_) => print('Added'))
                                            .catchError((error) =>
                                                print('Add failed: $error'));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Pending'),
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.keyboard_arrow_right)),
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
