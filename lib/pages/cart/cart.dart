import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/utils/color_utils.dart';
import 'package:shopping/utils/images_name.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/pages/product/widgets/product_card.dart';

class Cart extends StatelessWidget {
  static const String route = "/cart";

  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (ctx, pd, child) => pd.cartCount == 0
            ? Center(
                child: Image.asset(
                  ImagesName.emptyCart,
                  width: double.infinity,
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
