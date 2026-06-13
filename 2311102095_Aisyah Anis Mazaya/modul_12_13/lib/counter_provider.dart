import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  final NotificationService _notificationService = NotificationService();

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Memberitahu UI untuk melakukan pembangunan ulang (rebuild)
    _notificationService.showNotification(_counter); // Memicu notifikasi lokal
  }
}