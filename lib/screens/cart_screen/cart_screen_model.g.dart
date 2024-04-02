// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartScreenModel on _CartScreenModel, Store {
  late final _$cartItemsAtom =
      Atom(name: '_CartScreenModel.cartItems', context: context);

  @override
  List<Product> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(List<Product> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$_CartScreenModelActionController =
      ActionController(name: '_CartScreenModel', context: context);

  @override
  void setCartItems(List<Product> products) {
    final _$actionInfo = _$_CartScreenModelActionController.startAction(
        name: '_CartScreenModel.setCartItems');
    try {
      return super.setCartItems(products);
    } finally {
      _$_CartScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItems: ${cartItems}
    ''';
  }
}
