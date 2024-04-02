// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_screen_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpScreenModel on _SignUpScreenModel, Store {
  late final _$userAtom =
      Atom(name: '_SignUpScreenModel.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SignUpScreenModel.isLoading', context: context);

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

  late final _$fieldErrorMessagesAtom =
      Atom(name: '_SignUpScreenModel.fieldErrorMessages', context: context);

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

  late final _$_SignUpScreenModelActionController =
      ActionController(name: '_SignUpScreenModel', context: context);

  @override
  void setFieldErrorMessages(String field, String errorMessage) {
    final _$actionInfo = _$_SignUpScreenModelActionController.startAction(
        name: '_SignUpScreenModel.setFieldErrorMessages');
    try {
      return super.setFieldErrorMessages(field, errorMessage);
    } finally {
      _$_SignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage(String field) {
    final _$actionInfo = _$_SignUpScreenModelActionController.startAction(
        name: '_SignUpScreenModel.clearErrorMessage');
    try {
      return super.clearErrorMessage(field);
    } finally {
      _$_SignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUser(User user) {
    final _$actionInfo = _$_SignUpScreenModelActionController.startAction(
        name: '_SignUpScreenModel.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$_SignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoading(bool isLoading) {
    final _$actionInfo = _$_SignUpScreenModelActionController.startAction(
        name: '_SignUpScreenModel.setIsLoading');
    try {
      return super.setIsLoading(isLoading);
    } finally {
      _$_SignUpScreenModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoading: ${isLoading},
fieldErrorMessages: ${fieldErrorMessages}
    ''';
  }
}
