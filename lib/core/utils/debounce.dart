import 'dart:async';
import 'package:flutter/foundation.dart';

/// Debouncer delays function execution until after a specified wait time has elapsed 
/// since the last time the function was called.
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
  
  void cancel() {
    _timer?.cancel();
  }
}
