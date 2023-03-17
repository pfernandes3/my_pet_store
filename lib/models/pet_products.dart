import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

   Future<void> toggleIsFavorite(String token,String userID) async {
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final baseUrl =
          'https://flutter-cod3r-330bd-default-rtdb.firebaseio.com/userFavorites/$userID/$id.json?auth=$token';

      final response = await http.put(Uri.parse(baseUrl),
          body: json.encode(isFavorite));

      if (response.statusCode >= 400) {
        isFavorite = !isFavorite;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}