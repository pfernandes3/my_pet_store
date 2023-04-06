import 'package:my_pet_store/imports.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../widgets/cartItem.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.getCartItens.values.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Seu carrinho de compras'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  width: 20,
                  height: 50,
                ),
                Chip(
                  label: Text(
                    'R\$${cart.CartTotalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                 
                ),
                const Spacer(),
                ButtonOrder(cart: cart)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: cart.getCartItensCount,
          itemBuilder: (context, index) =>
              CartItemWidget(cartItem: cartItems[index]),
        ))
      ]),
    );
  }
}



class ButtonOrder extends StatefulWidget {
  const ButtonOrder({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<ButtonOrder> createState() => _ButtonOrderState();
}

class _ButtonOrderState extends State<ButtonOrder> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.CartTotalAmount == 0
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cart);
               

              setState(() {
                _isLoading = false;
              });

              widget.cart.clear();
            },
      style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary),
      child: _isLoading ? const CircularProgressIndicator() : const Text('COMPRAR'),
    );
  }
}
