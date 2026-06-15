import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// =================================================================
// 1. NOTIFICATION SERVICE
// =================================================================
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotification(int counterValue) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'counter_channel_id',
      'Counter Updates',
      channelDescription: 'Memberitahu pengguna saat nilai counter berubah',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, 
      'Counter Update', 
      'Nilai counter saat ini: $counterValue', 
      platformDetails,
    );
  }
}

// =================================================================
// 2. STATE MANAGEMENT PROVIDER
// =================================================================
class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
    NotificationService.showNotification(_count);
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

// =================================================================
// 3. MAIN ENTRY POINT
// =================================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

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
      title: 'Tugas Modul 12 & 13',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Sans-Serif', // Menggunakan font bawaan sistem yang bersih
      ),
      home: const CounterScreen(),
    );
  }
}

// =================================================================
// 4. USER INTERFACE (Sesuai Struktur Mockup dengan Warna Baru)
// =================================================================
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Palet Warna Baru (Teal & Slate)
    const Color backgroundColor = Color(0xFFF0F5F5); // Abu-abu kehijauan sangat terang
    const Color cardColor = Colors.white;
    const Color primaryTeal = Color(0xFF008080);     // Warna Teal untuk angka & tombol tambah
    const Color secondarySlate = Color(0xFF607D8B);  // Warna Slate untuk teks & tombol reset

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Bagian Header (Judul & Badge Status) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Counter',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238), // Dark Slate
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryTeal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.notifications_active, size: 16, color: primaryTeal),
                        SizedBox(width: 4),
                        Text(
                          'Aktif',
                          style: TextStyle(
                            color: primaryTeal,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const Spacer(),

              // --- Bagian Utama (Card Display Angka Counter) ---
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'NILAI SAAT INI',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: secondarySlate,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Consumer<CounterProvider>(
                        builder: (context, counterProvider, child) {
                          return Text(
                            '${counterProvider.count}',
                            style: const TextStyle(
                              fontSize: 96,
                              fontWeight: FontWeight.bold,
                              color: primaryTeal,
                              height: 1.0,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // --- Bagian Bawah (Tombol Aksi) ---
              Row(
                children: [
                  // Tombol Reset
                  Expanded(
                    flex: 4,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Provider.of<CounterProvider>(context, listen: false).reset();
                      },
                      icon: const Icon(Icons.refresh, color: secondarySlate),
                      label: const Text(
                        'Reset',
                        style: TextStyle(
                          color: secondarySlate,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: secondarySlate.withOpacity(0.4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Tombol Tambah
                  Expanded(
                    flex: 6,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<CounterProvider>(context, listen: false).increment();
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Tambah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryTeal,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              // Keterangan teks paling bawah
              const Center(
                child: Text(
                  'Notifikasi akan muncul setiap penambahan',
                  style: TextStyle(
                    color: secondarySlate,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}