// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RetailerCheckinScreenModel on _RetailerCheckinScreenModel, Store {
  late final _$retailerAtom =
      Atom(name: '_RetailerCheckinScreenModel.retailer', context: context);

  @override
  Retailer? get retailer {
    _$retailerAtom.reportRead();
    return super.retailer;
  }

  @override
  set retailer(Retailer? value) {
    _$retailerAtom.reportWrite(value, super.retailer, () {
      super.retailer = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_RetailerCheckinScreenModel.isLoading', context: context);

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

  late final _$retailersAtom =
      Atom(name: '_RetailerCheckinScreenModel.retailers', context: context);

  @override
  List<Retailer> get retailers {
    _$retailersAtom.reportRead();
    return super.retailers;
  }

  @override
  set retailers(List<Retailer> value) {
    _$retailersAtom.reportWrite(value, super.retailers, () {
      super.retailers = value;
    });
  }

  late final _$userCheckinAtom =
      Atom(name: '_RetailerCheckinScreenModel.userCheckin', context: context);

  @override
  CheckIn? get userCheckin {
    _$userCheckinAtom.reportRead();
    return super.userCheckin;
  }

  @override
  set userCheckin(CheckIn? value) {
    _$userCheckinAtom.reportWrite(value, super.userCheckin, () {
      super.userCheckin = value;
    });
  }

  late final _$_RetailerCheckinScreenModelActionController =
      ActionController(name: '_RetailerCheckinScreenModel', context: context);

  @override
  void setIsLoading(bool isLoading) {
    final _$actionInfo = _$_RetailerCheckinScreenModelActionController
        .startAction(name: '_RetailerCheckinScreenModel.setIsLoading');
    try {
      return super.setIsLoading(isLoading);
    } finally {
      _$_RetailerCheckinScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRetailer(Retailer retailer) {
    final _$actionInfo = _$_RetailerCheckinScreenModelActionController
        .startAction(name: '_RetailerCheckinScreenModel.setRetailer');
    try {
      return super.setRetailer(retailer);
    } finally {
      _$_RetailerCheckinScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRetailers(List<Retailer> retailers) {
    final _$actionInfo = _$_RetailerCheckinScreenModelActionController
        .startAction(name: '_RetailerCheckinScreenModel.setRetailers');
    try {
      return super.setRetailers(retailers);
    } finally {
      _$_RetailerCheckinScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserChecking(CheckIn userCheckin) {
    final _$actionInfo = _$_RetailerCheckinScreenModelActionController
        .startAction(name: '_RetailerCheckinScreenModel.setUserChecking');
    try {
      return super.setUserChecking(userCheckin);
    } finally {
      _$_RetailerCheckinScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
retailer: ${retailer},
isLoading: ${isLoading},
retailers: ${retailers},
userCheckin: ${userCheckin}
    ''';
  }
}
