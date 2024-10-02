import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/screens/edit_product_screen.dart';
import 'package:fit_club_bar/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:fit_club_bar/dtos/product_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ProductListItemsInv extends StatefulWidget {
  final List<Product> products;
  const ProductListItemsInv({super.key, required this.products});

  @override
  State<ProductListItemsInv> createState() => _ProductListItemsInvState();
}

class _ProductListItemsInvState extends State<ProductListItemsInv> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                                .deleteProduct(widget.products[index].id!);
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
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: widget.products[index]);
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Editar',
              ),
            ],
          ),
          child: ProductCard(
              name: widget.products[index].name,
              price: widget.products[index].price,
              stock: widget.products[index].stock
            ),
        );
      },
      itemCount: widget.products.length,
    );
  }
}
