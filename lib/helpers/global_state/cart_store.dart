import 'package:assessment/helpers/global_state/products_store.dart';
import 'package:mobx/mobx.dart';

import '../../models/cart_model.dart';
part 'cart_store.g.dart';
class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  List<Cart> cartItems = [];

  @computed
  double get totalCost {
    double total = 0.0;
    for (var item in cartItems) {
      double price = getProductPrice(item.productId!);
      total += price * item.quantity!;
    }
    return total;
  }

  double getProductPrice(int productId) {
     var product = ProductStoreSingleton.instance.store.products!.firstWhere((element) =>element.prodId == productId );
    return product.prodRkPrice!;
  }

  @action
  void setCartItems(List<Cart> items)  {
    cartItems = items;
   
  }

}

class CartStoreSingleton {
  static final CartStoreSingleton _instance = CartStoreSingleton._();

  static CartStoreSingleton get instance => _instance;

  final CartStore _store = CartStore();

  CartStoreSingleton._();

  CartStore get store => _store;
}