import 'dart:collection';

import 'package:fit_club_bar/dtos/product_cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductCart> _cartProducts = [];
  UnmodifiableListView<ProductCart> get cartProducts =>
      UnmodifiableListView(_cartProducts);

  void addProduct(ProductCart product) {
    if (_cartProducts.contains(product)) {
      final index = _cartProducts.indexWhere((element) => element == product);
      _cartProducts[index].quantity += product.quantity;
      notifyListeners();
    } else {
      _cartProducts.add(product);
      notifyListeners();
    }
  }

  void removeProduct(ProductCart product) {
    _cartProducts.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }

  Future<bool> checkCartProducts() async {
    if (_cartProducts.isEmpty) {
      return false;
    }
    return true;
  }

  double get totalAmount {
    double total = 0;
    for (var element in _cartProducts) {
      total += element.price * element.quantity;
    }
    return total;
  }
}
