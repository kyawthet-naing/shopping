import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class QtyButton extends StatelessWidget {
  final ProductModel product;
  const QtyButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, pd, child) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          button(
            onTap: () => pd.decreaseQty(product.id!),
            icon: Icons.remove,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 40),
            alignment: Alignment.center,
            child: Text(
              "${pd.getProductQty(product.id)}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          button(
            onTap: () => pd.increaseQty(product.id!),
            icon: Icons.add,
          )
        ],
      ),
    );
  }
}

extension on QtyButton {
  Widget button({required IconData icon, required Function onTap}) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      height: 40,
      minWidth: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: ColorUtils.primary,
      onPressed: () => onTap(),
      child: Icon(icon, color: ColorUtils.white),
    );
  }
}
