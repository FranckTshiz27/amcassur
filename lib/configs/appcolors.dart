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
  static const Color BLUE = Color(0xFF0C4592);
  static const Color YELLOW = Color(0xFFFFAF00);
  static const Color MAIN_COLOR = Color(0xFF272D8D);
  static const Color BAGROUND = Color.fromRGBO(162, 206, 240, 1);
  static const Color BAGROUND_DIALOG = Color.fromRGBO(238, 232, 244, 1);
  static const Color MAIN_COLOR_BASE = Color(0xFF1976D2);
  static const Color GREEN_COLOR = Color(0xFF80C038);
  static const Color MEATS = Color(0xFFC02828);
  // static const Color ERROR = Color.fromARGB(255, 158, 19, 9);
  static const Color ERROR = Color.fromARGB(255, 149, 11, 1);
  static const Color FRUITS = Color(0xFFC028BA);
  static const Color VEGS = Color(0xFF28C080);
  static const Color SEEDS = Color(0xFFC05D28);
  static const Color PASTRIES = Color(0xFF5D28C0);
  static const Color SPICES = Color(0xFF1BB1DE);
  static const Color GRID = Color(0xFFcccccc);
  static const Color WHITE = Color.fromARGB(255, 255, 255, 255);
  static const Color DARK_BLUE = Color.fromRGBO(8, 29, 133, 1.0);

  // other colors
  static const Color DARK_GREEN = Color(0xFF1B6948);
  static const Color DARKER_GREEN = Color(0xFF0B452C);
  static const Color HIGHTLIGHT_DEFAULT = Color(0xFF5A8E12);
  static const Color LIGHTER_GREEN = Color(0xFFC1E09E);
  static const Color LIGHTER_BLUE = Color.fromARGB(255, 27, 119, 210);

  //27, 119, 210
}
