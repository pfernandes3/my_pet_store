import 'package:flutter/material.dart';
import 'package:my_pet_store/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../widgets/OrderItem.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meus Pedidos'),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<Orders>(
              builder: (ctx, orders, child) {
                return ListView.builder(
                  itemCount: orders.itemsOrderCounts,
                  itemBuilder: (ctx, i) => OrderItem(order: orders.orders[i]),
                );
              },
            );
          }
        },
      ),
    );
    // body: _isLoading
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : ListView.builder(
    //         itemCount: orders.itemsOrderCounts,
    //         itemBuilder: (context, index) =>
    //             OrderItem(order: orders.orders[index])));
  }
}