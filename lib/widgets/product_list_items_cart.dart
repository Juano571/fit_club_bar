import 'package:fit_club_bar/dtos/product_cart_model.dart';
import 'package:flutter/material.dart';

class ProductListItemsCart extends StatefulWidget {
  final List<ProductCart> products;
  const ProductListItemsCart({super.key, required this.products});

  @override
  State<ProductListItemsCart> createState() => _ProductListItemsCartState();
}

class _ProductListItemsCartState extends State<ProductListItemsCart> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.products[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Precio: \$${widget.products[index].price.toString()}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
      itemCount: widget.products.length,
    );
  }
}
