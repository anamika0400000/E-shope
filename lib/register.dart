import 'package:e_commers/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class registration_page extends StatefulWidget {
  const registration_page({super.key});

  @override
  State<registration_page> createState() => _registration_pageState();
}

var check;
TextEditingController Namecontroller = TextEditingController();
TextEditingController emailcondroller = TextEditingController();
TextEditingController usernamecontroller = TextEditingController();
TextEditingController passwordcondroller = TextEditingController();
CollectionReference users = FirebaseFirestore.instance.collection('users');
Future<void> addUser() {
  return users
      .add({
        'full_name': Namecontroller.text,
        'Email': emailcondroller.text,
        'username': usernamecontroller.text,
        'password': passwordcondroller.text
      })
      .then(
        (value) => check = 1,
      )
      .catchError((error) => print("Failed to add user: $error"));
}

class _registration_pageState extends State<registration_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            TextField(
              controller: Namecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailcondroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: usernamecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordcondroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  addUser();
                  if (check == 1) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  }
                },
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
