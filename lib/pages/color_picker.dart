import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

class MyColorPicker extends StatelessWidget {
  const MyColorPicker({super.key});
  @override
  Widget build(BuildContext context) {
    setWindow();
    inTransition();
    return Padding(
        padding: const EdgeInsets.only(top: 46),
        child: Obx(
          () => AnimatedOpacity(
            duration: pageTransition,
            opacity: transition.isTrue ? 1 : 0,
            child: ColorPicker(
              color: Color(backgroundColor.value),
              onColorChanged: (Color color) {
                backgroundColor.value = color.value;
                isColorDark(color);
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
            ),
          ),
        ));
  }
}

void setWindow() async {
  var device = await screenRetriever.getPrimaryDisplay();
  Size size = const Size(480, 524);
  await windowManager.setMinimumSize(size);
  await windowManager.setMaximumSize(size);
  await windowManager.setSize(size);

  double offX = (device.size.width - size.width) / 2;
  // double offY =
  await windowManager.setPosition(Offset(offX, 32));
}
