// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  Computed<double>? _$totalCostComputed;

  @override
  double get totalCost => (_$totalCostComputed ??=
          Computed<double>(() => super.totalCost, name: '_CartStore.totalCost'))
      .value;

  late final _$cartItemsAtom =
      Atom(name: '_CartStore.cartItems', context: context);

  @override
  List<Cart> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(List<Cart> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$_CartStoreActionController =
      ActionController(name: '_CartStore', context: context);

  @override
  void setCartItems(List<Cart> items) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.setCartItems');
    try {
      return super.setCartItems(items);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItems: ${cartItems},
totalCost: ${totalCost}
    ''';
  }
}
