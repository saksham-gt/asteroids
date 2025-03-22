import 'package:asteroids/application/di.dart';
import 'package:asteroids/application/game_timer_notifier.dart';
import 'package:flutter/material.dart';

// This widget keeps track of the time elapsed since the game started.
class GameTimer extends StatelessWidget {
  const GameTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ValueListenableBuilder(
        valueListenable: gameTimerNotifier,
        builder: (context, value, child) {
          return Text(
            'Time: ${value.formatDuration()}',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          );
        },
      ),
    );
  }
}
