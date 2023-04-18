import 'dart:io';

import 'package:my_pet_store/imports.dart';
import 'package:http/http.dart' as http;
import '../models/pet_products.dart';

class ProductsProvider with ChangeNotifier {
  final base_url =
      'https://flutter-cod3r-330bd-default-rtdb.firebaseio.com/products';
  final fav_Url =
      'https://flutter-cod3r-330bd-default-rtdb.firebaseio.com/userFavorites';

  final List<Product> _products;
  final bool _showFavorite = false;
  final dynamic _token;
  final String? _idUser;

  ProductsProvider(this._token, this._products, this._idUser);
  List<Product> get getProducts => [..._products];
  List<Product> get getFavoriteProducts =>
      _products.where((element) => element.isFavorite).toList();
  int get getItemCountProducts => _products.length;

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse('$base_url.json?auth=$_token'));
    final favResponse =
        await http.get(Uri.parse('$fav_Url/$_idUser.json?auth=$_token'));
    final favMap = jsonDecode(favResponse.body);

    Map<String, dynamic>? data = json.decode(response.body);
    _products.clear();
    if (data != null) {
      print(data);
      data.forEach((productId, productData) {
        final isFavorite = favMap == null ? false : favMap[productId] ?? false;
        _products.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ));
      });
    }

    notifyListeners();

    return Future.value();
  }

  Future<void> insertProducts(Product product) async {
    final response = await http.post(Uri.parse('$base_url.json?auth=$_token'),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl
        }));
    notifyListeners();
  }

  Future<void> updateProducts(Product product) async {
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index > 0) {
      await http.patch(Uri.parse('$base_url/${product.id}.json?auth=$_token'),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productID) async {
    final index = _products.indexWhere((element) => element.id == productID);
    if (index > 0) {
      final product = _products[index];
      _products.remove(product);
      notifyListeners();

      final response = await http
          .delete(Uri.parse('$base_url/${product.id}.json?auth=$_token'));
      if (response.statusCode >= 400) {
        print('Erro detectado');
        _products.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto');
      }
    }
  }
}
