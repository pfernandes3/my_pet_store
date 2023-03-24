import 'package:my_pet_store/imports.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(cartItem.id),
        confirmDismiss: (_) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    content: const Text('Deseja remover o item do carrinho ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Não'),
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Sim'))
                    ],
                  ));
        },
        onDismissed: (_) {
          Provider.of<Cart>(context, listen: false)
              .removeItem(cartItem.productId);
        },
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: const Icon(Icons.delete, size: 40, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: FittedBox(
                    child: Text(
                      '${cartItem.price}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                cartItem.title,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Total R\$${cartItem.price * cartItem.quantity}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              trailing: Text(
                '${cartItem.quantity}x',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
