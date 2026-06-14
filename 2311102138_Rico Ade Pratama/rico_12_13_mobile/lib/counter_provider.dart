import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
    NotificationService.showNotification(_counter);
  }

  void reset() {
    _counter = 0;
    notifyListeners();
    NotificationService.showNotification(_counter);
  }
}
