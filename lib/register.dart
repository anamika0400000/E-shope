// import 'package:e_commers/Home.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';

// class registration_page extends StatefulWidget {
//   const registration_page({super.key});

//   @override
//   State<registration_page> createState() => _registration_pageState();
// }

// var check;
// TextEditingController Namecontroller = TextEditingController();
// TextEditingController emailcondroller = TextEditingController();
// TextEditingController usernamecontroller = TextEditingController();
// TextEditingController passwordcondroller = TextEditingController();
// CollectionReference users = FirebaseFirestore.instance.collection('users');
// Future<void> addUser() {
//   List cart;
//   return users
//       .add({
//         'full_name': Namecontroller.text,
//         'Email': emailcondroller.text,
//         'username': usernamecontroller.text,
//         'password': passwordcondroller.text,
//         'cart': []
//       })
//       .then(
//         (value) => check = 1,
//       )
//       .catchError((error) => print("Failed to add user: $error"));
// }

// class _registration_pageState extends State<registration_page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Register'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: Namecontroller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Name',
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextField(
//               controller: emailcondroller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Email',
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextField(
//               controller: usernamecontroller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Username',
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextField(
//               controller: passwordcondroller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   addUser();
//                   if (check == 1) {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return HomePage();
//                     }));
//                   }
//                 },
//                 child: Text('Sign Up'))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:e_commers/Home.dart';
import 'package:e_commers/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var check;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() async {
    try {
      await users.add({
        'full_name': nameController.text,
        'Email': emailController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'cart': []
      });
      setState(() {
        check = 1;
      });
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Register'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await addUser();
                if (check == 1) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomePage(
                      userId: users.id,
                      cart: [],
                    );
                  }));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Sign Up'),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have an account ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Text(
                    'Login.',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
