import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/config.dart';
import 'package:lyrxer/states/focus.dart';
import 'package:lyrxer/states/text.dart';

//Register all Keys
registerKeys() async {
  // directional
  await simpleKey(KeyCode.keyW, () {
    if (mode.value == 1) {
      changeSize(2);
    }
    if (mode.value == 3) {
      cycleFont(1);
    }
  });
  await simpleKey(KeyCode.keyS, () {
    if (mode.value == 1) {
      changeSize(-2);
    }
    if (mode.value == 3) {
      cycleFont(-1);
    }
  });
  await simpleKey(KeyCode.keyA, () {
    if (mode.value == 1) {
      changeAlign(-1);
    }
    if (mode.value == 2) {
      cycleColor(-1);
    }
  });
  await simpleKey(KeyCode.keyD, () {
    if (mode.value == 1) {
      changeAlign(1);
    }
    if (mode.value == 2) {
      cycleColor(1);
    }
  });

  // non-combinations
  await simpleKey(KeyCode.keyE, () {
    if (mode.value == 1 && stayFocused.isFalse) {
      return;
    }
    cycleMode(1);
  });
  await simpleKey(KeyCode.keyQ, () {
    if (mode.value == 1 && stayFocused.isFalse) {
      return;
    }
    cycleMode(-1);
  });
  // await simpleKey(KeyCode.keyT, () => goTo('lyrics'));
  // await simpleKey(KeyCode.keyC, () => goTo('color'));
  // await simpleKey(KeyCode.keyF, () => goTo('font'));

  await simpleKey(KeyCode.keyS, () async {
    saveSizeAndPosition();
    await updateConfig();
    Get.closeCurrentSnackbar();
    Get.snackbar('Saved', '',
        duration: 1500.milliseconds,
        animationDuration: 250.milliseconds,
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent,
        barBlur: 0,
        overlayBlur: 0,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Saved',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ));
  }, listModifiers: [KeyModifier.control]);
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
