import 'package:fit_club_bar/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:fit_club_bar/dtos/product_model.dart';


class ProductListItemsProd extends StatefulWidget {
  final List<Product> products;
  const ProductListItemsProd({super.key, required this.products});

  @override
  State<ProductListItemsProd> createState() => _ProductListItemsProdState();
}

class _ProductListItemsProdState extends State<ProductListItemsProd> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ProductCard(
              name: widget.products[index].name,
              price: widget.products[index].price,
              stock: widget.products[index].stock
            );
      },
      itemCount: widget.products.length,
    );
  }
}
