class StringUtil {
  static String removeDash(String input) {
    return input.replaceAll('-', '');
  }

  static String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String addSpaceEveryThreeChars(String input) {
    // Utilisation d'un StringBuffer pour construire la nouvelle chaîne
    StringBuffer result = StringBuffer();

    // Parcours de chaque caractère dans la chaîne d'entrée
    for (int i = 0; i < input.length; i++) {
      // Ajout du caractère actuel au StringBuffer
      result.write(input[i]);

      // Si l'index + 1 est divisible par 3 et ce n'est pas le dernier caractère, ajoutez un espace
      if ((i + 1) % 3 == 0 && i != input.length - 1) {
        result.write(' ');
      }
    }

    // Retourner la nouvelle chaîne construite
    return result.toString();
  }
}
