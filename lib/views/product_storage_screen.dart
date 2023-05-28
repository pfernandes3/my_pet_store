import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/providers/products_provider.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:my_pet_store/widgets/CustomDrawer.dart';
import 'package:my_pet_store/widgets/productItem.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

class ProductStorageScreen extends StatefulWidget {
  
  const ProductStorageScreen({super.key});

  @override
  State<ProductStorageScreen> createState() => _ProductStorageScreenState();
}

class _ProductStorageScreenState extends State<ProductStorageScreen> {

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductsProvider>(context, listen: false).loadProducts();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      S.load(const Locale("en"));
    });
  }
  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<ProductsProvider>(context);
    final productItens = loadedProducts.getProducts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(S.of(context).handleProducts),
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
