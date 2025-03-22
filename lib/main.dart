import 'package:asteroids/application/di.dart';
import 'package:asteroids/presentation/asteroids.dart';
import 'package:asteroids/presentation/game_over_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeWidget()));
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gameOverNotifier,
      builder:
          (context, isGameOver, child) =>
              isGameOver ? GameOverScreen() : AsteroidsApp(),
    );
  }
}
