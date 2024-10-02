import 'package:flutter/material.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Sales Screen!'),
      ),
    );
  }
}