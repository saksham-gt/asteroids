import 'dart:async';

import 'package:flutter/foundation.dart';

class GameTimerNotifier extends ValueNotifier<Duration> {
  late Timer timer;
  GameTimerNotifier() : super(Duration.zero) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      startTimer();
    });
  }

  void startTimer() {
    value = Duration.zero;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      incrementTimer();
    });
  }

  void incrementTimer() {
    value += const Duration(seconds: 1);
    notifyListeners();
  }

  void stopTimer() {
    timer.cancel();
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
