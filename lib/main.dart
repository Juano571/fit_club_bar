import 'package:fit_club_bar/providers/product_provider.dart';
import 'package:fit_club_bar/screens/add_product_screen.dart';
import 'package:fit_club_bar/screens/cart_screen.dart';
import 'package:fit_club_bar/screens/edit_product_screen.dart';
import 'package:fit_club_bar/screens/inventory_screen.dart';
import 'package:fit_club_bar/screens/products_screen.dart';
import 'package:fit_club_bar/screens/sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Fit Club Bar',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 231, 228, 225),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.white, // Color de íconos seleccionados
            unselectedItemColor: Colors.grey, // Color de íconos no seleccionados
            elevation: 2.0,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black, // Color de fondo de la AppBar
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            iconTheme: IconThemeData(
              color: Colors.white, // Color de los íconos de la AppBar
            ), // Color del texto de la AppBar
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.black),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black, // Color de fondo del botón flotante
            foregroundColor: Colors.white,
            elevation: 1, // Color del ícono del botón flotante
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Colors.black),
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIconColor: Colors.black,
          ),
        ),
        initialRoute: MainWidget.routeName,
        routes: {
          MainWidget.routeName: (context) => const MainWidget(),
          AddProductScreen.routeName: (context) => const AddProductScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  static const routeName = '/';
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

/* 
  This is the main widget that will be displayed on the screen.
  It will contain the bottom navigation bar and the main widgets.
*/
class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = const [
    ProductsScreen(),
    InventoryScreen(),
    SaleScreen(),
    CartScreen(),
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'Productos',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_rounded),
              label: 'Inventario',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_rounded),
              label: 'Ventas',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrito',
              backgroundColor: Colors.black),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
