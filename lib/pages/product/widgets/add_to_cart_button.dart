import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/data/models/cart_model.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/theme/theme_widget.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, pd, child) => ThemeWidget(
        builder: (_, theme, __) => MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 40,
          minWidth: 120,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: theme.primary,
          onPressed: () {
            pd.addNewProduct(
              CartModel(qty: 1, product: product),
            );
          },
          child: Text(
            'add_to_cart'.tr(),
            style: TextStyle(color: theme.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
