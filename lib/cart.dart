
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Home.dart';
import 'package:e_commers/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCartpage extends StatefulWidget {
  final List<dynamic>? cartList;
  MyCartpage({super.key, this.cartList});

  @override
  State<MyCartpage> createState() => _MyCartpageState();
}

class _MyCartpageState extends State<MyCartpage> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  bool isLoading = true;
  List<Map<String, dynamic>> productData = [];

  void fetchDocumentDetails(List<dynamic> cartList) async {
    for (String docId in cartList) {
      try {
        DocumentSnapshot doc = await products.doc(docId).get();
        var documentData = doc.data() as Map<String, dynamic>?;

        if (doc.exists && documentData != null) {
          setState(() {
            productData.add(documentData);
          });
        }
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDocumentDetails(widget.cartList!);
  }

  void remove(int index) async {
    String docId = widget.cartList![index];
    try {
      await products.doc(docId).delete();
      setState(() {
        productData.removeAt(index);
        widget.cartList!.removeAt(index);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return HomePage();
              // }));
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
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : productData.isEmpty
              ? Center(
                  child: Text(
                    'No items in cart',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: productData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color.fromARGB(255, 64, 63, 63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      productData[index]['imagePath']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productData[index]['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$${productData[index]["Price"]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  remove(index);
                                });
                              },
                              icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
