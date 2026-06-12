import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const Color primaryPink = Color(0xFFF48FB1);
const Color softPink    = Color(0xFFFCE4EC);
const Color deepPink    = Color(0xFFE91E8C);

// 1. PROVIDER
class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

// 2. NOTIFIKASI
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  // Android init
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  final androidPlugin = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await androidPlugin?.requestNotificationsPermission();
}

Future<void> showCounterNotification(int counterValue) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'counter_channel_id',
    'Counter Notifications',
    channelDescription: 'Notifikasi update nilai counter',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    ticker: 'Counter Update',
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Counter Update',
    'Nilai counter saat ini: $counterValue',
    notificationDetails,
  );
}

// 3. ENTRY POINT
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

// 4. APP ROOT
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryPink,
          primary: primaryPink,
        ),
        scaffoldBackgroundColor: softPink,
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

// 5. HALAMAN UTAMA
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softPink,
      appBar: AppBar(
        title: const Text(
          '🌸 Counter App',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card counter
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 36),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: primaryPink.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Nilai Counter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: deepPink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Consumer<CounterProvider>(
                    builder: (context, counterProvider, _) {
                      return Text(
                        '${counterProvider.counter}',
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: primaryPink,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 4,
                shadowColor: primaryPink.withOpacity(0.4),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                final provider =
                Provider.of<CounterProvider>(context, listen: false);
                provider.increment();
                await showCounterNotification(provider.counter);
              },
              icon: const Icon(Icons.add_rounded, size: 24),
              label: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}