import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

// --------- AppState --------- //

RxBool isReady = false.obs;
RxBool transition = false.obs;
Duration pageTransition = 400.milliseconds;

void inTransition() async {
  await Future.delayed(pageTransition);
  transition.value = true;
}

void outTransition() async {
  transition.value = false;
}

//Window
Size defaultSize = const Size(320, 320);
Rx<Size> size = defaultSize.obs;
Rx<Size> tempSize = defaultSize.obs;
Rx<Offset> position = const Offset(0, 0).obs;
Rx<Offset> tempPosition = const Offset(0, 0).obs;
RxDouble h = 0.0.obs;
RxDouble w = 0.0.obs;

void watchSizeAndPosition() async {
  tempSize.value = await windowManager.getSize();
  tempPosition.value = await windowManager.getPosition();
}

void saveSizeAndPosition() async {
  size.value = tempSize.value;
  position.value = tempPosition.value;
}

//Paging
Map modeTypes = {1: 'Display', 2: 'Color', 3: 'Font'};
RxInt mode = 0.obs;
CarouselController myCarousel = CarouselController();

void cycleMode(int direction) async {
  if (direction != -1 && direction != 1) {
    return;
  }
  if (mode.value == modeTypes.length && direction > 0) {
    mode.value = 0;
  }
  if (mode.value == 1 && direction < 0) {
    mode.value = modeTypes.length + 1;
  }
  mode.value += direction;
  myCarousel.animateToPage(mode.value - 1,
      curve: Curves.elasticOut, duration: 700.milliseconds);
  MapEntry a = modeTypes.entries.firstWhere((e) => e.key == mode.value);
  outTransition();
  await Future.delayed(pageTransition + 100.milliseconds);
  Get.offAndToNamed('/${a.value}');
}

void goTo(String route) {
  MapEntry a = modeTypes.entries.firstWhere((e) => e.value == route);
  if (mode.value == a.key) {
    return;
  }
  mode.value = a.key;

  Get.offAndToNamed('/$route');
}
