import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.changeThemeMode(ThemeMode.light);
    return false;
  } else {
    Get.changeThemeMode(ThemeMode.dark);
    return true;
  }
}

Map colorTypes = {1: 'background', 2: 'outline', 3: 'display font'};
RxInt colorMode = 1.obs;
CarouselController colorCarousel = CarouselController();

void cycleColor(int direction) async {
  if (direction != -1 && direction != 1) {
    return;
  }
  if (colorMode.value == colorTypes.length && direction > 0) {
    colorMode.value = 0;
  }
  if (colorMode.value == 1 && direction < 0) {
    colorMode.value = colorTypes.length + 1;
  }
  colorMode.value += direction;
  colorCarousel.animateToPage(colorMode.value - 1,
      curve: Curves.elasticOut, duration: 700.milliseconds);
}
