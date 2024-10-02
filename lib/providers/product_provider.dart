import 'dart:collection';

import 'package:fit_club_bar/databases/product_database.dart';
import 'package:fit_club_bar/dtos/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _originalProducts = [];
  List<Product> _products = [];

  int get totalProducts => _products.length;

  UnmodifiableListView<Product> get products => UnmodifiableListView(
      _products); //to get the products list without being able to modify it

  void clearSearch() {
    _products = [..._originalProducts];
    notifyListeners();
  }

  void searchProductsByName(String name) {
    _products = _originalProducts
        .where((element) => element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();

    print('Products found: $_originalProducts'); 
    notifyListeners();
  }

  Future<void> addProduct(String name, double price, int stock) async {
    Product productModel = Product(name: name, price: price, stock: stock);
    final productId = await ProductDatabase.instance.create(productModel);

    Product productWithId = Product(
        id: productId,
        name: productModel.name,
        price: productModel.price,
        stock: productModel.stock);

    _products.add(productWithId);
    _originalProducts.add(productWithId);
    notifyListeners();
  }

  Future<void> _initializedProducts() async {
    List<Product> products = await ProductDatabase.instance.readAllProducts();
    _products.clear();
    _products.addAll(products);
    _originalProducts.clear();
    _originalProducts.addAll(products);
    notifyListeners();
  }

  Future<bool> checkProducts() async {
    if (_products.isEmpty) {
      await _initializedProducts();
      return true;
    }
    return false;
  }

  Future<void> deleteProduct(int id) async {
    _products.removeWhere((element) => element.id == id);
    await ProductDatabase.instance.deleteAt(id);
    notifyListeners();
  }

  Future<void> updateProduct(int id,
      {String? name, double? price, int? stock}) async {
    Product product =
        _products.firstWhere((element) => element.id == id);
    int productIndex =
        _products.indexWhere((element) => element.id == id);
    product.name = name ?? product.name;
    product.price = price ?? product.price;
    product.stock = stock ?? product.stock;
    _products[productIndex] = product;
    await ProductDatabase.instance
        .updateProduct(id, name: name, price: price, stock: stock);
    notifyListeners();
  }
}
