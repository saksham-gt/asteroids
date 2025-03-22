import 'package:asteroids/application/di.dart';
import 'package:flutter/material.dart';

class GameOverNotifier extends ValueNotifier<bool> {
  GameOverNotifier() : super(false) {
    restartGame();
  }

  Duration _currentRunDuration = Duration.zero;

  Duration get currentRunDuration => _currentRunDuration;

  void updateStatus(bool isGameOver) {
    _currentRunDuration = gameTimerNotifier.value;

    if (isGameOver != value) {
      value = isGameOver;
      notifyListeners();
    }
  }

  void restartGame() {
    _currentRunDuration = Duration.zero;
    value = false;
    notifyListeners();
  }
}
