import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Home.dart';
import 'package:e_commers/productinfo.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  String userId;
  List carts;
  final Product product;

  ProductCard(
      {required this.product, required this.userId, required this.carts});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List poductdetails = [];

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Addtocart() async {
    print(widget.carts);

    List itemList = widget.carts;
    itemList.add(widget.product.id);
    final cart = await users.doc(widget.userId).update({"cart": itemList}).then(
        (value) => print("success"),
        onError: (e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CartPage(
            product: widget.product,
            carts: widget.carts,
            userId: widget.userId,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Color.fromARGB(142, 32, 31, 31),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: 270,
              width: 250,
              child: Image.network(
                widget.product.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_search_rounded,
                    size: 200,
                    color: Colors.white,
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.product.name,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "\$${widget.product.Price}",
              style: TextStyle(color: Colors.white),
            ),
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

            // OutlinedButton(
            //     onPressed: () {
            //       Addtocart();
            //     },
            //     child: Text('Add to cart'))
          ],
        ),
      ),
    );
  }
}
