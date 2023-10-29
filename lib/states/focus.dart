import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/key_binds.dart';

//
//
//
// --------- Mouse and Focus --------- //

RxBool hover = false.obs;
RxBool stayFocused = true.obs;
int saveLastMode = 0;

void switchFocus() {
  stayFocused.value = !stayFocused.value;
  if (!stayFocused.value) {
    saveLastMode = mode.value;
    goTo('lyrics');
  } else {
    MapEntry a = modeTypes.entries.firstWhere((e) => e.key == saveLastMode);
    goTo(a.value);
  }
}

class MouseCatcher extends StatelessWidget {
  final Widget child;

  const MouseCatcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onDoubleTap: () => switchFocus(),
        child: MouseRegion(
            child: child,
            onEnter: (_) => hover.value = true,
            onExit: (_) => hover.value = false),
      ),
    );
  }
}
