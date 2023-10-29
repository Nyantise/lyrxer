import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';

//
//
//
// --------- Color --------- //

Rx<int> backgroundColor = 0xC7050820.obs;
Rx<int> subcolor = 0xffffffff.obs;
Rx<int> textColor = 0xffffffff.obs;

isColorDark(Color myColor) {
  int g = myColor.green;
  int b = myColor.blue;
  int r = myColor.red;

  double grayscale = (0.299 * r) + (0.587 * g) + (0.114 * b);
  if (grayscale > 160) {
    theme.value = ThemeMode.light;
    return false;
  } else {
    theme.value = ThemeMode.dark;
    return true;
  }
}
