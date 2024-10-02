import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/screens/add_product_screen.dart';
import 'package:fit_club_bar/widgets/product_list_inv.dart';
import 'package:fit_club_bar/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
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
            return const ProductListInv();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
