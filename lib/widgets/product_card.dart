import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final int stock;

  const ProductCard({
    required this.name,
    required this.price,
    required this.stock,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        elevation: 10,
        child: ListTile(
          title: Text(name),
          subtitle: Text(
            "Precio: $price            Stock: $stock",
          ),
        ),
      ),
    );
  }
}
