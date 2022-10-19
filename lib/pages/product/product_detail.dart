import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/utils/color_utils.dart';
import 'widgets/add_to_cart_button.dart';
import 'widgets/product_cart.dart';
import 'widgets/qty_button.dart';

class ProductDetail extends StatelessWidget {
  static const String route = "/product-detail";
  final ProductModel product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: Text('${product.title} Details'),
        actions: const [ProductCart()],
      ),
      body: Consumer<CartProvider>(
        builder: (ctx, pd, child) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.image!,
                width: double.infinity,
                height: MediaQuery.of(context).size.width - 20,
              ),
              Text(
                product.title ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Price : ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${product.price} \$ ',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  if (!pd.alreadyExit(product.id!))
                    Align(
                      alignment: Alignment.centerRight,
                      child: AddToCartButton(product: product),
                    )
                  else
                    QtyButton(product: product)
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Category :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                product.category ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                product.description ?? '',
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
