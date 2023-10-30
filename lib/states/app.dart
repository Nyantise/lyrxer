import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

// --------- AppState --------- //

RxBool isReady = false.obs;
Rx<ThemeMode> theme = ThemeMode.light.obs;

RxBool transition = false.obs;
Duration pageTransition = 400.milliseconds;

void inTransition() async {
  await Future.delayed(400.milliseconds);
  transition.value = true;
}

void outTransition() async {
  transition.value = false;
}

//Window
Size defaultSize = const Size(320, 320);
Rx<Size> size = defaultSize.obs;
Rx<Offset> position = const Offset(0, 0).obs;
RxDouble h = 0.0.obs;
RxDouble w = 0.0.obs;

void saveSizeAndPosition() async {
  size.value = await windowManager.getSize();
  position.value = await windowManager.getPosition();
}

void getSavedSizeAndPosition() async {
  print(size.value);
  print(position.value);
}

//Paging
Map modeTypes = {1: 'lyrics', 2: 'color', 3: 'font'};
RxInt mode = 0.obs;

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
  MapEntry a = modeTypes.entries.firstWhere((e) => e.key == mode.value);
  outTransition();
  await Future.delayed(500.milliseconds);
  Get.offAndToNamed('/${a.value}');
  // await updateConfig();
}
