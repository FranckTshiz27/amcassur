import 'package:flutter/services.dart';

class TrimTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final trimmedText = newValue.text.trim();
    // Vérifier si le texte a été modifié
    if (newValue.text != trimmedText) {
      // Retourner une nouvelle valeur avec le texte trimmé
      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection.collapsed(offset: trimmedText.length),
      );
    }
    // Sinon, retourner la nouvelle valeur inchangée
    return newValue;
  }
}
