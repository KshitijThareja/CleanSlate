import 'package:flutter/material.dart';
import 'package:hms/screens/reg_form.dart';

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
    );
  }
}
