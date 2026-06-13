import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);

    // Buat channel untuk Android 8.0+
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'counter_channel',
      'Counter Updates',
      description: 'Notifikasi saat counter bertambah',
      importance: Importance.max,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Request izin notifikasi untuk Android 13+
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }
    }
  }

  static Future<void> showNotification(int value) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'counter_channel',
          'Counter Updates',
          channelDescription: 'Notifikasi saat counter bertambah',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      0,
      'Counter Update',
      'Nilai counter saat ini: $value',
      details,
    );
  }
}
