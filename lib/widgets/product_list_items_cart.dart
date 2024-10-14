import 'package:fit_club_bar/dtos/product_cart_model.dart';
import 'package:fit_club_bar/providers/cart_provider.dart';
import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ProductListItemsCart extends StatefulWidget {
  final List<ProductCart> products;
  const ProductListItemsCart({super.key, required this.products});

  @override
  State<ProductListItemsCart> createState() => _ProductListItemsCartState();
}

class _ProductListItemsCartState extends State<ProductListItemsCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Slidable(
              key: Key(widget.products[index].id.toString()),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.55,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("¿Deseas eliminar este producto?"),
                          content: const Text("Esta acción no se puede deshacer"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Provider.of<ProductProvider>(context, listen: false)
                                .updateProduct(
                                  widget.products[index].id,
                                  stock: widget.products[index].quantity + widget.products[index].currentStock,
                                );
                                Provider.of<CartProvider>(context, listen: false)
                                    .removeProduct(widget.products[index]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Producto eliminado")),
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text("Eliminar"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancelar"),
                            ),
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Eliminar',
                  ),
                ],
              ),
              child: Card(
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
                          Text(
                            "Cantidad: ${widget.products[index].quantity.toString()}",
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
              ),
            );
          },
          itemCount: widget.products.length,
        ),
      ),
      Text('Total: \$${Provider.of<CartProvider>(context).totalAmount.toString()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
    ]);
  }
}
