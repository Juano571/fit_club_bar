const String tableProduct = 'products';

class ProductField {
  static const String? id = '_id';
  static const String name = 'name';
  static const String price = 'price';
  static const String stock = 'stock';
  //static const String image = 'image';
}

class Product {
  int? id;
  String name;
  double price;
  int stock;
  //String image;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    //required this.image,
  });

  static Product fromJson(Map<String, Object?> json) => Product(
    id: json[ProductField.id] as int,
    name: json[ProductField.name] as String,
    price: json[ProductField.price] as double,
    stock: json[ProductField.stock] as int,
    //image: json[ProductField.image] as String,
  );

  //This is the method that converts a map to a product
  Map<String, Object?> toJson() => {
    ProductField.name: name,
    ProductField.price: price,
    ProductField.stock: stock,
    //ProductField.image: image,
  };
}
