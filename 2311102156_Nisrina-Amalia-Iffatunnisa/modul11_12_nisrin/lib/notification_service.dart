import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Singleton pattern agar instance-nya hanya ada satu di aplikasi
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Pengaturan ikon notifikasi untuk Android (menggunakan ikon default bawaan aplikasi)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
        
    await _notificationsPlugin.initialize(initializationSettings);

    // Meminta izin notifikasi khusus untuk Android 13 ke atas (API 33+)
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Fungsi utama untuk memicu notifikasi dengan membawa nilai counter terbaru
  Future<void> showCounterNotification(int currentCounter) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'counter_channel_id',      // ID Channel (bebas)
      'Counter Notifications',    // Nama Channel di pengaturan HP
      channelDescription: 'Notifikasi saat counter bertambah',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0, // ID dari notifikasi (bisa diset tetap 0 agar menimpa notifikasi lama)
      'Counter Bertambah! ✨', 
      'Nilai counter sekarang: $currentCounter', // Teks dinamis sesuai nilai counter
      platformChannelSpecifics,
    );
  }
}