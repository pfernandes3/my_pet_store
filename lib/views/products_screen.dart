import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/widgets/product_grid.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({super.key});

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  final bool _showFavoriteOnly = false;
  bool _isLoading = true;
  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false)
        .loadProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Store'),
      ),
      body: (const ProductGrid()),
    );
  }
}
