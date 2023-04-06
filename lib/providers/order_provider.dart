import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_pet_store/imports.dart';

import 'cart_provider.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  Order(this.id, this.amount, this.products, this.date);
}

class Orders with ChangeNotifier {
  final String baseUrl =
      'https://flutter-cod3r-330bd-default-rtdb.firebaseio.com/orders';

  List<Order> _orders = [];

  String? _token;
  String? _userId;
  Orders(this._token, this._orders, this._userId);

  List<Order> get orders {
    return [..._orders];
  }

  int get itemsOrderCounts {
    return _orders.length;
  }

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response =
        await http.get(Uri.parse('$baseUrl/$_userId.json?auth=$_token'));
    Map<String, dynamic>? data = jsonDecode(response.body);

    print(data);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(Order(
          orderId,
          orderData['total'],
          (orderData['products'] as List<dynamic>).map((e) {
            return CartItem(
                id: e['id'],
                productId: e['productId'],
                title: e['title'],
                quantity: e['quantity'],
                price: e['price']);
          }).toList(),
          DateTime.parse(orderData['date']),
        ));
      });
      notifyListeners();
    }

    _orders = loadedItems.reversed.toList();
    return Future.value();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response =
        await http.post(Uri.parse('$baseUrl/$_userId.json?auth=$_token'),
            body: json.encode({
              'total': cart.CartTotalAmount,
              'date': date.toIso8601String(),
              'products': cart.getCartItens.values
                  .map((ci) => {
                        'id': ci.id,
                        'productId': ci.productId,
                        'title': ci.title,
                        'quantity': ci.quantity,
                        'price': ci.price
                      })
                  .toList(),
            }));

    notifyListeners();
  }
}
