import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/config.dart';
import 'package:window_manager/window_manager.dart';

class MyColorPicker extends StatelessWidget {
  const MyColorPicker({super.key});
  @override
  Widget build(BuildContext context) {
    windowManager.setSize(const Size(480, 524));
    windowManager.setAlignment(Alignment.center);
    return Padding(
        padding: const EdgeInsets.only(top: 46),
        child: ColorPicker(
          color: Color(backgroundColor.value),
          onColorChanged: (Color color) {
            backgroundColor.value = color.value;
            isColorDark(color);
            updateConfig();
          },
          enableOpacity: true,
          pickersEnabled: const {
            ColorPickerType.wheel: true,
            ColorPickerType.primary: false,
            ColorPickerType.custom: false,
            ColorPickerType.bw: false,
            ColorPickerType.both: false,
            ColorPickerType.accent: false,
          },
          opacityTrackHeight: 10,
          showColorCode: true,
          showColorName: true,
          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              copyButton: true,
              copyFormat: ColorPickerCopyFormat.numHexAARRGGBB,
              ctrlC: true,
              ctrlV: true,
              autoFocus: true,
              pasteButton: true),
        ));
  }
}
