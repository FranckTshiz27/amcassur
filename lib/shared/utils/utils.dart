import 'package:flutter/material.dart';

void toast(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 700),
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
