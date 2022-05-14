import 'package:flutter/material.dart';
import 'package:shamo/model/cart_model.dart';
import 'package:shamo/model/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;
  set cart(List<CartModel> carts) {
    _cart = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    if (isCart(product)) {
      int index =
          _cart.indexWhere((element) => element.product.id == product.id);
      _cart[index].quantity++;
    } else {
      _cart.add(CartModel(id: _cart.length, product: product, quantity: 1));
    }

    notifyListeners();
  }

  removeCart(int id) {
    _cart.removeAt(id);
    notifyListeners();
  }

  addQuantity(int id) {
    _cart[id].quantity++;
    notifyListeners();
  }

  reduceQuantity(int id) {
    if (_cart[id].quantity == 1) {
      _cart.removeAt(id);
    } else {
      _cart[id].quantity--;
    }
    notifyListeners();
  }

  int totalItems() {
    int total = 0;
    for (var item in _cart) {
      total += item.quantity;
    }

    return total;
  }

  double totalPrice() {
    double total = 0;
    for (var item in _cart) {
      total += item.quantity * item.product.price!;
    }

    return total;
  }

  isCart(ProductModel product) {
    return _cart.indexWhere((element) => element.product.id == product.id) !=
        -1;
  }
}
