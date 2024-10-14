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
  
  // Sobrescribir == para comparar atributos
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCart &&
        other.id == id &&
        other.name == name &&
        other.price == price;
  }

  // Sobrescribir hashCode para que sea coherente con ==
  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'ProductCart(id: $id, name: $name, quantity: $quantity, price: $price, currentStock: $currentStock)';
  }
}