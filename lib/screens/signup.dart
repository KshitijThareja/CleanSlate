import 'package:flutter/material.dart';
// import 'package:hms/Animation/FadeAnimation.dart';
// void main() => runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignUpScreen(),
//     )
// );
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            // end: Alignment(430, 0),
            colors: [
              Color.fromRGBO(216, 75, 40, 0.788),
              Color.fromRGBO(255, 129, 13, 0.7900000214576721)
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 80,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Signup", style: TextStyle(color: Colors.white, fontSize: 40),),
                SizedBox(height: 10,),
                Text("Enter the following details", style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      SizedBox(height: 40,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.orange[900]
                        ),
                        child: Center(
                          child: Text("Sign up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Text("Already have an account?", style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 30,),
                      Center(
                        child: ElevatedButton(
                          child: const Text('Log in'),
                          onPressed: () {
                            Navigator.pop(
                              context);
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
      )
      );

  }
}

// class _Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Column(
//             children: <Widget>[
//               Image.asset(
//                 'assets/logo.png',
//                 height: 300,
//                 scale: 3.5,
//               )
//             ],
//           ),
//         ),
//         Expanded(
//             flex: 4,
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50),
//                 ),
//                 color: Colors.white,
//               ),
    //           child: Padding(
    //             padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: const [
    //               Text(
    //               "Log In",
    //
    //             ),
    // ],
    // ),
    //
    //           )
    //         ))
    //   ],
    // );
  // }
// }
