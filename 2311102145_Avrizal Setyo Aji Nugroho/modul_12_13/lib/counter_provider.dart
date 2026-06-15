import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Memberitahu UI untuk memperbarui tampilan

    // Memicu local notification saat nilai bertambah
    NotificationService.showNotification(_count);
  }

  void reset() {
    _count = 0;
    notifyListeners(); // Refresh UI angka menjadi 0

    // Kirim notifikasi bahwa counter telah di-reset
    NotificationService.showNotification(_count);
  }
}
