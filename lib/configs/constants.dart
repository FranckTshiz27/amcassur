// ignore_for_file: constant_identifier_names

import 'package:amcassur/configs/appcolors.dart';
import 'package:flutter/material.dart';

// TextStyles
const TextStyleDrawer = TextStyle(
  color: Colors.white,
  fontSize: 15,
);

const TextStyleItemList = TextStyle(
  color: Colors.white,
  fontSize: 15,
);

const _GroupMenuTitleDrawer = TextStyle(
  color: AppColors.GRID,
  fontSize: 15,
);

const MenuTitleDrawer = Padding(
  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
  child: Text('Menu', style: _GroupMenuTitleDrawer),
);

const MenuAutresTitleDrawer = Padding(
  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
  child: Text('Autres', style: _GroupMenuTitleDrawer),
);

const kButtonText = TextStyle(
  color: Colors.black87,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

TextStyle styleAppBar = TextStyle(color: Colors.white, fontSize: 20);

const kBodyText2 =
    TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white);

const int sessionTimes = 5; // En minute

BorderRadius appRadius = BorderRadius.circular(10);

const baseUrl = "http://192.168.88.163:9002/api/";
