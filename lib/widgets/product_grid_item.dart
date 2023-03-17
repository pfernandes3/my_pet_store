import 'package:flutter/material.dart';
import 'package:my_pet_store/models/pet_products.dart';
import 'package:my_pet_store/providers/authenticate_provider.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    //final Cart cart = Provider.of<Cart>(context, listen: false);
    final AuthenticateProvider auth = Provider.of(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.deepOrange,
              ),
              onPressed: () =>
                  product.toggleIsFavorite(auth.getToken!, auth.idUser!),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Produto adicionado com sucesso'),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      //cart.removeSingleItem(product.id);
                    }),
              ));
              //cart.addItem(product);
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_SCREEN, arguments: product),
            child: Hero(
              tag: product.id!,
              child: FadeInImage(
                 
                placeholder: const AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}