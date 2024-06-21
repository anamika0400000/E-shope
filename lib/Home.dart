import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Add.dart';
import 'package:e_commers/Login.dart';
import 'package:e_commers/cart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // get product => null;
  List product = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart_sharp),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddProduct();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Text(
                  'Comming Soon...',
                );
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          FiltersSection(),
          Expanded(
            child: ProductGrid(),
          ),
        ],
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
            "Product categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
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
                return ProductCard(product: products[index]);
              },
            );
          },
        );
      },
    );
  }
}

class Product {
  final String name;
  final String Price;
  final String imagePath;
  final String isOnSale;
  final String diss;

  Product(
      {required this.name,
      required this.Price,
      required this.imagePath,
      required this.diss,
      required this.isOnSale});

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      name: doc['name'],
      Price: doc['Price'],
      imagePath: doc['imagePath'],
      isOnSale: doc['isOnSale'],
      diss: doc['Description'],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            product.imagePath,
            height: 270,
            width: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image_search_rounded,
                  size: 200); // Show a placeholder or error icon
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text(product.name),
          SizedBox(
            height: 5,
          ),
          Text("\$${product.Price}"),
          SizedBox(
            height: 5,
          ),
          // if (product.isOnSale == "true")
          Text(
            "Sale!",
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(
            height: 20,
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartPage(product: product);
                }));
              },
              child: Text('Add to cart'))
        ],
      ),
    );
  }
}
