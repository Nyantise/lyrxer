import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';

class FontPage extends StatelessWidget {
  const FontPage({super.key});
  @override
  Widget build(BuildContext context) {
    inTransition();
    return Padding(
        padding: const EdgeInsets.only(top: 46),
        child: Obx(
          () => AnimatedOpacity(
              duration: pageTransition,
              opacity: transition.isTrue ? 1 : 0,
              child: const Text('Fonts')),
        ));
  }
}
