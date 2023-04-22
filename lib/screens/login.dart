import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(0, 370),
            end: Alignment(430, 0),
            colors: [
              Color.fromRGBO(216, 75, 40, 0.788),
              Color.fromRGBO(255, 129, 13, 0.7900000214576721)
            ]),
      ),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 300,
                scale: 2.5,
              )
            ],
          ),
        ),
        Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: const TextField(
            ),
          )
        )
      ],
    );
  }
}
