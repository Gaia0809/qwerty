import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/router/router.dart';
import 'package:shopping_cart/models/models.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routerConfig: router,
    );
  }
}

final itemProvider = Provider<List<Product>>((ref) {
  return [
    Product(id: '1', title: 'Apple', price: 0.99),
    Product(id: '2', title: 'Banana', price: 0.59),
    Product(id: '3', title: 'Orange', price: 0.79),
    Product(id: '4', title: 'Grapes', price: 2.99),
    Product(id: '5', title: 'Mango', price: 1.49),
  ];
});

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

    void addProduct(Product product) {
      final index = state.indexWhere((item) => item.product.id == product.id);
      if (index >=0) {
        final updatedItem = [...state];
        updatedItem[index].quantity++;
        state = updatedItem;
      } else {
        state = [...state, CartItem(product: product)];
      }
    }

    void incrementItem(CartItem item) {
      item.quantity++;
      state = [...state];
    }

    void decrementItem(CartItem item) {
      if (item.quantity > 1) {
        item.quantity--;
        state = [...state];
      }else{
        state = state.where((i) => i.product.id != item.product.id).toList();
        }
      }
    }
final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);