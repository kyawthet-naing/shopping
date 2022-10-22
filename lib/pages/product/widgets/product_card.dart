import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/image_view.dart';
import 'package:shopping/components/popup_listener.dart';
import 'package:shopping/components/popup_view.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/pages/product/product_detail.dart';
import 'package:shopping/pages/product/widgets/add_to_cart_button.dart';
import 'package:shopping/pages/product/widgets/qty_button.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/utils/color_utils.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ///for card click
  final bool isCart;

  const ProductCard({Key? key, required this.product, this.isCart = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, pd, child) => GestureDetector(
        onTap: () {
          if (isCart) return;
          Navigator.pushNamed(context, ProductDetail.route, arguments: product);
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorUtils.blackPoint2,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  ImageView(
                    image: product.image!,
                    width: 116,
                    fit: BoxFit.fill,
                    height: double.infinity,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          //padding 40 is delete icon space
                          padding: EdgeInsets.only(right: isCart ? 40 : 0),
                          child: Text(
                            '${product.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Text(
                          '${product.price} \$',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: !pd.alreadyExit(product.id!)
                              ? AddToCartButton(product: product)
                              : QtyButton(product: product),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///delete icon
            if (isCart)
              GestureDetector(
                onTap: () {
                  PopupListenerState.show(
                    child: PopupView(
                      title:
                          "Are you sure that you want to remove this item ? If not, click \"Cancel\".",
                      confirm: () {
                        pd.removeProduct(product.id);
                      },
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorUtils.red,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: ColorUtils.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
