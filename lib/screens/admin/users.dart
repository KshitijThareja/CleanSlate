import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Users extends StatelessWidget {
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
                      child: Icon(Icons.person_4),
                    ),
                    Text("Students"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.admin_panel_settings),
                    ),
                    Text("Wardens"),
                  ],
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          title: const Text("USERS"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 208, 8, 70),
        ),
        body: TabBarView(children: [
          StudentUserInformation(),
          WardenUserInformation(),
        ]),
      ),
    );
  }
}

class StudentUserInformation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _StudentUserInformationState createState() => _StudentUserInformationState();
}

class _StudentUserInformationState extends State<StudentUserInformation> {
  var today = DateTime.now();
  var dateFormat = DateFormat('dd-MM-yyyy');
  var timeFormat = DateFormat('kk:mm:ss');
  late String currentDate = dateFormat.format(today);
  late String currentTime = timeFormat.format(today);
  late String dtString = today.toString();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where(
        'userType',
        isEqualTo: 'Student',
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
                    child: const Icon(Icons.person_4, color: Colors.black),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: const Text("User Info"),
                                  content: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                foregroundImage:
                                                    NetworkImage(data['image']),
                                                radius: 80,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Username: "),
                                              Text(data['username']),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text("Email"),
                                                Text(data['email']),
                                              ],
                                            ),
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
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.keyboard_arrow_right)),
                  title: Row(
                    children: [
                      const Text("Name: "),
                      Text(data['username']),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Text("Role: "),
                      Text(data['userType']),
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

class WardenUserInformation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WardenUserInformationState createState() => _WardenUserInformationState();
}

class _WardenUserInformationState extends State<WardenUserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where(
        'userType',
        isEqualTo: 'Warden',
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
                    child: const Icon(Icons.admin_panel_settings,
                        color: Colors.black),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: const Text("User Info"),
                                  content: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Center(
                                              child: CircleAvatar(
                                                foregroundImage:
                                                    NetworkImage(data['image']),
                                                radius: 80,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("Name: "),
                                              Text(data['username']),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text("Email: "),
                                                Text(data['email']),
                                              ],
                                            ),
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
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.keyboard_arrow_right)),
                  title: Row(
                    children: [
                      const Text("Name: "),
                      Text(data['username']),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Text("Role: "),
                      Text(data['userType']),
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
