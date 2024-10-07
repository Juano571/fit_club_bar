import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = 'add_product_screen';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey =
      GlobalKey<FormState>(); //This is the key of the form to validate it
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  // final FocusNode _priceFocusNode = FocusNode();
  // final FocusNode _stockFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    // _priceFocusNode.dispose();
    // _stockFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Producto'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: _nameController,
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre',
                prefixIcon: Icons.label,
                keyboardType: TextInputType.name,
                autofocus: true,
                textInputAction: TextInputAction.next,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                controller: _priceController,
                labelText: 'Precio',
                hintText: 'Precio en USD',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                // focusNode: _priceFocusNode,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_stockFocusNode);
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El precio es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                controller: _stockController,
                labelText: 'Stock',
                hintText: 'Cantidad en stock',
                prefixIcon: Icons.inventory,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                // focusNode: _stockFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El stock es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Producto añadido')));
                        Provider.of<ProductProvider>(context, listen: false)
                            .addProduct(
                          _nameController.text,
                          double.parse(_priceController.text),
                          int.parse(_stockController.text),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Añadir'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
