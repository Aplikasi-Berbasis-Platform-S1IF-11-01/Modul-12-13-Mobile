import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {},
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CounterPage(),
      ),
    ),
  );
}

class CounterProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
    _showNotification(_counter);
  }

  Future<void> _showNotification(int count) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'channel_id',
          'Counter Channel',
          importance: Importance.max,
          priority: Priority.high,
        );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Counter Update',
      'Nilai counter saat ini: $count',
      const NotificationDetails(android: androidDetails),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan warna dominan ungu
    final Color primaryPurple = Colors.deepPurple;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "COUNTER APP",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(Icons.info_outline, color: primaryPurple),
                  title: const Text(
                    "State Management & Notifikasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Provider mengelola counter dan memicu notifikasi lokal.",
                  ),
                ),
              ),
              const Spacer(),

              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryPurple, width: 4),
                ),
                child: Column(
                  children: [
                    const Text(
                      "NILAI COUNTER",
                      style: TextStyle(letterSpacing: 1.5),
                    ),
                    Consumer<CounterProvider>(
                      builder: (context, provider, _) => Text(
                        '${provider.counter}',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: primaryPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.deepPurple.shade100),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.person, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kanasya Abdi Aziz",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "NIM: 2311102140 | IF-11-REG01",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => context.read<CounterProvider>().increment(),
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "TAMBAH COUNTER",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
