import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/widgets/product_list_items_inv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListInv extends StatefulWidget {
  const ProductListInv({super.key});

  @override
  State<ProductListInv> createState() => _ProductListInvState();
}

class _ProductListInvState extends State<ProductListInv> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child){
        return ProductListItemsInv(products: provider.products);
      }
    );
  }
}