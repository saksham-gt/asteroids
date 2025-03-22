import 'dart:async';

import 'package:flutter/foundation.dart';

class GameTimerNotifier extends ValueNotifier<Duration> {
  late Timer _timer;

  GameTimerNotifier() : super(Duration.zero) {
    startTimer();
  }

  void startTimer() {
    value = Duration.zero;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _incrementTimer();
    });
  }

  void _incrementTimer() {
    value += const Duration(seconds: 1);
    notifyListeners();
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
