import 'dart:math';

import 'package:flutter/material.dart';

import '../models/pet_products.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get getCartItens {
    return {..._items};
  }

  int get getCartItensCount {
    return _items.length;
  }

  double get CartTotalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addCartItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id!,
          (exists) => CartItem(
              id: exists.id,
              productId: product.id!,
              title: exists.title,
              quantity: exists.quantity + 1,
              price: exists.price));
    } else {
      _items.putIfAbsent(
          product.id!,
          () => CartItem(
              id: Random().nextDouble().toString(),
              productId: product.id!,
              title: product.title,
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeSingle(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
          productId,
          (exists) => CartItem(
              id: exists.id,
              productId: productId,
              title: exists.title,
              quantity: exists.quantity - 1,
              price: exists.price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
