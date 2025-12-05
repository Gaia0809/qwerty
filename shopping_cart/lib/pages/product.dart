import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/main.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cartItems = ref.watch(cartProvider);

    int totalItems = 0;
    for (var item in cartItems) {
      totalItems += item.quantity;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prodotti"),
        actions: [
          Center(
            child: Text(
              totalItems.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.price.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                ref.read(cartProvider.notifier).addProduct(product);
              },
            ),
          );
        },
      ),
    );
  }
}