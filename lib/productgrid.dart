import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Home.dart';
import 'package:e_commers/productcard.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  List? cart;
  String userid;
  ProductGrid({required this.userid, required this.cart});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate crossAxisCount and childAspectRatio based on screen width
        int crossAxisCount = constraints.maxWidth > 1000 ? 3 : 2;
        double childAspectRatio = (constraints.maxWidth / crossAxisCount) / 500;

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!.docs.map((doc) {
              return Product.fromDocument(doc);
            }).toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  carts: cart!,
                  product: products[index],
                  userId: userid,
                );
              },
            );
          },
        );
      },
    );
  }
}
