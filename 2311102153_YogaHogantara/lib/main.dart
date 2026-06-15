import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ==========================================
// 1. Notification Service
// ==========================================
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  // Menggunakan icon bawaan aplikasi
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Meminta permission untuk Android 13+
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

Future<void> showCounterNotification(int counterValue) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'counter_channel',
    'Counter Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // ID Notifikasi
    'Counter Update', // Judul
    'Nilai counter saat ini: $counterValue', // Pesan
    notificationDetails,
  );
}

// ==========================================
// 2. CounterProvider
// ==========================================
class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Memperbarui UI
    showCounterNotification(
        _counter); // Memicu notifikasi setelah nilai bertambah
  }
}

// ==========================================
// 3. main()
// ==========================================
void main() async {
  // Pastikan binding Flutter sudah siap sebelum inisialisasi plugin
  WidgetsFlutterBinding.ensureInitialized();

  // Memanggil inisialisasi notifikasi sebelum app berjalan
  await initNotifications();

  runApp(
    // Membungkus seluruh widget tree dengan Provider
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

// ==========================================
// 4. MyApp
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Modul 12 & 13',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

// ==========================================
// 5. CounterPage
// ==========================================
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch<>() digunakan di build() agar UI otomatis update saat counter berubah
    final counter = context.watch<CounterProvider>().counter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider & Notifikasi'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nilai counter saat ini:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // context.read<>() digunakan karena kita hanya memanggil fungsi, bukan membaca state untuk UI
        onPressed: () => context.read<CounterProvider>().increment(),
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}
