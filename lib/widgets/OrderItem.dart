  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order_provider.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.order});

  final Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
   
  @override
  Widget build(BuildContext context) {
    final double itemsHeight = (widget.order.products.length * 25) + 10;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? itemsHeight + 92 : 100,
      child: Card(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text('R\$${widget.order.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20)),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: IconButton(
                  icon: _expanded ? const Icon(Icons.expand_more) : const Icon(Icons.expand_less),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                      print(_expanded);
                    });
                  },
                ),
              ),
           
               AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                  height: _expanded? itemsHeight : 0,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: ListView(
                    children: widget.order.products.map((product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.quantity}x R\$ ${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
            ],
          )),
    );
  }
}