import 'package:fit_club_bar/dtos/product_cart_model.dart';
import 'package:fit_club_bar/providers/cart_provider.dart';
import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final double price;
  final int stock;
  final bool isAddCartEnabled;
  final int? id;

  const ProductCard({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.isAddCartEnabled,
    super.key,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedQuantity = 0;

  @override
  Widget build(BuildContext context) {
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
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Precio: \$${widget.price.toString()}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Stock: ${(widget.stock - selectedQuantity).toString()}",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.stock > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.isAddCartEnabled)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: selectedQuantity > 0
                            ? () {
                                setState(() {
                                  selectedQuantity--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                        color:
                            selectedQuantity > 0 ? Colors.black : Colors.grey,
                      ),
                      Text(
                        selectedQuantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: selectedQuantity < widget.stock
                            ? () {
                                setState(() {
                                  selectedQuantity++;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.add),
                        color: selectedQuantity < widget.stock
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: selectedQuantity > 0
                        ? () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addProduct(ProductCart(
                                    id: widget.id!,
                                    name: widget.name,
                                    quantity: selectedQuantity,
                                    price: widget.price,
                                    currentStock:
                                        widget.stock - selectedQuantity));
                            Provider.of<ProductProvider>(context, listen: false)
                                .updateProduct(
                                  widget.id!,
                                  stock: widget.stock - selectedQuantity
                                );

                            setState(() {
                              selectedQuantity = 0;
                            });
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Producto añadido')));
                          }
                        : null,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Añadir al carrito'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedQuantity > 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
