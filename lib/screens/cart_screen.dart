import 'package:fit_club_bar/providers/cart_provider.dart';
import 'package:fit_club_bar/widgets/product_list_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: FutureBuilder(
        future: Provider.of<CartProvider>(context, listen: false)
            .checkCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ProductListCart();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}