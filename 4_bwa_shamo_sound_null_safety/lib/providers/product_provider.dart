import 'package:flutter/material.dart';
import 'package:shamo/model/product_model.dart';
import 'package:shamo/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
      print("GET INI GET PRODUCTS ${_products.length}");
    } catch (e) {
      print(e);
    }
  }
}
