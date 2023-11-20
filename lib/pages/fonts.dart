// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lyrxer/components/visualizer.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/focus.dart';
import 'package:lyrxer/states/text.dart';

class FontPage extends StatelessWidget {
  const FontPage({super.key});
  @override
  Widget build(BuildContext context) {
    inTransition();
    return const Stack(
      children: [
        Positioned(
          left: 8,
          top: 72,
          bottom: 10,
          child: FontPicker(),
        ),
        Visualizers()
      ],
    );
  }
}

class FontPicker extends StatelessWidget {
  const FontPicker({super.key});
  @override
  Widget build(BuildContext context) {
    inTransition();
    return FocusOutline(
      width: device.size.width / 100 * 42,
      height: device.size.height - 120,
      child: Obx(
        () => AnimatedOpacity(
            duration: pageTransition,
            opacity: transition.isTrue ? 1 : 0,
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 28,
                  ),
                  SvgPicture.asset(
                    'assets/w.svg',
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                        Get.isDarkMode ? Colors.white : Colors.black,
                        BlendMode.srcIn),
                  ),
                  CarouselSlider(
                    items: fontList.map((e) {
                      return Center(
                          child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: textStyle.value,
                      ));
                    }).toList(),
                    carouselController: fontCarousel,
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      scrollDirection: Axis.vertical,
                      enlargeCenterPage: true,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/s.svg',
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                        Get.isDarkMode ? Colors.white : Colors.black,
                        BlendMode.srcIn),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
