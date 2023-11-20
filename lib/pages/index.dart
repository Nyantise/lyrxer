import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/main.dart';
import 'package:lyrxer/pages/color_picker.dart';
import 'package:lyrxer/pages/fonts.dart';
import 'package:lyrxer/pages/lyrxer.dart';

appRoutes() => [
      GetPage(name: '/', page: () => const Hello()),
      GetPage(
        name: '/Display',
        page: () => const lyrxer(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: '/Color',
        page: () => const Center(
          child: ColorPage(),
        ),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: '/Font',
        page: () => const Center(child: FontPage()),
        transition: Transition.noTransition,
      ),
    ];
