import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

class MyFontsPicker extends StatelessWidget {
  const MyFontsPicker({super.key});
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
              child: Text('Fonts')),
        ));
  }
}

void setWindow() async {
  var device = await screenRetriever.getPrimaryDisplay();
  Size size = const Size(600, 400);
  appWindow.size = (size);
  await windowManager.setMinimumSize(size);
  await windowManager.setMaximumSize(size);
  await windowManager.setSize(size);

  double offX = (device.size.width - size.width) / 2;
  // double offY =
  await windowManager.setPosition(Offset(offX, 32));
}
