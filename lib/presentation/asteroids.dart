import 'package:asteroids/application/particle_position_notifier.dart';
import 'package:asteroids/application/player_position_notifier.dart';
import 'package:asteroids/presentation/widgets/player_controller.dart';
import 'package:asteroids/presentation/widgets/game_timer.dart';
import 'package:asteroids/presentation/widgets/particle_painter.dart';
import 'package:flutter/material.dart';

class AsteroidsApp extends StatefulWidget {
  const AsteroidsApp({super.key});

  @override
  State<AsteroidsApp> createState() => _AsteroidsAppState();
}

class _AsteroidsAppState extends State<AsteroidsApp> {
  late ParticlePositionNotifier particleNotifier;
  late PlayerPositionNotifier playerPositionNotifier;
  @override
  void didChangeDependencies() {
    final size = MediaQuery.of(context).size;
    particleNotifier = ParticlePositionNotifier(size, []);
    playerPositionNotifier = PlayerPositionNotifier(
      Offset(size.width / 2, size.height / 2),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ParticlesRenderer(particleNotifier),
          PlayerControllerWidget(
            particlePositionNotifier: particleNotifier,
            playerPositionNotifier: playerPositionNotifier,
          ),
          Positioned(left: 10, top: 10, child: const GameTimer()),
        ],
      ),
    );
  }
}
