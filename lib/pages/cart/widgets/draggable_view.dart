import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/bounce_me.dart';
import 'package:shopping/components/remove_scroll_wave.dart';
import 'package:shopping/components/app_button.dart';
import 'package:shopping/components/solid_divider.dart';
import 'package:shopping/data/models/cart_model.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shopping/theme/theme_widget.dart';
import 'package:shopping/utils/reusable.dart';

class DraggableView extends StatelessWidget {
  const DraggableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, pd, child) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (ctx, controller) {
          return Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 120,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 3,
                  color: AppTheme().blackPoint2,
                  offset: const Offset(0, -1), // Shadow position
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: RemoveScrollWave(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: [
                          header,
                          ...List.generate(
                            pd.cartCount,
                            (idx) => cartDetailItem(pd.cart[idx]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                totalView()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dottedLine({Color? color}) {
    return DottedDashedLine(
      height: 0,
      dashColor: color ?? AppTheme().black,
      width: double.infinity,
      axis: Axis.horizontal,
    );
  }

  Widget get header {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme().blackPoint2,
                borderRadius: BorderRadius.circular(2),
              ),
              width: 40,
              height: 4,
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                'Cart Detail',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme().black,
                ),
              ),
            ),
            const SolidDivider(),
          ],
        ),
      ),
    );
  }

  Widget totalView() {
    return ThemeWidget(
      builder: (ctx, theme, __) => Consumer<CartProvider>(
        builder: (ctx, pd, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:theme.primary,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 39.5,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Items :',
                                    style: TextStyle(
                                      color: AppTheme().white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${pd.cartCount}',
                                    style: TextStyle(
                                      color: AppTheme().white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            dottedLine(color: theme.white),
                            Container(
                              height: 39.5,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Qty :',
                                    style: TextStyle(
                                      color: AppTheme().white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${pd.totalQty}',
                                    style: TextStyle(
                                      color: AppTheme().white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 1,
                          height: 80,
                          child: SolidDivider(
                            color: theme.white,
                            axis: SolidDividerAxis.vertical,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 80,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Subtotal :',
                                    style: TextStyle(
                                        color: AppTheme().white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${Reusable.priceFormat(num.parse(pd.subTotal))} \$',
                                    style: TextStyle(
                                      color: AppTheme().white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              BounceMe(
                child: AppButton(
                  onTap: () {},
                  color:theme.primary,
                  height: 50,
                  borderRadius: BorderRadius.circular(10),
                  width: double.infinity,
                  child: Text(
                    "place order".toUpperCase(),
                    style: TextStyle(
                      color: AppTheme().white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartDetailItem(CartModel item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.product.title ?? '',
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          Row(
            children: [
              Text(
                '${item.qty} x ${item.product.price} \$',
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              const Spacer(),
              Text(
                '${(item.qty * item.product.price!).toStringAsFixed(2)} \$',
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: dottedLine(),
          ),
        ],
      ),
    );
  }
}
