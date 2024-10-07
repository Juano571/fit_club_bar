// class ProductCartField {
//   //name, selectedQuantity, price x selectedQuantity, stock - selectedQuantity, id
//   static const String id = '_id';
//   static const String name = 'name';
//   static const String selectedQuantity = 'selectedQuantity';
//   static const String totalPrice = 'totalPrice';
//   static const String currentStock = 'currentStock';
// }

class ProductCart {
  int id;
  String name;
  int quantity;
  double price;
  int currentStock;

  ProductCart({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.currentStock,
  });
}