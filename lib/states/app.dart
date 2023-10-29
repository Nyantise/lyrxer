import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/config.dart';
import 'package:window_manager/window_manager.dart';

// --------- AppState --------- //

RxBool isReady = false.obs;
Rx<ThemeMode> theme = ThemeMode.light.obs;

//Window
Rx<Size> size = const Size(320, 320).obs;
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

void cycleMode() async {
  if (mode.value == modeTypes.length) {
    mode.value = 0;
  }
  mode.value++;
  MapEntry a = modeTypes.entries.firstWhere((e) => e.key == mode.value);
  Get.offAndToNamed('/${a.value}');
  await updateConfig();
}
