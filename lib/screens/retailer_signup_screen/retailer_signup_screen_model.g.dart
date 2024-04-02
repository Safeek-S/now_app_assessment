// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer_signup_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RetailerSignUpScreenModel on _RetailerSignUpScreenModel, Store {
  late final _$retailerAtom =
      Atom(name: '_RetailerSignUpScreenModel.retailer', context: context);

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

  late final _$fieldErrorMessagesAtom = Atom(
      name: '_RetailerSignUpScreenModel.fieldErrorMessages', context: context);

  @override
  Map<String, String> get fieldErrorMessages {
    _$fieldErrorMessagesAtom.reportRead();
    return super.fieldErrorMessages;
  }

  @override
  set fieldErrorMessages(Map<String, String> value) {
    _$fieldErrorMessagesAtom.reportWrite(value, super.fieldErrorMessages, () {
      super.fieldErrorMessages = value;
    });
  }

  late final _$_RetailerSignUpScreenModelActionController =
      ActionController(name: '_RetailerSignUpScreenModel', context: context);

  @override
  void setFieldErrorMessages(String field, String errorMessage) {
    final _$actionInfo = _$_RetailerSignUpScreenModelActionController
        .startAction(name: '_RetailerSignUpScreenModel.setFieldErrorMessages');
    try {
      return super.setFieldErrorMessages(field, errorMessage);
    } finally {
      _$_RetailerSignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage(String field) {
    final _$actionInfo = _$_RetailerSignUpScreenModelActionController
        .startAction(name: '_RetailerSignUpScreenModel.clearErrorMessage');
    try {
      return super.clearErrorMessage(field);
    } finally {
      _$_RetailerSignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRetailer(Retailer retailer) {
    final _$actionInfo = _$_RetailerSignUpScreenModelActionController
        .startAction(name: '_RetailerSignUpScreenModel.setRetailer');
    try {
      return super.setRetailer(retailer);
    } finally {
      _$_RetailerSignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
retailer: ${retailer},
fieldErrorMessages: ${fieldErrorMessages}
    ''';
  }
}
