import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/pages/settings/setting.dart';
import 'package:shopping/theme/theme_widget.dart';
import '/pages/product/widgets/product_cart.dart';
import 'package:shopping/theme/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'widgets/product_card.dart';
import '/data/api/product_api.dart';

class Product extends StatefulWidget {
  static const String route = "/product";

  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

typedef TypeDef = List<ProductModel>;

class _ProductState extends State<Product> with SingleTickerProviderStateMixin {
  TypeDef products = [];
  TypeDef searchResult = [];
  bool showSearchBar = true;
  late ScrollController _scrollViewController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _scrollViewController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getData();
      _scrollViewController.addListener(listener);
    });
    super.initState();
  }

  getData() async {
    var products = await ProductApi.getProducts();
    setState(() => this.products = products);
  }

  listener() {
    var userAction = _scrollViewController.position.userScrollDirection;

    ///reverse  is scroll down
    if (userAction == ScrollDirection.reverse) {
      ///print('reverse ');
      showSearchBar = false;
    }

    ///reverse  is scroll up
    if (userAction == ScrollDirection.forward) {
      ///print('forward ');
      showSearchBar = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
        builder: (_, theme, __) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: theme.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Setting.route);
                  },
                ),
                title: const Text("Product"),
                actions: const [ProductCart()],
              ),
              body: Column(
                children: [
                  AnimatedSizeAndFade.showHide(
                    show: showSearchBar,
                    fadeDuration: const Duration(milliseconds: 200),
                    sizeDuration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      height: 60,
                      color: theme.primary,
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppTheme().white,
                        ),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: searchProduct,
                          decoration: const InputDecoration(
                            hintText: "Search",
                            contentPadding: EdgeInsets.all(6),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollViewController,
                      physics: const BouncingScrollPhysics(),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        children: [
                          if (searchResult.isEmpty)
                            ...List.generate(
                              products.length,
                              (idx) => ProductCard(product: products[idx]),
                            )
                          else
                            ...List.generate(
                              searchResult.length,
                              (idx) => ProductCard(product: searchResult[idx]),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void searchProduct(String enteredText) {
    enteredText = enteredText.trim().toLowerCase();
    searchResult = products
        .where(
          (product) => product.title!.toLowerCase().contains(enteredText),
        )
        .toList();
    setState(() {});
  }
}
