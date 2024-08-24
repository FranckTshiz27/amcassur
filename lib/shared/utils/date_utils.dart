import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../configs/appcolors.dart';

class AMCassurDateUtils {
  static bool isDateInFormat(String date, String format) {
    try {
      // Essayez de convertir la chaîne en objet DateTime
      DateTime parsedDate = DateFormat(format).parse(date);

      // Si la conversion a réussi, cela signifie que la date respecte le format
      return true;
    } catch (e) {
      // En cas d'erreur, la date ne respecte pas le format
      return false;
    }
  }

  static int getAge(DateTime date) {
    return DateTime.now().year - date.year;
  }

  static String parseDateFr(String date, String format) {
    DateTime parsedDate = DateFormat(format, 'fr').parse(date);
    return DateFormat('dd MMMM yyyy', 'fr').format(parsedDate);
  }

  static String parseDateEn(String date, String format) {
    DateTime parsedDate = DateFormat(format, 'fr').parse(date);
    return DateFormat('yyyy-MM-dd', 'en').format(parsedDate);
  }

  static DateTime parseDateToDateTime(String date, String format) {
    DateTime parsedDate = DateFormat(format, 'fr').parse(date);
    return parsedDate;
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static bool adult(String dateString) {
    DateTime date = parseDateToDateTime(dateString, 'dd/MM/yyyy');
    int year = DateTime.now().year - date.year;
    if (year < 18) return false;
    if (year > 18) return true;
    if (year == 18) {
      int month = date.month - DateTime.now().month;
      if (month < 0) return false;
      if (month > 0) return true;
      if (month == 0) {
        int day = date.day - DateTime.now().day;
        if (day < 0) return false;
        if (day >= 0) return true;
      }
    }
    return false;
  }

  static Theme styleDatePicker(context, child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: AppColors.BLUE, // Couleur du bouton OK
        colorScheme: ColorScheme.light(
          primary: AppColors.BLUE,
        ), // Couleur de la date sélectionnée
        textSelectionTheme: TextSelectionThemeData(
          selectionColor:
              AppColors.BLUE, // Couleur du texte de la date sélectionnée
        ),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        dividerColor: AppColors.BLUE,
      ),
      child: child!,
    );
  }
}
