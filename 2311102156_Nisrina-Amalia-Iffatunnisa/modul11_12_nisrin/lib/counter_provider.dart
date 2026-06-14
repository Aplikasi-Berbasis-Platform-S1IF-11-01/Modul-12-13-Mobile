import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider with ChangeNotifier {
  int _counter = 0;

  // Getter untuk mengambil nilai counter di UI
  int get counter => _counter;

  // Fungsi untuk menambah counter dan langsung memicu notifikasi lokal
  void incrementCounter() {
    _counter++;
    notifyListeners(); // Mengubah angka 1 di dalam lingkaran secara real-time

    // Pemicu otomatis: kirim nilai terbaru ke status bar HP
    NotificationService().showCounterNotification(_counter);
  }
}