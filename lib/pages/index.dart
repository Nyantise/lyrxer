import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrxer/main.dart';
import 'package:lyrxer/pages/color_picker.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/pages/lyrxer.dart';

appRoutes() => [
      GetPage(name: '/', page: () => const Hello()),
      GetPage(
        name: '/lyrics',
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
        transition: Transition.fade,
        transitionDuration: 500.milliseconds,
        curve: Curves.easeOut,
      ),
      GetPage(
        name: '/color',
        page: () => const Center(
          child: MyColorPicker(),
        ),
        transition: Transition.fade,
        transitionDuration: 500.milliseconds,
        curve: Curves.easeOut,
      ),
      GetPage(
        name: '/font',
        page: () => Center(
            child: Text(
          modeTypes[3],
          style: const TextStyle(color: Colors.white),
        )),
        transition: Transition.fade,
        transitionDuration: 500.milliseconds,
        curve: Curves.easeOut,
      ),
    ];
