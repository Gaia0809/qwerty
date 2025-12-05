import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/main.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(itemProvider);
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Prodotti"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
      ),
      body: ListView(
        children:[

        for (final product in products)
          ListTile(
            title:Text(product.title),
            subtitle:Text("€ ${product.price.toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                ref.read(cartProvider.notifier).addProduct(product);
              },
            ),
          )],
      )
    );
  }
}