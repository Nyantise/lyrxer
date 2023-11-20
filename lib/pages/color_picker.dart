// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyrxer/components/visualizer.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/focus.dart';
import 'package:lyrxer/states/text.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});
  @override
  Widget build(BuildContext context) {
    inTransition();
    return const Stack(
      children: [
        Positioned(
          left: 8,
          top: 72,
          bottom: 10,
          child: MyColorPicker(),
        ),
        Visualizers()
      ],
    );
  }
}

//ColorPicker
class MyColorPicker extends StatelessWidget {
  const MyColorPicker({super.key});
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
            width: 100 * w.value, //Look Later
            height: 100 * h.value, //Look Later
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorPicker(
                  color: getColor(),
                  onColorChanged: (Color color) => changeColor(color),
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
                Text(
                  'CHANGE COLOR',
                  style: GoogleFonts.lato(fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      size: 21,
                    ),
                    SvgPicture.asset(
                      'assets/a.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                          Get.isDarkMode ? Colors.white : Colors.black,
                          BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 200,
                      height: 24,
                      child: CarouselSlider(
                          items: colorTypes.entries.map((e) {
                            return Text(
                              e.value.toString().toUpperCase(),
                              style: appTextStyle.value,
                            );
                          }).toList(),
                          disableGesture: true,
                          carouselController: colorCarousel,
                          options: CarouselOptions(
                            initialPage: colorMode.value - 1,
                            scrollDirection: Axis.horizontal,
                            padEnds: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 14,
                          )),
                    ),
                    SvgPicture.asset(
                      'assets/d.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                          Get.isDarkMode ? Colors.white : Colors.black,
                          BlendMode.srcIn),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 21,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5 * h.value, //Look Later
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getColor() {
  Map c = {1: backgroundColor.value, 2: subcolor.value, 3: textColor.value};
  return Color(c[colorMode.value]);
}

changeColor(Color color) {
  if (colorMode.value == 1) {
    backgroundColor.value = color.value;
    isColorDark(color);
  }
  if (colorMode.value == 2) {
    subcolor.value = color.value;
  }
  if (colorMode.value == 3) {
    textColor.value = color.value;
    updateTextStyle();
  }
}
