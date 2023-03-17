import 'package:my_pet_store/imports.dart';
import 'package:http/http.dart' as http;
import '../models/pet_products.dart';

class ProductsProvider with ChangeNotifier {
  final base_url =
      'https://flutter-cod3r-330bd-default-rtdb.firebaseio.com/products';
  final fav_Url =
      'https://flutter-cod3r-330bd-default-rtdb.firebaseio.com/userFavorites';

 late final List<Product> _products;

 List<Product> get _getProducts => [..._products];

 int get _getItemCountProducts => _products.length;

Future<void> loadProducts() async{
  final response =  await http.get(Uri.parse('$base_url.json'));

  Map<String, dynamic>? data =  json.decode(response.body);
  _products.clear();
  print(data);


notifyListeners();
}

}
