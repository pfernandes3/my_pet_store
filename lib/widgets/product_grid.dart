import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/widgets/product_grid_item.dart';
import '../models/pet_products.dart';

import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});
  

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts =
        Provider.of<ProductsProvider>(context).getProducts;
//final List<Product> loadedProducts=  Provider.of(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/ 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      padding: const EdgeInsets.all(20),
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: ProductGridItem(),
      ),
    );
  }
}
