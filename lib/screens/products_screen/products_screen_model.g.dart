// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsScreenModel on _ProductsScreenModel, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ProductsScreenModel.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_ProductsScreenModelActionController =
      ActionController(name: '_ProductsScreenModel', context: context);

  @override
  void setIsLoading(bool isLoading) {
    final _$actionInfo = _$_ProductsScreenModelActionController.startAction(
        name: '_ProductsScreenModel.setIsLoading');
    try {
      return super.setIsLoading(isLoading);
    } finally {
      _$_ProductsScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
