import 'package:flutter/material.dart';

import '../../configs/constants.dart';
import '../configs/appcolors.dart';

class MyRawsurStyle {
  static setTextFieldStyle(BuildContext context, String labelText,
      {Color? fillColor}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.DARK_BLUE,
        ), // Couleur de la bordure en focus
        borderRadius: appRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.WHITE,
        ), // Couleur de la bordure quand il est désactivé
        borderRadius: appRadius,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: AppColors.WHITE,
        fontFamily: 'Montserrat',
        fontSize: MediaQuery.of(context).size.width * .035,
        fontWeight: FontWeight.w700,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15,
      ),
      fillColor: fillColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: appRadius,
      ),
    );
  }

  static final ButtonStyle myCustomButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      AppColors.DARK_BLUE,
    ), // Change the color here
    foregroundColor: MaterialStateProperty.all(
      AppColors.WHITE,
    ),
    textStyle: MaterialStateProperty.all(
      TextStyle(
        color: AppColors.WHITE,
        fontSize: 12, // Change the font size here
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      ),
    ),
    elevation: MaterialStateProperty.all(3),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static final ButtonStyle myCustomButtonStyleAction = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      AppColors.BLUE,
    ), // Change the color here
    foregroundColor: MaterialStateProperty.all(
      AppColors.WHITE,
    ),
    textStyle: MaterialStateProperty.all(
      TextStyle(
          color: AppColors.WHITE,
          fontSize: 12, // Change the font size here
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700),
    ),
    elevation: MaterialStateProperty.all(3),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
