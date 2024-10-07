import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/widgets/produt_list_items_prod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListProd extends StatefulWidget {
  const ProductListProd({super.key});

  @override
  State<ProductListProd> createState() => _ProductListProdState();
}

class _ProductListProdState extends State<ProductListProd> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child){
        return ProductListItemsProd(products: provider.products);
      }
    );
  }
}