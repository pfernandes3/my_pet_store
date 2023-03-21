import 'package:flutter/material.dart';
import 'package:my_pet_store/models/pet_products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(product.title,style: const TextStyle(fontSize: 25),),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Price - R\$${product.price}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
