import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/text.dart';

//Register all Keys
registerKeys() async {
  // directional
  await simpleKey(KeyCode.arrowUp, () => changeSize(2));
  await simpleKey(KeyCode.arrowDown, () => changeSize(-2));
  await simpleKey(KeyCode.arrowLeft, () => changeAlign(-1));
  await simpleKey(KeyCode.arrowRight, () => changeAlign(1));
  await simpleKey(KeyCode.keyW, () => changeSize(2));
  await simpleKey(KeyCode.keyS, () => changeSize(-2));
  await simpleKey(KeyCode.keyA, () => changeAlign(-1));
  await simpleKey(KeyCode.keyD, () => changeAlign(1));

  // non-combinations
  await simpleKey(KeyCode.keyE, () => cycleMode());
  await simpleKey(KeyCode.keyT, () => goTo('lyrics'));
  await simpleKey(KeyCode.keyC, () => goTo('color'));
  await simpleKey(KeyCode.keyF, () => goTo('font'));

  await simpleKey(KeyCode.keyS, () => saveSizeAndPosition(),
      listModifiers: [KeyModifier.control]);
  await simpleKey(KeyCode.keyE, () => getSavedSizeAndPosition(),
      listModifiers: [KeyModifier.control]);
}

simpleKey(KeyCode _keycode, VoidCallback _action,
    {List<KeyModifier>? listModifiers}) async {
  var button =
      HotKey(_keycode, scope: HotKeyScope.inapp, modifiers: listModifiers);

  await hotKeyManager.register(
    button,
    keyDownHandler: (hkey) => _action(),
  );
}

void goTo(String route) {
  MapEntry a = modeTypes.entries.firstWhere((e) => e.value == route);
  if (mode.value == a.key) {
    return;
  }
  mode.value = a.key;

  Get.offAndToNamed('/$route');
}
