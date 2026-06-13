import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';
import 'notification_service.dart';

class PeachPalette {
  static const Color primary = Color(0xFFFFAB76);
  static const Color light = Color(0xFFFFE5D9);
  static const Color dark = Color(0xFFE8834A);
  static const Color background = Color(0xFFFFF5EE);
  static const Color surface = Color(0xFFFFF0E5);
  static const Color textDark = Color(0xFF4E342E);
  static const Color textMedium = Color(0xFF6D4C41);
  static const Color accent = Color(0xFFFF6F3C);
  static const Color buttonDark = Color(0xFFE07A3A);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: MaterialApp(
        title: 'Counter Provider & Notifikasi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: PeachPalette.primary,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: PeachPalette.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: PeachPalette.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter & Notifikasi'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [PeachPalette.dark, PeachPalette.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Consumer<CounterProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nilai Counter',
                  style: TextStyle(
                    fontSize: 18,
                    color: PeachPalette.textMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [PeachPalette.light, PeachPalette.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PeachPalette.primary.withOpacity(0.45),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${provider.counter}',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        color: PeachPalette.textDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Tombol Tambah
                SizedBox(
                  width: 200,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: provider.increment,
                    icon: const Icon(Icons.add_circle_outline, size: 24),
                    label: const Text(
                      'Tambah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PeachPalette.accent,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Tombol Kurang
                SizedBox(
                  width: 200,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: provider.decrement,
                    icon: const Icon(Icons.remove_circle_outline, size: 22),
                    label: const Text(
                      'Kurang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PeachPalette.buttonDark,
                      side: const BorderSide(
                        color: PeachPalette.buttonDark,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Tombol Reset
                SizedBox(
                  width: 200,
                  height: 44,
                  child: TextButton.icon(
                    onPressed: provider.reset,
                    icon: const Icon(Icons.refresh, size: 20),
                    label: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: PeachPalette.textMedium,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Setiap kali tombol ditekan, notifikasi lokal akan muncul dengan nilai counter terbaru.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: PeachPalette.textMedium.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
