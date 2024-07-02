

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController isOnSaleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  var check;

  Future<void> addProducts() async {
    try {
      await products.add({
        'name': nameController.text,
        'Price': priceController.text,
        'imagePath': imagePathController.text,
        'isOnSale': isOnSaleController.text,
        'Description': descriptionController.text,
      });
      setState(() {
        check = 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully!')),
      );
    } catch (error) {
      print("Failed to add product: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 15),
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
              controller: priceController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Price',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: imagePathController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Image Path',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: isOnSaleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Is On Sale',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.redAccent),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
