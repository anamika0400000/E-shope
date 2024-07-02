
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Home.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String? userId;
  final List? carts;
  final Product product;

  CartPage({Key? key, required this.product, this.userId, this.carts})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> Addtocart() async {
    print(widget.carts);

    List itemList = widget.carts!;
    itemList.add(widget.product.id);
    final cart = await users.doc(widget.userId).update({"cart": itemList}).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product Added to cart')),
            ),
        onError: (e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.product.imagePath,
                  height: 400,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${widget.product.Price}',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product.diss,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Order placed')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: BorderSide(color: Colors.redAccent),
                  ),
                  child: Text("Buy Now"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Addtocart();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Text("Add to Cart"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
