import 'package:flutter/material.dart';

// count 类 混入
class Counter with ChangeNotifier {
  int value = 0;
  increment() {
    value++;
    notifyListeners(); // 通知听众， 局部刷新
  }
}