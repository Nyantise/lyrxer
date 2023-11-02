import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/text.dart';
import 'package:lyrxer/states/file_watcher.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:window_manager/window_manager.dart';

class lyrxer extends StatefulWidget {
  const lyrxer({super.key});

  @override
  State<lyrxer> createState() => _lyrxerState();
}

class _lyrxerState extends State<lyrxer> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowResize() {
    if (mode.value == 1) {
      watchSizeAndPosition();
    }
  }

  @override
  void onWindowMove() {
    if (mode.value == 1) {
      watchSizeAndPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    setWindow();
    inTransition();
    return LayoutBuilder(
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
                      curve: Curves.elasticOut,
                      alignment: textAlign.value,
                      duration: const Duration(milliseconds: 1400),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        style: textStyle.value,
                        child: TextAnimator(
                          e.value,
                          initialDelay: const Duration(milliseconds: 0),
                          spaceDelay: const Duration(milliseconds: 0),
                          characterDelay: const Duration(milliseconds: 8),
                          incomingEffect:
                              WidgetTransitionEffects.incomingScaleUp(
                                  duration: const Duration(milliseconds: 100)),
                          outgoingEffect:
                              WidgetTransitionEffects.outgoingScaleUp(),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          );
        });
      },
    );
  }
}

getTextWidth(String text) {
  final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle.value,
      ),
      textDirection: TextDirection.ltr);
  tp.layout();
  return tp.width;
}

getLines(String text, BoxConstraints constraints) {
  List<String> words = text.trim().split(' ');

  List<String> currentLine = [];
  List<String> lines = [];

  for (String word in words) {
    List<String> fakeWordList = [...currentLine, word];
    String fakeLine = fakeWordList.join(' ');
    double fakeLineWidth = getTextWidth(fakeLine);

    if (fakeLineWidth > (constraints.maxWidth - 8)) {
      // Start a new line
      lines.add(currentLine.join(' '));
      currentLine = [];
    }

    currentLine.add(word);
  }

  // Add the last line
  lines.add(currentLine.join(' '));

  return lines;
}

void setWindow() async {
  var device = await screenRetriever.getPrimaryDisplay();
  if (size.value == defaultSize) {
    size.value = const Size(600, 400);
  }
  await windowManager.setMinimumSize(const Size(450, 280));
  await windowManager.setMaximumSize(device.size);
  await windowManager.setSize(size.value, animate: true);
  await Future.delayed(100.milliseconds);

  await windowManager.setPosition(position.value, animate: true);
}
