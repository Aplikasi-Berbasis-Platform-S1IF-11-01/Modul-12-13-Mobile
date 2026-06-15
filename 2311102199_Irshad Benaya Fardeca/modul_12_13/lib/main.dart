import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

// ==========================================
// 1. NOTIFICATION SERVICE
// ==========================================
class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
    
    // Request permission for Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification(int value) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'counter_channel',
      'Counter Updates',
      importance: Importance.max,
      priority: Priority.high,
    );
    await _notificationsPlugin.show(
      0,
      'Counter Update',
      'Nilai counter saat ini: $value',
      const NotificationDetails(android: androidDetails),
    );
  }
}

// ==========================================
// 2. PROVIDER (STATE MANAGEMENT)
// ==========================================
class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  final NotificationService _notificationService = NotificationService();

  int get counter => _counter;

  CounterProvider() {
    _notificationService.initNotification();
  }

  void increment() {
    _counter++;
    notifyListeners();
    _notificationService.showNotification(_counter);
  }
}

// ==========================================
// 3. UI
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Praktik Modul 12 & 13',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Implementasi Provider dan Notifikasi pada Flutter'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // Menggunakan Consumer untuk mendengarkan perubahan state
            Consumer<CounterProvider>(
              builder: (context, provider, child) {
                return Text(
                  '${provider.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Memanggil fungsi increment dari Provider
          Provider.of<CounterProvider>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}