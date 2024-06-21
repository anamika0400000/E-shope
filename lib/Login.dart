import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/register.dart'; // Ensure the correct path to your registration page
import 'package:e_commers/Home.dart'; // Ensure the correct path to your home page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> loginUser() async {
    QuerySnapshot querySnapshot = await users
        .where('username', isEqualTo: usernameController.text)
        .where('password', isEqualTo: passwordController.text)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                child: Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return registration_page();
                        },
                      ));
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
