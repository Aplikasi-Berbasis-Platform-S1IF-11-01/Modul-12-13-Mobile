import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Counter & Notification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Mengaktifkan desain Material 3 
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF48FB1),
          background: const Color(0xFFFFF0F5), 
        ),
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5), // Background halaman
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        title: const Text(
          'Tugas Modul 12 & 13',
          style: TextStyle(
            color: Color(0xFF880E4F), 
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Membuat layout kartu (Card) dengan efek bayangan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF48FB1).withOpacity(0.4),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Ikon lonceng dekoratif
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE4EC),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications_active_rounded,
                        size: 40,
                        color: Color(0xFFF06292),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Total Tap Saat Ini',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Konsumen nilai counter
                    Consumer<CounterProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          '${provider.counter}',
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFD81B60),
                            height: 1.1,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), 
            ],
          ),
        ),
      ),
      // Tombol melayang diposisikan di tengah bawah dengan ukuran lebih lebar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        height: 60,
        child: FloatingActionButton.extended(
          onPressed: () {
            context.read<CounterProvider>().incrementCounter();
          },
          backgroundColor: const Color(0xFFD81B60), // Warna tombol solid
          foregroundColor: Colors.white,
          elevation: 8,
          icon: const Icon(Icons.add_circle_outline_rounded, size: 28),
          label: const Text(
            'TAMBAH COUNTER',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}