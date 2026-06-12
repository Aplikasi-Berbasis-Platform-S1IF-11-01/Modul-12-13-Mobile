import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;

    NotificationService.showNotification(
      title: 'Counter Update',
      body: 'Nilai counter saat ini: $_counter',
    );

    notifyListeners();
  }
}