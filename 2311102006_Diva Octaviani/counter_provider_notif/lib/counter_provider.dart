import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // ← memberitahu UI untuk rebuild
    NotificationService.showNotification(_counter); // ← kirim notifikasi
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
      NotificationService.showNotification(_counter);
    }
  }

  void reset() {
    _counter = 0;
    notifyListeners();
    NotificationService.showNotification(_counter);
  }
}