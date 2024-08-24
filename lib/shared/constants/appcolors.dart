// ignore_for_file: constant_identifier_names

import 'dart:core';

import 'package:flutter/material.dart';

class AppColors {
  static const Gradient APP_SCREENS = LinearGradient(
    colors: [
      Color.fromARGB(255, 16, 64, 157),
      Color.fromARGB(255, 25, 114, 191),
      Color.fromARGB(255, 24, 8, 133),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient POLICY_HEAD = LinearGradient(
    colors: [
      Color.fromRGBO(0, 163, 197, 1),
      Color.fromRGBO(17, 66, 159, 1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color MAIN_COLOR = Color.fromRGBO(48, 74, 149, 1);
  static const Color SECOND_COLOR = Color.fromRGBO(213, 48, 53, 1);
  static const Color THIRTH_COLOR_BASE = Color.fromRGBO(121, 55, 61, 1);
  static const Color BACKGROUND_COLOR = Color.fromRGBO(255, 255, 255, 1);
  static const Color TEXT_COLOR = Color.fromARGB(255, 0, 0, 0);

  static const Color MEATS = Color(0xFFC02828);
  static const Color FRUITS = Color(0xFFC028BA);
  static const Color VEGS = Color(0xFF28C080);
  static const Color SEEDS = Color(0xFFC05D28);
  static const Color PASTRIES = Color(0xFF5D28C0);
  static const Color SPICES = Color(0xFF1BB1DE);
  static const Color GRID = Color(0xFFcccccc);

  // other colors
  static const Color DARK_GREEN = Color(0xFF1B6948);
  static const Color DARKER_GREEN = Color(0xFF0B452C);
  static const Color HIGHTLIGHT_DEFAULT = Color(0xFF5A8E12);
  static const Color LIGHTER_GREEN = Color(0xFFC1E09E);
  static const Color LIGHTER_BLUE = Color.fromARGB(255, 27, 119, 210);

  //27, 119, 210
}
