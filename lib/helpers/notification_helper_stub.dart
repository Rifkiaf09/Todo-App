class NotificationHelper {
  static Future<void> initialize() async {}
  static Future<void> showNotification(String title, String body, DateTime scheduledTime) async {}
  static void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) {}
}
