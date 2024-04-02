import 'dart:async';

import 'package:flutter/material.dart';

abstract class ISnackBarEvent {
  String? message;
  String? actionLabel;
  Function? action;
}

class SnackBarEvent extends ISnackBarEvent {
  @override
  final String? message;
  @override
  final String? actionLabel;
  @override
  final Function? action;
  SnackBarEvent({
    required this.message,
    required this.actionLabel,
    this.action,
  });
}

mixin SnackBarMixin {
  final StreamController<ISnackBarEvent> _snackBarController =
      StreamController<ISnackBarEvent>.broadcast();
  Stream<ISnackBarEvent> get snackBarStream => _snackBarController.stream;
  Sink<ISnackBarEvent> get snackBarSink => _snackBarController.sink;

  void dispose() {
    _snackBarController.close();
  }
}

class CustomSnackBar extends SnackBar {
  final String? message, actionLabel;
  final Function? callBack;
  CustomSnackBar({super.key, this.message, this.actionLabel, this.callBack})
      : super(
          content: Text(
            message!,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff6200EE),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          action: SnackBarAction(
            label: '',
            onPressed: () => callBack,
          ),
        );
}
