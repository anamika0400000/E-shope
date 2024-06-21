import 'package:e_commers/Home.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Product product;

  const CartPage({Key? key, required this.product}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body:SingleChildScrollView(
        
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              '${widget.product.imagePath}',
              height: 400,
              width: 500,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Name: ${widget.product.name}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: "\$${widget.product.Price}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: ${widget.product.diss}',
              style: TextStyle(fontSize: 16.0),
            ),
            ElevatedButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed')),
      );
            }, child: Text("Buy Now"))
          ],
        ),
      ),
    );
  }
}
