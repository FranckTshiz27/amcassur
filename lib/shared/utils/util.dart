class Util {
  // static NotificationType toNotificationType(String notificationTypeString) {
  //   NotificationType notificationType = NotificationType.TRAITEMENT_SINISTRE;
  //   if (notificationTypeString == NotificationType.TRAITEMENT_SINISTRE.name) {
  //     NotificationType notificationType = NotificationType.TRAITEMENT_SINISTRE;
  //   }
  //   return notificationType;
  // }

  static String removeDash(String input) {
    return input.replaceAll('-', '');
  }

  static String generateCurrentDateTimeString() {
    DateTime now = DateTime.now();
    String formattedDateTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_"
        "${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}";
    return formattedDateTime;
  }
}
