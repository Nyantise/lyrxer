import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:window_manager/window_manager.dart';

//
//
//
// --------- Mouse and Focus --------- //

RxBool stayFocused = true.obs;
int saveLastMode = 0;

void switchFocus() {
  stayFocused.value = !stayFocused.value;
  if (!stayFocused.value) {
    saveLastMode = mode.value;
    goTo('Display');
  } else {
    MapEntry a = modeTypes.entries.firstWhere((e) => e.key == saveLastMode);
    if (saveLastMode != 1) {
      windowManager.setSize(device.size);
    }
    goTo(a.value);
  }
}

class FocusOutline extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const FocusOutline({
    super.key,
    required this.child,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    RxBool hover = false.obs;
    return GestureDetector(
      onDoubleTap: () => switchFocus(),
      child: MouseRegion(
        onEnter: (_) => hover.value = true,
        onExit: (_) => hover.value = false,
        child: Obx(
          () => AnimatedContainer(
              duration: 300.milliseconds,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                  color: stayFocused.value
                      ? Color(backgroundColor.value)
                      : Colors.transparent,
                  border: Border.all(
                    color: hover.value
                        ? Color(subcolor.value)
                        : Colors.transparent,
                  )),
              height: height,
              width: width,
              child: child),
        ),
      ),
    );
  }
}
