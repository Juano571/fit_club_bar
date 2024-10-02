import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController textSearchController;
  final bool isSearch;
  final VoidCallback onSearchToggle;
  final VoidCallback clearSearch;

  const SearchWidget({
    super.key,
    required this.textSearchController,
    required this.isSearch,
    required this.onSearchToggle,
    required this.clearSearch,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: widget.isSearch
              ? TextField(
                  controller: widget.textSearchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Buscar productos...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        widget.textSearchController.clear();
                        widget.clearSearch();
                      },
                      icon: const Icon(Icons.cancel, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  style: const TextStyle(fontSize: 18),
                )
              : const Text('Productos'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              widget.onSearchToggle();
            },
            icon: widget.isSearch
                ? const Icon(Icons.cancel, size: 30)
                : const Icon(Icons.search, size: 30),
          ),
        ),
      ],
    );
  }
}
