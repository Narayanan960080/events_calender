import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  double get screenHeightSize => MediaQuery.of(this).size.height;
  double get screenWidthSize => MediaQuery.of(this).size.width;

  ThemeData get theme => Theme.of(this);
}

typedef IntCallback = void Function(int value);


