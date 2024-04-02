import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle screenTitleTextStyle = const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      labelTextStyle = const TextStyle(fontSize: 16, color: Color(0xff888888));

  static MaterialStateProperty<Color>? buttonBackgroundColor =
    MaterialStateProperty.all<Color>(const Color(0xff6200EE));
static MaterialStateProperty<Color>? buttonTextColor =
    MaterialStateProperty.all<Color>(const Color(0xffFFFFFF));
}
