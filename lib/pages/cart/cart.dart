import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopping/utils/images_name.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/pages/product/widgets/product_card.dart';
import 'package:shopping/pages/cart/widgets/draggable_view.dart';

class Cart extends StatefulWidget {
  static const String route = "/cart";

  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
  late ScrollController _scrollViewController;
  late AnimationController animController;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();

    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    offset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(animController);

    _scrollViewController.addListener(listener);
  }

  listener() {
    var userAction = _scrollViewController.position.userScrollDirection;

    if (userAction == ScrollDirection.reverse) {
      animController.forward();
    }

    if (userAction == ScrollDirection.forward) {
      animController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (ctx, pd, child) => pd.cartCount == 0
            ? Center(
                child: Image.asset(
                  ImagesName.girlWithCart,
                  width: 200,
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollViewController,
                    padding: const EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        pd.cartCount,
                        (idx) => ProductCard(
                          isCart: true,
                          product: pd.cart[idx].product,
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: offset,
                    child: const DraggableView(),
                  ),
                ],
              ),
      ),
    );
  }
}
