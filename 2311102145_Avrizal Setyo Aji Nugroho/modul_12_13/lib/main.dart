import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';
import 'notification_service.dart';

// Nama : Avrizal Setyo Aji Nugroho
// NIM  : 2311102145
void main() async {
  // Memastikan binding Flutter siap sebelum inisialisasi async
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  runApp(
    // Membungkus aplikasi dengan ChangeNotifierProvider
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
      title: 'Praktik Modul 12 & 13',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider & Local Notification'),
        centerTitle: true,
        // TAMBAHKAN TOMBOL RESET DI SINI
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Counter',
            onPressed: () {
              // Memanggil fungsi reset
              Provider.of<CounterProvider>(context, listen: false).reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nilai Counter Saat Ini:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return Text(
                  '${counterProvider.count}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false).increment();
        },
        tooltip: 'Tambah Nilai',
        child: const Icon(Icons.add),
      ),
    );
  }
}
