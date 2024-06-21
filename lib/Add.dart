import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Home.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

var check;

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController imagePath = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController isonsale = TextEditingController();
  TextEditingController dis = TextEditingController();
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  Future<void> addproducts() {
    return products
        .add({
          'name': name.text,
          'Price': price.text,
          'imagePath': imagePath.text,
          'isOnSale': isonsale.text,
          'Description': dis.text
        })
        .then(
          (value) => check = 1,
        )
        .catchError((error) => print("Failed to add Product: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: price,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: imagePath,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image Path',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: isonsale,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'IsOnSale',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: dis,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  addproducts();
                  if (check == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfuly!')),
                    );
                  }
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
