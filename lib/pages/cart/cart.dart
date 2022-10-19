import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/pages/product/widgets/product_card.dart';

class Cart extends StatelessWidget {
  static const String route = "/cart";
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (ctx, pd, child) => pd.cartCount == 0
            ? const Center(
                child: Text(
                  'Ohh! Empty Product...',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...List.generate(
                      pd.cartCount,
                      (idx) => ProductCard(
                        isCart: true,
                        product: pd.cart[idx].product,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
