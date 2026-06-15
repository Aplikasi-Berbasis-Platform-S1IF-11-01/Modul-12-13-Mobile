import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel =
  AndroidNotificationChannel(
    'counter_channel',
    'Counter Notification',
    description: 'Notifikasi perubahan nilai counter',
    importance: Importance.max,
  );

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);

    // Buat notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Request permission Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotification(int counter) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'counter_channel',
      'Counter Notification',
      channelDescription: 'Notifikasi perubahan nilai counter',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      counter,
      'Counter Update',
      'Nilai counter saat ini: $counter',
      notificationDetails,
    );
  }
}