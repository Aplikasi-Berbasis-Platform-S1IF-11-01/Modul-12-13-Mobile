import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ==========================================================
// 1. NOTIFICATION SERVICE (Logika Notifikasi HP)
// ==========================================================
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
        
    await _notificationsPlugin.initialize(initializationSettings);

    // Meminta izin notifikasi untuk Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showCounterNotification(int currentCounter) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'counter_channel_id',
      'Counter Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      'Counter Bertambah! ✨',
      'Nilai counter sekarang: $currentCounter',
      platformChannelSpecifics,
    );
  }
}

// ==========================================================
// 2. COUNTER PROVIDER (Logika State Management)
// ==========================================================
class CounterProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Update angka di lingkaran secara real-time
    
    // Pemicu Notifikasi Lokal
    NotificationService().showCounterNotification(_counter);
  }
}

// ==========================================================
// 3. MAIN ENTRY POINT
// ==========================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Service Notifikasi
  await NotificationService().initNotification();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF5F5), // Background pink soft
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

// ==========================================================
// 4. UI SCREEN (Tampilan Aplikasi)
// ==========================================================
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER
              const Text(
                'counter_app ✨',
                style: TextStyle(
                  fontSize: 18, 
                  color: Color(0xFF8A7968), 
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 24),

              // CARD INFORMASI
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF0F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.auto_awesome, color: Color(0xFFFF4D7D)),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State Management & Notifikasi',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Provider menyimpan nilai counter & memicu Local Notification secara real-time.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              const Spacer(),

              // IDENTITAS (SEKARANG DI ATAS LINGKARAN)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F2).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.stars, color: Color(0xFFFF4D7D), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Nisrina Amalia Iffatunnisa | IF-11-REG01',
                      style: TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.w600, 
                        color: Color(0xFF555555)
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),

              // LINGKARAN COUNTER
              Center(
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFF6B97), width: 6),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6B97).withOpacity(0.2),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'NILAI COUNTER',
                        style: TextStyle(
                          color: Color(0xFFFF8FA3),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${counterProvider.counter}',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const Spacer(),

              // TOMBOL TAMBAH
              ElevatedButton(
                onPressed: () {
                  counterProvider.incrementCounter();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4D7D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'TAMBAH COUNTER',
                      style: TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.bold, 
                        letterSpacing: 0.5
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}