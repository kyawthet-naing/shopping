import 'package:shopping/data/models/product_model.dart';

class CartModel {
  int qty;
  ProductModel product;

  CartModel({required this.qty,required this.product});
}