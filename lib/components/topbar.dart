// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/text.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color:
            mode.value == 1 ? Colors.transparent : Color(backgroundColor.value),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.help,
                    size: 21,
                  ),
                  Text(' help', style: appTextStyle.value),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 21,
                  ),
                  SvgPicture.asset(
                    'assets/q.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        Get.isDarkMode ? Colors.white : Colors.black,
                        BlendMode.srcIn),
                  ),
                  SizedBox(
                    height: 24,
                    width: 100,
                    child: CarouselSlider(
                        items: modeTypes.entries.map((e) {
                          return Text(
                            e.value.toString().toUpperCase(),
                            style: appTextStyle.value,
                          );
                        }).toList(),
                        disableGesture: true,
                        carouselController: myCarousel,
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          padEnds: true,
                          enlargeCenterPage: true,
                          enlargeFactor: 14,
                        )),
                  ),
                  SvgPicture.asset(
                    'assets/e.svg',
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
              Row(
                children: [
                  const Icon(
                    Icons.edit_note_outlined,
                    size: 21,
                  ),
                  Text(' Edit', style: appTextStyle.value),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
