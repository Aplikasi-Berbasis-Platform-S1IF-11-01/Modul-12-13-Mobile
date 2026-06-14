import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );
  }

  static Future<void> requestPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotification(int counterValue) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'counter_channel',
        'Counter Notification',
        channelDescription: 'Notification when counter changes',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Counter Update',
      body: 'Nilai counter saat ini: $counterValue',
      notificationDetails: notificationDetails,
    );
  }

  static Future<void> showResetNotification() async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'counter_channel',
        'Counter Notification',
        channelDescription: 'Notification when counter changes',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id: 1,
      title: 'Counter Reset',
      body: 'Counter berhasil direset ke 0',
      notificationDetails: notificationDetails,
    );
  }
}
