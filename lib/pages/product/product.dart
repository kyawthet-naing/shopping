import 'widgets/product_card.dart';
import '/data/api/product_api.dart';
import 'package:flutter/material.dart';
import '/pages/product/widgets/product_cart.dart';
import 'package:shopping/data/models/product_model.dart';

class Product extends StatefulWidget {
  static const String route = "/product";

  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<ProductModel> products = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getData();
    });
    super.initState();
  }

  getData() async {
    var products = await ProductApi.getProducts();
    setState(() => this.products = products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Product"),
        actions: const [ProductCart()],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            ...List.generate(
              products.length,
              (idx) => ProductCard(product: products[idx]),
            )
          ],
        ),
      ),
    );
  }
}
