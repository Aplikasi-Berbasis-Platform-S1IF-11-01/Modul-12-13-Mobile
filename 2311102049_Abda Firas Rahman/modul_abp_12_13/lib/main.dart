import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Inisialisasi awal plugin notifikasi
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
      
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    // Mendaftarkan Provider di root agar state bisa diakses di seluruh widget
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() async {
    _count++;
    // Memberitahu UI untuk me-render ulang nilai terbaru
    notifyListeners();
    // Memanggil fungsi notifikasi setiap kali state bertambah
    await _showNotification(_count);
  }

  Future<void> _showNotification(int currentCount) async {
    // Konfigurasi channel notifikasi
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'counter_channel_id', 
      'Counter Update Channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const NotificationDetails platformDetails = 
        NotificationDetails(android: androidDetails);

    // Menampilkan notifikasi lokal
    await flutterLocalNotificationsPlugin.show(
      0, 
      'Counter Update', 
      'Nilai counter saat ini: $currentCount', 
      platformDetails,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Praktik Provider & Notif',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca state/nilai counter dari Provider
    final counterProvider = Provider.of<CounterProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Counter & Notification',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: colorScheme.primary,
        elevation: 0, 
        centerTitle: true, 
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BAGIAN CARD ANGK
                Card(
                  elevation: 8,
                  shadowColor: colorScheme.shadow.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 30.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Tap:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            // Menampilkan nilai state yang diambil dari provider
                            '${counterProvider.count}',
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              color: colorScheme.primary,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 48), 
                
                // Menggunakan InkWell 
                InkWell(
                  onTap: () => counterProvider.increment(),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                    decoration: BoxDecoration(
                   
                      gradient: LinearGradient(
                        colors: [colorScheme.primary, Colors.blueAccent.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Agar lebar tombol menyesuaikan isi
                      children: const [
                        Icon(Icons.add_circle_rounded, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Tambah Counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}