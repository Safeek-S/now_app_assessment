import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _dbName = 'business_app_database.db';
  final int _dbVersion = 1;
  Database? _database;
  
  DatabaseHelper();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await getDatabase();
    return _database!;
  }

  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);
    return await openDatabase(path, version: _dbVersion,
        onCreate: (db, version) async{
      await db.execute('''
      CREATE TABLE Retailers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        company_name TEXT NOT NULL,
        phone_number TEXT,
        email TEXT,
        password TEXT,
        latitude REAL,
        longitude REAL,
        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME
      )
    ''');

      await db.execute('''
        CREATE TABLE Products (
          prodImage TEXT,
          id INTEGER PRIMARY KEY,
          prodCode TEXT,
          prodName TEXT,
          uom TEXT,
          catId INTEGER,
          underWarranty INTEGER,
          prodRkPrice TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE CheckIns (
          id TEXT  PRIMARY KEY,
          retailer_id TEXT  NOT NULL,
          user_id TEXT NOT NULL,
          check_in_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          latitude REAL,
          longitude REAL,
          updated_at DATETIME,
          FOREIGN KEY (retailer_id) REFERENCES Retailers(id)
          FOREIGN KEY (user_id) REFERENCES Users(id)
        )
      ''');
      await db.execute('''
      CREATE TABLE Users (
        id TEXT  PRIMARY KEY,
        name TEXT,
        email TEXT,
        password TEXT,
        latitude REAL,
        longitude REAL,
        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME
      )
    ''');
    await db.execute('''
    CREATE TABLE CartItems (
      id TEXT PRIMARY KEY,
      product_id INTEGER NOT NULL,
      quantity INTEGER NOT NULL DEFAULT 1,
      total_cost REAL,
      FOREIGN KEY (product_id) REFERENCES Products(id)
    )
    ''');
    });
  }
}
