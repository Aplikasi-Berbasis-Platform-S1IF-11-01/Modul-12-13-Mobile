import 'package:flutter/material.dart';

/// CounterProvider adalah kelas yang mengelola state (nilai counter)
/// menggunakan ChangeNotifier dari package Provider.
///
/// Setiap kali nilai counter berubah, notifyListeners() dipanggil
/// agar semua widget yang mendengarkan provider ini di-rebuild otomatis.
class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  /// Getter untuk mendapatkan nilai counter saat ini
  int get counter => _counter;

  /// Menambah nilai counter sebanyak 1 dan memberitahu semua listener
  void increment() {
    _counter++;
    notifyListeners(); // Memberi tahu semua Consumer/Selector untuk rebuild
  }

  /// Reset counter ke 0 (opsional)
  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
