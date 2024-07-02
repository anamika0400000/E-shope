
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Add.dart';
import 'package:e_commers/Login.dart';
import 'package:e_commers/cart.dart';
import 'package:e_commers/productinfo.dart';
import 'package:e_commers/productcard.dart';
import 'package:e_commers/productgrid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? userId;
  final List? cart;
  HomePage({this.userId, this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        backgroundColor: Colors.redAccent,
        shadowColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart_sharp, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddProduct();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyCartpage(cartList: cart);
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        child: Column(
          children: [
            FiltersSection(),
            Expanded(
              child: ProductGrid(
                cart: cart,
                userid: userId!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FiltersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Product Categories",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String Price;
  final String imagePath;
  final String isOnSale;
  final String diss;
  final String id;

  Product({
    required this.id,
    required this.name,
    required this.Price,
    required this.imagePath,
    required this.diss,
    required this.isOnSale,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      Price: doc['Price'],
      imagePath: doc['imagePath'],
      isOnSale: doc['isOnSale'],
      diss: doc['Description'],
    );
  }
}
