import 'package:shopping/components/image_view.dart';

import 'widgets/qty_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/add_to_cart_button.dart';
import 'package:shopping/utils/color_utils.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/pages/product/widgets/product_cart.dart';

class ProductDetail extends StatelessWidget {
  static const String route = "/product-detail";
  final ProductModel product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  final String fakeDetail = """
Esse exercitation cupidatat aliqua cillum amet amet laborum dolore. Duis tempor do ex eu tempor. Anim fugiat ipsum ex ad fugiat eu. Ipsum nostrud dolore aliquip anim ex magna. Incididunt non qui deserunt pariatur velit quis consequat. Sit labore voluptate do elit laboris officia irure deserunt minim pariatur excepteur laboris id.

Nulla Lorem laboris mollit dolor. Consectetur dolore sit nostrud do dolore in aute anim excepteur velit ea. Adipisicing minim ex enim labore tempor aliquip. Voluptate duis sit dolor fugiat sit tempor excepteur velit. Laborum voluptate et tempor in et voluptate deserunt dolor proident cupidatat irure aute incididunt. Et deserunt eu deserunt eu tempor incididunt eu ea duis. Lorem eu enim sit magna elit pariatur ex incididunt nostrud.""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        title: Text(
          product.title ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: const [ProductCart()],
      ),
      body: Consumer<CartProvider>(
        builder: (ctx, pd, child) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView(
                image:product.image!,
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
                '${product.description}\n$fakeDetail',
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
