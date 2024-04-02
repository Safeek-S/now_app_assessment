import 'package:mobx/mobx.dart';

import '../../models/product_model.dart';

part 'products_store.g.dart';
class ProductStore extends _ProductStore with _$ProductStore{}
abstract class _ProductStore with Store {
  

  @observable
  List<Product>? products;

  @action
  void setProducts(List<Product> products) {
    this.products = products;
  }
}

class ProductStoreSingleton {
  static final ProductStoreSingleton _instance = ProductStoreSingleton._();

  static ProductStoreSingleton get instance => _instance;

  final ProductStore _store = ProductStore();

  ProductStoreSingleton._();

  ProductStore get store => _store;
}