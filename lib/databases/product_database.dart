import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fit_club_bar/dtos/product_model.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init(); //This is a singleton class
  static Database? _database;//In this variable we will store the database

  ProductDatabase._init(); //This is the constructor of the class

  //This is the getter of the database
  Future<Database> get database async {
    if(_database != null) return _database!;//If the database is already created, we return it
    _database = await _initDB('products.db');//If the database is not created, we create it
    return _database!;
  }

  //This is the method that creates the database
  _initDB(String file) async {
    final dbPath = await getDatabasesPath(); //We get the path of the database
    final path = join(dbPath, file); //We join the path of the database with the name of the database
    return await openDatabase(path, version: 1, onCreate: _createDB); //We create the database
  }

  //This is the method that creates the table of the database
  Future _createDB(Database db, int version) async {
    await db.execute(
      ''' 
      CREATE TABLE $tableProduct(
        ${ProductField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ProductField.name} TEXT NOT NULL,
        ${ProductField.price} REAL NOT NULL,
        ${ProductField.stock} INTEGER NOT NULL
      )
      '''
    );
  }

  //This is the method that creates a product in the database
  Future<int> create(Product product) async {
    final db = await instance.database;
    return await db.insert(tableProduct, product.toJson());
  }

  //This is the method that reads all the products from the database
  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;
    final result = await db.query(tableProduct);//We get all the products from the database
    return result.map((mapProducts) => Product.fromJson(mapProducts)).toList();
  }

  //This method does a partial update of the product
  Future<void> updateProduct(int id, {String? name, double? price, int? stock}) async {
    final db = await instance.database;
    Map<String, dynamic> updateValues = {};

    if(name != null) updateValues[ProductField.name] = name;
    if(price != null) updateValues[ProductField.price] = price;
    if(stock != null) updateValues[ProductField.stock] = stock;

    await db.update(
      tableProduct, 
      updateValues, 
      where: '${ProductField.id} = ?', 
      whereArgs: [id]
      );
  }

  Future<void> deleteAt(int id) async {
    final db = await instance.database;
    await db.delete(
      tableProduct,
      where: '${ProductField.id} = ?',
      whereArgs: [id],
    );
  }


  //This is the method that closes the database
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}