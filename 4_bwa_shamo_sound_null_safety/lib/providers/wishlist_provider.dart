import 'package:flutter/material.dart';
import 'package:shamo/model/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _wishlist = [];
  List<ProductModel> get wishlist => _wishlist;
  set wishlist(List<ProductModel> wishList) {
    _wishlist = wishlist;
    notifyListeners();
  }

  setProduct(ProductModel productModel) {
    if (!isWishlist(productModel)) {
      _wishlist.add(productModel);
    } else {
      _wishlist.removeWhere((element) => element.id == productModel.id);
    }

    notifyListeners();
  }

  isWishlist(ProductModel productModel) {
    return _wishlist.indexWhere((element) => element.id == productModel.id) !=
        -1;
  }
}
