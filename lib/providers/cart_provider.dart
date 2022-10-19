import 'package:flutter/foundation.dart';
import 'package:shopping/data/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cart = [];

  int get cartCount => cart.length;

  addNewProduct(CartModel cart) {
    this.cart.add(cart);
    notifyListeners();
  }

  ///id is product id
  removeProduct(id) {
    var index = cart.indexWhere((e) => e.product.id == id);
    if (index != -1) {
      cart.removeAt(index);
    }
    notifyListeners();
  }

  ///id is product id
  int getProductQty(id) {
    var index = cart.indexWhere((e) => e.product.id == id);

    if (index != -1) {
      return cart[index].qty;
    } else {
      return 0;
    }
  }

  ///id is product id
  alreadyExit(num id) {
    var index = cart.indexWhere((e) => e.product.id == id);

    //found index
    // not found -1
    if (index != -1) {
      ///ma shi buu
      return true;
    } else {
      ///shi tal
      return false;
    }
  }

  increaseQty(id) {
    ///sure
    var index = cart.indexWhere((e) => e.product.id == id);
    if (index != -1) {
      cart[index].qty++;
    }
    notifyListeners();
  }

  decreaseQty(id) {
    ///sure
    var index = cart.indexWhere((e) => e.product.id == id);
    if (index != -1) {
      if (cart[index].qty == 1) {
        cart.removeAt(index);
      } else {
        cart[index].qty--;
      }
    }
    notifyListeners();
  }
}
