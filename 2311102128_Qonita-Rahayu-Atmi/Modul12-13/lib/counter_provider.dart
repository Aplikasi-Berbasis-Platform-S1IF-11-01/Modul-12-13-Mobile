// Qonita Rahayu Atmi - 2311102128

import 'package:flutter/material.dart';
import 'notification_service.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();

    NotificationService().showNotification(
      title: 'Counter Update',
      body: 'Nilai counter saat ini: $_counter',
    );
  }
}
