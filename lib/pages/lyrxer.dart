import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/text.dart';
import 'package:lyrxer/states/file_watcher.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class lyrxer extends StatelessWidget {
  const lyrxer({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          List<String> lines = getLines(hey.value, constraints);
          return SizedBox(
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
                        incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                            duration: const Duration(milliseconds: 100)),
                        outgoingEffect:
                            WidgetTransitionEffects.outgoingScaleUp(),
                      ),
                    ),
                  );
                }).toList()),
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
