import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/main.dart';
import 'package:lyrxer/pages/color_picker.dart';
import 'package:lyrxer/pages/fonts.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/pages/lyrxer.dart';

appRoutes() => [
      GetPage(name: '/', page: () => const Hello()),
      GetPage(
        name: '/Display',
        page: () =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 3 * h.value,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: lyrxer(),
          )
        ]),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: '/Color',
        page: () => const Center(
          child: MyColorPicker(),
        ),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: '/Font',
        page: () => const Center(child: MyFontsPicker()),
        transition: Transition.noTransition,
      ),
    ];
