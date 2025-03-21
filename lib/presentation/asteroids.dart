import 'package:asteroids/application/di.dart';
import 'package:asteroids/application/particle_position_notifier.dart';
import 'package:asteroids/domain/particle.dart';
import 'package:asteroids/presentation/widgets/game_timer.dart';
import 'package:asteroids/presentation/widgets/particle_painter.dart';
import 'package:asteroids/presentation/widgets/player_controller.dart';
import 'package:flutter/material.dart';

class AsteroidsApp extends StatefulWidget {
  final ParticlePositionNotifier particleNotifier;
  const AsteroidsApp({super.key, required this.particleNotifier});

  @override
  State<AsteroidsApp> createState() => _AsteroidsAppState();
}

class _AsteroidsAppState extends State<AsteroidsApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..repeat()
          ..addListener(widget.particleNotifier.updateParticles);
  }

  @override
  void dispose() {
    controller.dispose();
    gameTimerNotifier.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: widget.particleNotifier,
        builder: (BuildContext context, List<Particle> value, Widget? child) {
          return Stack(
            children: [
              const Positioned(left: 10, top: 10, child: GameTimer()),
              CustomPaint(painter: ParticlePainter(value), child: child),
              const PlayerControllerWidget(),
            ],
          );
        },
      ),
    );
  }
}
