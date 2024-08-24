import 'package:flutter/services.dart';

class RigthTrimFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.trimRight(),
      selection: newValue.selection,
    );
  }
}
