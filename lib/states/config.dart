import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/text.dart';
import 'package:lyrxer/states/file_watcher.dart';

//
//
//
// --------- Configuration --------- //

toJson() {
  return {
    'text': {'textSize': textSize.value, 'alignState': alignState},
    'colors': {
      'theme': Get.isDarkMode ? 'dark' : 'light',
      'backgroundColor': backgroundColor.value,
      'subcolor': subcolor.value,
      'textColor': textColor.value
    },
    'window': {
      'width': size.value.width,
      'height': size.value.height,
      'x': position.value.dx,
      'y': position.value.dy
    }
  };
}

void fromYaml(Map conf) {
  var text = conf['text'];
  textSize.value = text['textSize'];
  alignState = text['alignState'];
  textAlign.value = textAlignTypes[alignState];
  updateTextStyle();

  var colors = conf['colors'];
  backgroundColor.value = colors['backgroundColor'];
  subcolor.value = colors['subcolor'];
  textColor.value = colors['textColor'];
  Get.changeThemeMode(
      colors['theme'] == 'dark' ? ThemeMode.dark : ThemeMode.light);

  var window = conf['window'];
  size.value = Size(window['width'], window['height']);
  position.value = Offset(window['x'], window['y']);
}

updateConfig() async {
  await yamlWrite(configFile, toJson());
  return true;
}
