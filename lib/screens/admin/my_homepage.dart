import 'package:flutter/material.dart';
import 'package:hms/screens/admin/custom_animated_bottom_bar.dart';
import 'package:hms/screens/admin/reg_complaint.dart';
import 'package:hms/screens/admin/account.dart';
import 'package:hms/screens/admin/users.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;
  final _inactiveColor = const Color.fromARGB(255, 99, 97, 97);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(), bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home_filled),
          title: const Text('Home'),
          activeColor: const Color.fromARGB(255, 208, 8, 70),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.supervised_user_circle_outlined),
          title: const Text(
            'Users ',
          ),
          activeColor: const Color.fromARGB(255, 208, 8, 70),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Account'),
          activeColor: const Color.fromARGB(255, 208, 8, 70),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(alignment: Alignment.center, child: Register()),
      // Scaffold(
      //   appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //     title: const Text("NOTIFICATIONS"),
      //     centerTitle: true,
      //     backgroundColor: const Color.fromARGB(255, 243, 81, 81),
      //   ),
      //   body: Container(
      //     alignment: Alignment.center,
      //     child: const Text(
      //       "Notifications",
      //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // ),
      Container(alignment: Alignment.center, child: Users()),
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("ACCOUNT"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 208, 8, 70),
        ),
        body: Container(
          alignment: Alignment.center,
          child: const AccountScreen(),
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
