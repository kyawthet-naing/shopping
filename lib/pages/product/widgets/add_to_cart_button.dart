import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/cart_model.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/utils/color_utils.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, pd, child) => MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 40,
        minWidth: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: ColorUtils.appBarColor,
        onPressed: () {
          pd.addNewProduct(
            CartModel(qty: 1, product: product),
          );
        },
        child: Text(
          'Add to cart',
          style: TextStyle(color: ColorUtils.white, fontSize: 16),
        ),
      ),
    );
  }
}
