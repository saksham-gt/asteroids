import 'package:asteroids/application/di.dart';
import 'package:asteroids/application/game_timer_notifier.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  GameOverScreen({super.key}) {
    gameTimerNotifier.stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "GAME OVER!",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "You lasted ${gameOverNotifier.currentRunDuration.formatDuration()} mins.",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                gameTimerNotifier.startTimer();
                gameOverNotifier.restartGame();
              },

              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text("Play again!", style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
