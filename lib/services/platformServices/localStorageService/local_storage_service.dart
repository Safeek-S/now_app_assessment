import 'package:assessment/models/check_in_model.dart';
import 'package:assessment/models/product_model.dart';
import 'package:assessment/utils/service_result.dart';
import 'package:sqflite/sqflite.dart';

import '../../../database/database_helper.dart';
import '../../../models/cart_model.dart';
import '../../../models/retailer_model.dart';
import '../../../models/user_model.dart';

class LocalStorageService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<ServiceResult<int>> createRetailer(Retailer retailer) async {
    try {
      final db = await _databaseHelper.database;
      var res = await db.insert('Retailers', retailer.toJson());
      return ServiceResult(StatusCode.success, '', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<Retailer?>> findRetailerByEmail(String email) async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query('Retailers', where: 'email = ?', whereArgs: [email]);
      var retailer = maps.isNotEmpty ? Retailer.fromJson(maps.first) : null;
      if (retailer != null) {
        return ServiceResult(StatusCode.success, "Retailer found", retailer);
      } else {
        return ServiceResult(
            StatusCode.failure, "Retailer not found", retailer);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), null);
    }
  }

  Future<ServiceResult<List<Retailer>?>> getRetailers() async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> listOfRetailers =
          await db.query('Retailers');
      if (listOfRetailers.isNotEmpty) {
        var retailers = listOfRetailers
            .map((retailer) => Retailer.fromJson(retailer))
            .toList();
        return ServiceResult(
            StatusCode.success, "Retailers fetched", retailers);
      } else {
        return ServiceResult(StatusCode.failure, 'No Retailers', []);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), null);
    }
  }

  Future<ServiceResult<List<Product>?>> getProducts() async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> maps = await db.query('Products');
      var products = List.generate(maps.length, (i) => Product.fromDb(maps[i]));
      if (products.isNotEmpty) {
        return ServiceResult(StatusCode.success, "Products fetched", products);
      } else {
        return ServiceResult(StatusCode.failure, 'No Products found', []);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), []);
    }
  }

  Future<ServiceResult<int>> storeProducts(List<Product> products) async {
    try {
      final db = await _databaseHelper.database;
      await db.transaction((txn) async {
        for (var product in products) {
          await txn.insert(
            'Products',
            product.toDb(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      return ServiceResult(StatusCode.success, 'Stored Products', 1);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<int>> createCheckIn(CheckIn checkIn) async {
    try {
      final db = await _databaseHelper.database;
      var res = await db.insert('CheckIns', checkIn.toJson());
      return ServiceResult(
          StatusCode.success, 'User Checked into a retailer', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<List<CheckIn>>> getCheckIn() async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> checkInsList =
          await db.query('CheckIns');
      var checkIns = List.generate(
          checkInsList.length, (i) => CheckIn.fromJson(checkInsList[i]));
      if (checkIns.isNotEmpty) {
        return ServiceResult(StatusCode.success, 'Fetched CheckIns', checkIns);
      } else {
        return ServiceResult(StatusCode.failure, 'No CheckIns found', []);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), []);
    }
  }

  Future<ServiceResult<int>> createUser(User user) async {
    try {
      final db = await _databaseHelper.database;
      var res = await db.insert('Users', user.toJson());
      return ServiceResult(StatusCode.success, 'Created user', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<User?>> findUserByEmail(String email) async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query('Users', where: 'email = ?', whereArgs: [email]);
      var user = maps.isNotEmpty ? User.fromJson(maps.first) : null;
      if (user != null) {
        return ServiceResult(StatusCode.success, 'User found', user);
      } else {
        return ServiceResult(StatusCode.failure, 'User not found', user);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), null);
    }
  }

  Future<ServiceResult<User?>> findUserById(String id) async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query('Users', where: 'id = ?', whereArgs: [id]);
      var user = maps.isNotEmpty ? User.fromJson(maps.first) : null;
      if (user != null) {
        return ServiceResult(StatusCode.success, 'User found', user);
      } else {
        return ServiceResult(StatusCode.failure, 'User not found', user);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), null);
    }
  }

  Future<ServiceResult<int>> addToCart(Cart cart) async {
    try {
      final db = await _databaseHelper.getDatabase();
      var res = await db.insert(
        'CartItems',
        cart.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return ServiceResult(StatusCode.success, 'Added to Cart', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<List<Cart>?>> getCartItems() async {
    try {
      final db = await _databaseHelper.getDatabase();
      final List<Map<String, dynamic>> listOfCartItems =
          await db.query('CartItems');
      var cartItems = listOfCartItems.isNotEmpty
          ? listOfCartItems.map((e) => Cart.fromJson(e)).toList()
          : null;
      if (cartItems != null) {
        return ServiceResult(
            StatusCode.success, 'Returned Cart items', cartItems);
      } else {
        return ServiceResult(StatusCode.failure, 'No items in Cart', cartItems);
      }
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), null);
    }
  }

  Future<ServiceResult<int>> updateCart(Cart item) async {
    try {
      final db = await _databaseHelper.getDatabase();
      var res = await db.update(
        'CartItems',
        item.toJson(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
      return ServiceResult(StatusCode.success, 'Cart Item updated', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<int>> deleteCart(String id) async {
    try {
      final db = await _databaseHelper.getDatabase();
      var res = await db.delete(
        'CartItems',
        where: 'id = ?',
        whereArgs: [id],
      );
      return ServiceResult(StatusCode.success, 'Cart Item Removed', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }

  Future<ServiceResult<int>> deleteUserCheckIn(String userId) async {
    try {
      final db = await _databaseHelper.getDatabase();
      var res = await db.delete(
        'CheckIns',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return ServiceResult(StatusCode.success, 'User Check In Removed', res);
    } catch (e) {
      return ServiceResult(StatusCode.error, e.toString(), -99);
    }
  }
}
