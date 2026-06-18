// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class NotificationService {
  static Future<void> initialize() async {
    if (html.Notification.permission != "granted") {
      await html.Notification.requestPermission();
    }
  }

  static void showNotification(int counter) {
    if (html.Notification.permission == "granted") {
      html.Notification(
        "Counter Updated 🚀",
        body: "Nilai counter sekarang adalah $counter",
      );
    }
  }
}
