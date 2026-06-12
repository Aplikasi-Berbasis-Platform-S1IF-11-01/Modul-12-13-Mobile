import 'dart:html' as html;

class NotificationService {
  static Future<void> initialize() async {
    if (html.Notification.permission != 'granted') {
      await html.Notification.requestPermission();
    }
  }

  static void showNotification({
    required String title,
    required String body,
  }) {
    if (html.Notification.permission == 'granted') {
      html.Notification(
        title,
        body: body,
      );
    }
  }
}