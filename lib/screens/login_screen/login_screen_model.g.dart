// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginScreenModel on _LoginScreenModel, Store {
  late final _$fieldErrorMessagesAtom =
      Atom(name: '_LoginScreenModel.fieldErrorMessages', context: context);

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

  late final _$_LoginScreenModelActionController =
      ActionController(name: '_LoginScreenModel', context: context);

  @override
  void setFieldErrorMessages(String field, String errorMessage) {
    final _$actionInfo = _$_LoginScreenModelActionController.startAction(
        name: '_LoginScreenModel.setFieldErrorMessages');
    try {
      return super.setFieldErrorMessages(field, errorMessage);
    } finally {
      _$_LoginScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage(String field) {
    final _$actionInfo = _$_LoginScreenModelActionController.startAction(
        name: '_LoginScreenModel.clearErrorMessage');
    try {
      return super.clearErrorMessage(field);
    } finally {
      _$_LoginScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fieldErrorMessages: ${fieldErrorMessages}
    ''';
  }
}
