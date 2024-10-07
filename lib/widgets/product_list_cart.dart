import 'package:fit_club_bar/providers/cart_provider.dart';
import 'package:fit_club_bar/widgets/product_list_items_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListCart extends StatefulWidget {
  const ProductListCart({super.key});

  @override
  State<ProductListCart> createState() => _ProductListCartState();
}

class _ProductListCartState extends State<ProductListCart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, child){
        return ProductListItemsCart(products: provider.cartProducts);
      }
    );
  }
}