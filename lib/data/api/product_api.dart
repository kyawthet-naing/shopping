import 'dart:convert';
import 'package:flutter/services.dart';
import '/data/models/product_model.dart';

class ProductApi {
  ///Testing product api route
  ///https://fakestoreapi.com/products/

  static Future<List<ProductModel>> getProducts() async {
    String data = await rootBundle.loadString('assets/json/product.json');
    var decodeJson = json.decode(data) as List<dynamic>;
    return decodeJson.map((e) => ProductModel.fromJson(e)).toList();
  }
}
