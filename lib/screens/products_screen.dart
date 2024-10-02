import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/widgets/product_list_prod.dart';
import 'package:fit_club_bar/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isSearch = false;
  var textSearchController = TextEditingController();

  @override
  void initState() {
    textSearchController.addListener(_searchProducts);
    super.initState();
  }

  _clearSearch() {
    Provider.of<ProductProvider>(context, listen: false).clearSearch();
  }

  _searchProducts() {
    if (textSearchController.text.isNotEmpty) {
      Provider.of<ProductProvider>(context, listen: false)
          .searchProductsByName(textSearchController.text);
    } else {
      _clearSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchWidget(
            textSearchController: textSearchController,
            isSearch: isSearch,
            onSearchToggle: () {
              setState(() {
                isSearch = !isSearch;
                _clearSearch();
              });
            },
            clearSearch: _clearSearch
          ),
      ),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .checkProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ProductListProd();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
