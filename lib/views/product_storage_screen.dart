import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/providers/products_provider.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:my_pet_store/widgets/CustomDrawer.dart';
import 'package:my_pet_store/widgets/productItem.dart';
import 'package:provider/provider.dart';

class ProductStorageScreen extends StatelessWidget {
  const ProductStorageScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductsProvider>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<ProductsProvider>(context);
    final productItens = loadedProducts.getProducts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gerenciamento de Produtos'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_STORAGE),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
              itemBuilder: (context, index) => ProductItem(product: productItens[index]),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: loadedProducts.getItemCountProducts),
        ),
        onRefresh: () => _refreshProducts(context),
      ),
    );
  }
}
