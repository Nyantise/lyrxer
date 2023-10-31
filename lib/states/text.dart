import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyrxer/states/color.dart';

//
//
//
// --------- Text Style --------- //

Rx<Alignment> textAlign = Alignment.centerLeft.obs;

int alignState = 1;
Map textAlignTypes = {
  0: Alignment.centerLeft,
  1: Alignment.center,
  2: Alignment.centerRight,
};

Rx<TextStyle> textStyle =
    GoogleFonts.lato(color: const Color(0xffffffff), fontSize: 52.0).obs;
Rx<TextStyle> appTextStyle = GoogleFonts.lato(fontSize: 18.0).obs;
RxDouble textSize = 52.0.obs;
RxString textFont = 'Josefin Sans'.obs;

void updateTextStyle() {
  textStyle.value = GoogleFonts.getFont(fontList[0],
      color: Color(textColor.value), fontSize: textSize.value);
}

void changeAlign(int val) async {
  if ((alignState == 0 && val == -1) || (alignState == 2 && val == 1)) {
    return;
  }
  alignState += val;
  textAlign.value = textAlignTypes[alignState];
}

void changeSize(int val) async {
  textSize.value += val;
  updateTextStyle();
}

List fontList = [
  'Josefin Sans',
  'Oswald',
  'Handjet',
  'Flavors',
  'Poiret One',
  'Press Start 2P',
  'Lobster Two',
  'Montserrat Alternates',
  'Cinzel',
  'Amatic SC',
  'Metal Mania',
  'Permanent Marker',
  'Indie Flower',
  'Shadows Into Light',
  'Satisfy',
  'Sedgwick Ave Display',
  'Caveat',
  'Rajdhani',
  'Pacifico',
  'Space Grotesk',
  'Anton',
  'Nosifer',
  'Bebas Neue',
  'Quicksand',
];
