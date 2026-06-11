// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/counter_provider.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

void main() async {
  // Wajib dipanggil sebelum penggunaan plugin
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi notifikasi
  await NotificationService().initialize();

  runApp(
    // Wrap dengan ChangeNotifierProvider agar CounterProvider tersedia
    // di seluruh widget tree
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Provider App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
