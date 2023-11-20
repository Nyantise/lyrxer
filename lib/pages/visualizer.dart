import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/pages/lyrxer.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/file_watcher.dart';
import 'package:lyrxer/states/focus.dart';
import 'package:lyrxer/states/text.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class Visualizers extends StatelessWidget {
  const Visualizers({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 8,
        top: 72,
        bottom: 10,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visualizer1(
                    height: constraints.maxHeight / 2 - 4,
                  ),
                  Visualizer2(
                    height: constraints.maxHeight / 2 - 4,
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class Visualizer1 extends StatelessWidget {
  final double height;
  const Visualizer1({super.key, required this.height});
  @override
  Widget build(BuildContext context) {
    inTransition();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(subcolor.value), width: 1)),
      height: height,
      width: device.size.width / 100 * 56,
      child: visualizerBody,
    );
  }
}

class Visualizer2 extends StatelessWidget {
  final double height;
  const Visualizer2({super.key, required this.height});
  @override
  Widget build(BuildContext context) {
    inTransition();
    return FocusOutline(
      height: height,
      width: device.size.width / 100 * 56,
      child: visualizerBody,
    );
  }
}

LayoutBuilder visualizerBody = LayoutBuilder(
  builder: (context, constraints) {
    return Obx(() {
      List<String> lines = getLines(hey.value, constraints);
      return AnimatedOpacity(
        duration: pageTransition,
        opacity: transition.isTrue ? 1 : 0,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: lines.asMap().entries.map((e) {
                return AnimatedAlign(
                  curve: Curves.fastOutSlowIn,
                  alignment: textAlign.value,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    style: textStyle.value,
                    child: TextAnimator(
                      e.value,
                      initialDelay: const Duration(milliseconds: 0),
                      spaceDelay: const Duration(milliseconds: 0),
                      characterDelay: const Duration(milliseconds: 8),
                      incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                          duration: const Duration(milliseconds: 100)),
                      outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
                    ),
                  ),
                );
              }).toList()),
        ),
      );
    });
  },
);
