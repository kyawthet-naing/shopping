import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/bloc/search_bloc.dart';
import 'package:shopping/data/models/product_model.dart';
import 'package:shopping/pages/product/widgets/search_bar.dart';
import 'package:shopping/pages/settings/setting.dart';
import 'package:shopping/theme/theme_widget.dart';
import 'package:shopping/utils/reusable.dart';
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
  late ScrollController _scrollCtrl;
  final SearchBloc _searchBloc = SearchBloc();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _scrollCtrl = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getData();
      _scrollCtrl.addListener(listener);
    });
    super.initState();
  }

  getData() async {
    var products = await ProductApi.getProducts();
    setState(() => this.products = products);
  }

/*
  scrollStartStopListener() {
    _scrollCtrl.position.isScrollingNotifier.addListener(() {
      if (!_scrollCtrl.position.isScrollingNotifier.value) {
        print('scroll is stopped');
      } else {
        print('scroll is started');
      }
    });
  }
*/
  listener() {
    var userAction = _scrollCtrl.position.userScrollDirection;

    ///reverse  is scroll down
    if (userAction == ScrollDirection.reverse) {
      ///print('reverse ');
      _searchBloc.searchController.sink.add(false);
    }

    ///reverse  is scroll up
    if (userAction == ScrollDirection.forward) {
      ///print('forward ');
      _searchBloc.searchController.sink.add(true);
    }
  }

  @override
  void dispose() {
    _searchBloc.disposed();
    _scrollCtrl.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
        builder: (_, theme, __) => Scaffold(
              body: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: theme.primary.withOpacity(.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: Reusable.statusBarHeight,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.primary,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: theme.white,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Setting.route,
                                  );
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'product'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: theme.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const ProductCart()
                            ],
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: _searchBloc.stream,
                          initialData: true,
                          builder: (ctx, snapshot) {
                            return AnimatedSizeAndFade.showHide(
                              show: snapshot.data!,
                              fadeDuration: const Duration(milliseconds: 200),
                              sizeDuration: const Duration(milliseconds: 200),
                              child: SearchBar(
                                searchController,
                                onClear: () {
                                  searchController.clear();
                                  searchResult.clear();
                                },
                                onSearch: searchProduct,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollCtrl,
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
