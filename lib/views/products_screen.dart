import 'package:my_pet_store/imports.dart';
import 'package:my_pet_store/widgets/product_grid.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../utils/app_routes.dart';
import '../widgets/CustomDrawer.dart';
import '../widgets/badge.dart';

enum FilterOptions { Favorite, All }

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({super.key});

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  bool _showFavoriteOnly = false;
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
        title: const Text(
          'My store',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorite) {
                setState(() {
                  _showFavoriteOnly = true;
                });
              } else {
                setState(() {
                  _showFavoriteOnly = false;
                });
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Todos'),
              ),
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.CART_ROUTE),
                //
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 25,
                )),
            builder: (_, cart, child) => Badge(
              value: cart.getCartItensCount.toString(),
              child: child as Widget,
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductGrid(
              showFavoriteOnly: _showFavoriteOnly,
            ),
      drawer: const CustomDrawer(),
    );
  }
}
