import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/screens/add_product_screen.dart';
import 'package:fit_club_bar/widgets/product_list_inv.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                  _clearSearch();
                });
              },
              icon: !isSearch 
                  ? const Icon(Icons.search, size: 30,)
                  : const Icon(Icons.cancel, size: 30,),
            
            ),
          )
        ],
        title: !isSearch
            ? const Text('Inventory Screen')
            : TextField(
                controller: textSearchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Buscar productos...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    onPressed: () {
                      textSearchController.clear();
                      _clearSearch();
                    },
                    icon: const Icon(Icons.cancel, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                style: const TextStyle(fontSize: 18),
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
