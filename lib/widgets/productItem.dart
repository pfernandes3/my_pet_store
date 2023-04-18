import 'package:flutter/material.dart';
import 'package:my_pet_store/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/pet_products.dart';
import '../providers/products_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_STORAGE, arguments: product);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Excluir Produto'),
                    content: const Text('Tem Certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value) {
                    try {
                      await Provider.of<ProductsProvider>(context,
                              listen: false)
                          .deleteProduct(product.id!);
                    } catch (e) {
                      scaffold
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                      // await showDialog<void>(
                      //     context: context,
                      //     builder: (ctx) => AlertDialog(
                      //           title: const Text('Ocorreu um erro!'),
                      //           content: Text(e.toString()),
                      //           actions: [
                      //             TextButton(
                      //               child: const Text('Ok'),
                      //               onPressed: () =>
                      //                   Navigator.of(context).pop(),
                      //             )
                      //           ],
                      //         ));
                    }
                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
